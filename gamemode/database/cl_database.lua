local database = {}
local govJobs = {1,2,3,4,5,6,7}
local ply = LocalPlayer()
local function databaseReceive(table)
    database = table
end

net.Receive("visl_database", function(len)
    local table = net.ReadTable()
    databaseReceive(table)
end)

function databaseTable()
    return database
end

function databaseGetValue(name)
    local d = databaseTable()
    return d[name]
end

function inventoryTable()
    return databaseGetValue("inventory") or {}
end

function getCurrentInvSize()
    local currSize = 0
    local inventory = inventoryTable()
    local item

    for itemindex, curritem in pairs(inventory) do
        item = getItems(itemindex)
        currSize = currSize + (item.space * curritem.amount)
    end
    
    print("playerSize: "..ply:GetNWInt("visl_max_invsize"))
    print("total size: "..currSize)
    return currSize
end


function inventoryHasItem(name, amount)
    if not amount then amount = 1 end
    local i = inventoryTable()
    if i then
        if i[name] then
            if i[name].amount >= amount then
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

local SKINS = {}
SKINS.COLORS = {
    lightgrey = Color(131,131,131,180),
    grey = Color(111,111,111,180),
    lowWhite = Color(243,243,243,180),
    goodBlack = Color(41,41,41,230),
}

function SKINS:DrawFrame(w,h)
    topHeight = 24
    local rounded = 4
    local QuadTable = {}
    QuadTable.x = 2
    QuadTable.y = topHeight
    QuadTable.w = w-4
    QuadTable.h = h-topHeight-2
end

function inventoryItemButton(iname, name, amount, desc,model,parent,dist,buttons)
    if not dist then dist = 128 end
    local p = vgui.Create("DIconLayout", parent)
    p:SetPos(4,4)
    p:SetSize(64,64)

    local mp = vgui.Create("SpawnIcon", p)
    mp:SetSize(p:GetWide(), p:GetTall())
    mp:SetPos(0,0)
    mp:SetModel(model)

    function mp:LayoutEntity(entity)
        self:RunAnimation()
        entity:SetSkin(getItems(iname).skin or 0)
        entity:SetAngles(Angle(0,0,0))
    end

    mp:SetToolTip(name .. ":\n\n" .. desc)
    mp.DoClick = function()
        local opt = DermaMenu()
        for k,v in pairs(buttons) do
            opt:AddOption(k,v)
        end
        opt:Open()
    end

    mp.DoRightClick = function()
    end

    function mp:Paint()
        return true
    end

    if amount then
        local l = vgui.Create("DLabel", mp)
        l:SetPos(4,4)
        l:SetTextColor( Color(0,0,0,255) )
        l:SetFont("default")
        l:SetText(amount)
        l:SizeToContents()
    end

    return p
end

function inventoryDrop(item)
    if (ply:GetNWBool("visl_arrested") == true) then
        notification.AddLegacy("You can not drop items while arrested.", NOTIFY_ERROR,5)
        return
    end
    net.Start("visl_inventory_drop")
    net.WriteString(tostring(item))
    net.SendToServer()
end

function inventoryUse(item)
    local itemcheck = getItems(item)
    if (ply:GetNWBool("visl_arrested") == true) then
        notification.AddLegacy("You can not use items while arrested.", NOTIFY_ERROR,5)
        return
    end

    if (table.HasValue(govJobs, ply:GetNWInt("playerJob")) and (itemcheck.category == "Weapons" or itemcheck.category == "Illegalities" or itemcheck.category == "Clothing")) then
        notification.AddLegacy("You can not use this item while in the government.", NOTIFY_ERROR,5)
        return
    end

    net.Start("visl_inventory_use")
    net.WriteString(tostring(item))
    net.SendToServer()
end
