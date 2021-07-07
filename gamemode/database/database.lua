local ply = FindMetaTable("Player")
util.AddNetworkString("visl_database")
util.AddNetworkString("visl_inventory_drop")
util.AddNetworkString("visl_inventory_use")
util.AddNetworkString("visl_inventory_purchase")

local govJobs = {1,2,3,4,5,6,7}

function ply:ShortSteamID()
    local id = self:SteamID()
    local id = tostring(id)
    local id = string.Replace(id, "STEAM_0:0:", "")
    local id = string.Replace(id, "STEAM_0:1:", "")
    return id
end

local oldPrint = print
local function print(s)
    oldPrint("database.lua: " .. s)
end

function ply:databaseDefault()
    local i = {}
    i["takeoutbox"] = {amount = 5}
    i["energydrink"] = {amount = 5}
    self:databaseSetValue("inventory", i)
end

function ply:databaseFolders()
    return "server/stats/players/" .. self:ShortSteamID() .. "/"
end

function ply:databasePath()
    return self:databaseFolders() .. "database.txt"
end

function ply:databaseSet(table)
    self.database = table
end

function ply:databaseGet()
    return self.database
end

function ply:databaseSend()
    net.Start("visl_database")
    net.WriteTable(self:databaseGet())
    net.Send(self)
end

function ply:databaseExists()
    local f = file.Exists(self:databasePath(), "DATA")
    return f
end

function ply:databaseRead()
    local str = file.Read(self:databasePath(), "DATA")
    self:databaseSet(util.KeyValuesToTable(str))
end

function ply:databaseSave()
    local str = util.TableToKeyValues(self.database)
    local f = file.Write(self:databasePath(), str)
    self:databaseSend()
end

function ply:databaseCreate()
    self:databaseDefault()
    local b = file.CreateDir(self:databaseFolders())
    self:databaseSave()
end

function ply:databaseDisconnect()
    self:databaseSave()
end

function ply:databaseSetValue(name, v)
    if not v then return end
    if type(v) == "table" then
        if name == "inventory" then
            for k,b in pairs(v) do
                if b.amount <=0 then
                    v[k] = nil
                end
            end
        end
    end
    local d = self:databaseGet()
    d[name] = v
    self:databaseSave()
end

function ply:databaseGetValue(name)
    local d = self:databaseGet()
    return d[name]
end

function ply:databaseCheck()
    self.database = {}
    local f = self:databaseExists()
    if (f) then
        self:databaseRead()
    else
        self:databaseCreate()
    end
    self:databaseSend()
end

function GM:ShowHelp(ply)
    --ply:ConCommand("inventory")
end

function ply:inventorySave(inventory)
    if not inventory then return end
    self:databaseSetValue("inventory", inventory)
end

function ply:inventoryGet()
    local inventory = self:databaseGetValue("inventory")
    return inventory
end

function ply:inventoryHasItem(name, amount)
    if !amount then amount = 1 end
    local inventory = self:inventoryGet()

    if inventory then
        if inventory[name] then
            if inventory[name].amount >= amount then
                return true
            else
                return false
            end
        else
            return false
        end
    else
        return false
    end
end

function ply:inventoryTakeItem (name, amount)
    if not amount then amount = 1 end

    local inventory = self:inventoryGet()

    if self:inventoryHasItem(name, amount) then
        inventory[name].amount = inventory[name].amount - amount
        self:inventorySave(inventory)
        self:databaseSend()
        return true
    else
        return false
    end
end

function ply:inventoryGiveItem(name, amount)
    if not amount then amount = 1 end

    local inventory = self:inventoryGet()
    local item = getItems(name)

    if not item then return end

    -- if amount == 1 then
    --     self:PrintMessage(HUD_PRINTTALK, "You received a/an "..item.name)
    -- elseif amount > 1 then
    --     self:PrintMessage(HUD_PRINTTALK, "You received a/an "..item.name.."es/s")
    -- end

    if self:inventoryHasItem(name, amount) then
        inventory[name].amount = inventory[name].amount + amount
    else
        inventory[name] = {amount = amount}
    end

    self:inventorySave(inventory)
    self:databaseSend()
end

net.Receive("visl_inventory_purchase", function(len, ply)
    local isSpawned = net.ReadBool()
    local model = net.ReadString()
    local itemName = net.ReadString()
    local categoryName = net.ReadString()
    local plyClass = PLAYER_CLASSES[ply:GetNWInt("playerJob")]
    local item = MARKETTABLE.MarketItems[categoryName][itemName]

    if plyClass.name == item.JobRequirement or item.JobRequirement == "none" then
        if ply:CanAfford(item.Price) then
            if isSpawned then
                local tr = {}
                tr.start = ply:EyePos()
                tr.endpos = tr.start + ply:GetAimVector() * 85
                tr.filter = ply
                tr = util.TraceLine(tr)

                local SpawnPos = tr.HitPos + Vector(0,0,40)
                local SpawnAng = ply:EyeAngles()
                SpawnAng.pitch = 0
                SpawnAng.yaw = SpawnAng.y + 180

                local ent = ents.Create(itemName)
                ent:SetBuyer(ply:GetNWString("charName"))
                ent:SetModel(model)
                ent:SetPos(SpawnPos)
                ent:SetAngles(SpawnAng)
                ent:Spawn()
                ent:Activate()

                ply:RemoveFromBalance(item.Price)
                return
            end
            ply:RemoveFromBalance(item.Price)
            if tostring(itemName) == "fancysuit" or tostring(itemName) == "femalebundleofclothes" or tostring(itemName) == "malebundleofclothes" then
                ply:inventoryGiveItem(tostring(itemName), 1)
            else
                ply:inventoryGiveItem(tostring(itemName), 5)
            end
        else
            return
        end
    else
        return
    end
end)

net.Receive("visl_inventory_drop", function(len, ply)
    if (ply:GetNWBool("visl_arrested") == true) then
        return
    end

    local name = net.ReadString()
    if ply:inventoryHasItem(name, 1) then
        ply:inventoryTakeItem(name, 1)
        CreateItem(ply, name, itemSpawnPos(ply))
    end
end)

net.Receive("visl_inventory_use", function(len, ply)
    local name = net.ReadString()
    local item = getItems(name)

    if (ply:GetNWBool("visl_arrested") == true) then
        return
    end

    if (table.HasValue(govJobs, ply:GetNWInt("playerJob")) and (item.category == "Weapons" or item.category == "Illegalities" or item.category == "Clothing")) then
        return
    end

    if item then
        if name == "fancysuit" or name == "femalebundleofclothes" or name == "malebundleofclothes" then
            item.use(ply)
        elseif ply:inventoryHasItem(name, 1) then
            ply:inventoryTakeItem(name, 1)
            item.use(ply)
        end
    end
end)

local idd = 0
function CreateItem(ply, name, pos)
    local itemT = getItems(name)
    if itemT then
        idd = idd+1
        local item = ents.Create(itemT.ent)
        item:SetNWString("name", itemT.name)
        item:SetNWString("itemName", name)
        item:SetNWInt("uID", idd)
        item:SetNWBool("pickup", true)
        item:SetPos(pos)
        item:SetNWEntity("owner", ply)
        item:SetSkin(itemT.skin or 0)

        itemT.spawn(ply,item)
        item:Spawn()
        item:Activate()
    else
        return false
    end
end

function itemSpawnPos(ply)
    local pos = ply:GetShootPos()
    local ang = ply:GetAimVector()

    local td = {}
    td.start = pos
    td.endpos = pos+(ang*80)
    td.filter = ply
    local trace = util.TraceLine(td)
    return trace.HitPos
end

function inventoryPickup(ply)
    local trace = {}
    trace.start = ply:EyePos()
    trace.endpos = trace.start + ply:GetAimVector() * 85
    trace.filter = ply
    local tr = util.TraceLine(trace)

    if (tr.HitWorld) then return end
    if !tr.Entity:IsValid() then return end

    if tr.Entity:GetNWBool("pickup") then
        local item = getItems(tr.Entity:GetNWString("itemName"))
        if tr.Entity:GetNWBool("pickup") == nil then
            ply:inventoryGiveItem(tr.Entity:GetNWString("itemName"), 1)
            tr.Entity:Remove()
        else
            if tr.Entity:GetNWBool("pickup") then 
                ply:inventoryGiveItem(tr.Entity:GetNWString("itemName"), 1)
                tr.Entity:Remove()
            end
        end
    end
end
hook.Add("VISL_KEY_Q", "inventoryPickup", inventoryPickup)
