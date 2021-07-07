local governmental_jobs = {1,2,3,4,5,6,7}

local function handleLimitChange(ent, itemName, ply)
    ply:SetVar("amount_"..itemName, ply:GetVar("amount_"..itemName, 0) + 1)

    ent:CallOnRemove("DecrementLimit", function()
        ply:SetVar("amount_"..itemName, ply:GetVar("amount_"..itemName) - 1)
    end)
end

function superadminGiveMoney(ply, cmd, args)
    if ply:IsUserGroup("superadmin") then
        ply:AddToBalance(args[1])
    else
        return
    end
end
concommand.Add("superadmin_give_money", superadminGiveMoney)

function setPlayerJob(ply, cmd, args)
    if (args[1] != nil) then
        if ply:GetNWInt("playerJob") == tonumber(args[1]) then
            return
        elseif countPlayersInJob(tonumber(args[1])) >= PLAYER_CLASSES[tonumber(args[1])].maxplayers then
            return
        elseif not PLAYER_CLASSES[tonumber(args[1])] then
            return
        else
            ply:SetNWInt("playerJob", tonumber(args[1]))
            if table.HasValue(governmental_jobs, ply:GetNWInt("playerJob")) then
                local ent = ply:GetNWEntity("visl_spawned_vehicle")
                if ent != nil and IsValid(ent) then
                    if SERVER then
                        print("remove1")
                        --ent:Remove()
                        ent:VC_CD_returnVehicle(true)
                        ply:SetNWEntity("visl_spawned_vehicle", nil)
                    end
                end
                ply:Spawn()
                return
            end
            if !table.HasValue(governmental_jobs, tonumber(args[1])) then
                local ent = ply:GetNWEntity("visl_spawned_vehicle")
                if ent != nil and IsValid(ent) then
                    if SERVER then
                        print("remove2")
                        --ent:Remove()
                        ent:VC_CD_returnVehicle(true)
                        ply:SetNWEntity("visl_spawned_vehicle", nil)
                    end
                end
                ply:Spawn()
                return
            end
            ply:Spawn()
        end
    end
end
concommand.Add("player_set_job", setPlayerJob)

-- function setCharacterName(ply, cmd, args)
--     if (args[1] != nil) then
--         ply:SetNWString("charName", tostring(args[1]))
--     end
-- end
-- concommand.Add("player_set_character_name", setCharacterName)

-- function setCharacterDescription(ply, cmd, args)
--     if (args[1] != nil) then
--         ply:SetNWString("charDesc", tostring(args[1]))
--     end
-- end
-- concommand.Add("player_set_character_description", setCharacterDescription)

function upgradePrintAmount(ply, cmd, args)
    --Entity(args[1]):SetPrintAmount(100)
    local entity = Entity(args[1])
    local printAmount = entity:GetPrintAmount()
    local upgradeCost = 2000
    local plyBal = ply:GetNWInt("playerMoney")

    if plyBal >= upgradeCost then
        ply:SetNWInt("playerMoney", plyBal - upgradeCost)
        entity:SetPrintAmount(printAmount + 100)
    else
        return
    end
end
concommand.Add("upgrade_print_amount", upgradePrintAmount)