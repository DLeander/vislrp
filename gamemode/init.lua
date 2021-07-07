util.AddNetworkString("visl_OpenCharacterMenu")
util.AddNetworkString("visl_CharacterCreationInformation")
util.AddNetworkString("visl_KEY_Q")
util.AddNetworkString("visl_CharacterInformationChange")
util.AddNetworkString("visl_CharacterModelChange")

--ADDCSLUAFILES BELOW THIS LINE
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("concommands.lua")

--AddCSLuaFile related to the database
AddCSLuaFile("database/cl_database.lua")
AddCSLuaFile("database/items.lua")
AddCSLuaFile("config/custom_classes.lua")
AddCSLuaFile("market/sh_market.lua")

--AddCSLuaFile related to the player
AddCSLuaFile("menus/characterselect.lua")
AddCSLuaFile("menus/changecharinfomenu.lua")
AddCSLuaFile("menus/changemodelmenu.lua")
AddCSLuaFile("player/sh_player.lua")
AddCSLuaFile("scoreboard/scoreboard.lua")
AddCSLuaFile("menus/f4menu.lua")
AddCSLuaFile("hud/hud.lua")
AddCSLuaFile("government/cl_radio.lua")
AddCSLuaFile("warrant/cl_warrant.lua")

--INCLUDES BELOW THIS LINE
include("shared.lua")
include("concommands.lua")
include("removemapprops/sv_removemapprops.lua")

--Includes related to database
include("config/custom_classes.lua")
include("database/database.lua")
include("market/sh_market.lua")
include("database/items.lua")

--Includes related to the player
include("player/hunger.lua")
include("player/stamina.lua")
include("player/sh_player.lua")
include("player/sv_player.lua")
include("player/salary.lua")
include("governor/sv_laws.lua")
include("governor/sv_tax.lua")
include("warrant/sv_warrant.lua")
include("government/sv_radio.lua")
include("player/sv_playerdeath.lua")

--VCMod related
include("vcmod/sv_visl_vcmod_afford.lua")
include("vcmod/sv_visl_vcmod_purchase.lua")
include("vcmod/sv_visl_vcmod_sell.lua")
include("vcmod/job_restricted_car_dealer.lua")
include("vcmod/visl_set_vehicle_owner.lua")

local govJobs = {1,2,3,4,5,6,7}

-- Set data on player join
function GM:PlayerInitialSpawn(ply)
    ply:SetCanZoom(false)
    ply:SetNWInt("playerJob", 8)
    PLAYER_CLASSES[8].currentplayers = PLAYER_CLASSES[8].currentplayers + 1

    if (ply:GetPData("charName") == nil or ply:GetPData("charDesc") == nil or ply:GetPData("charName") == "" or ply:GetPData("charDesc") == "" or ply:GetPData("charModel") == nil) then
        net.Start("visl_OpenCharacterMenu")
        net.Send(ply)
    else
        ply:SetNWString("charName", tostring(ply:GetPData("charName")))
        ply:SetNWString("charDesc", tostring(ply:GetPData("charDesc")))
        ply:SetNWString("charModel", tostring(ply:GetPData("charModel")))
    end

    if (ply:GetPData("playerMoney") == nil) then
        ply:SetNWInt("playerMoney", 2500)
    else
        ply:SetNWInt("playerMoney", tonumber(ply:GetPData("playerMoney")))
    end

    if ply:GetPData("visl_max_invsize") == nil then
        ply:SetNWInt("visl_max_invsize", 50)
    else
        ply:SetNWInt("visl_max_invsize", tonumber(ply:GetPData("visl_max_invsize")))
    end

    if ply:GetPData("vislrp_m_purchasedplayerModel") != nil then
        ply:SetNWString("vislrp_m_purchasedplayerModel", ply:GetPData("vislrp_m_purchasedplayerModel"))

        ply:SetNWString("visl_m_bodygroup1", ply:GetPData("visl_m_bodygroup1"))
        ply:SetNWString("visl_m_bodygroup2", ply:GetPData("visl_m_bodygroup2"))
        ply:SetNWString("visl_m_bodygroup3", ply:GetPData("visl_m_bodygroup3"))
    end

    if ply:GetPData("vislrp_f_purchasedplayerModel") != nil then
        ply:SetNWString("vislrp_f_purchasedplayerModel", ply:GetPData("vislrp_f_purchasedplayerModel"))

        ply:SetNWString("visl_f_bodygroup1", ply:GetPData("visl_f_bodygroup1"))
        ply:SetNWString("visl_f_bodygroup2", ply:GetPData("visl_f_bodygroup2"))
        ply:SetNWString("visl_f_bodygroup3", ply:GetPData("visl_f_bodygroup3"))
    end

    net.Start("visl_SyncLaws")
        net.WriteTable(global_law_table)
    net.Send(ply)
end

function GM:PlayerSelectSpawn(ply, transition)
    local plyClass = PLAYER_CLASSES[ply:GetNWInt("playerJob")]
    ply:SetPos(plyClass.spawnpositions[math.random(1,plyClass.numberofspawnpos)]) 
end

function setCharacterInformation(len, ply)
    local charName = net.ReadString()
    local charDesc = net.ReadString()
    local charmodel = ""
    local index = net.ReadUInt(5)

    if (index < 1 or index > 15) then return end

    if (index == 1) then
        charModel = "models/smalls_civilians/pack2/female/hoodiepulloverjeans/female_01_hoodiepulloverjeans_pm.mdl"
    end
    if (index == 2) then
        charModel = "models/smalls_civilians/pack2/female/hoodiepulloversweats/female_02_hoodiepulloversweats_pm.mdl"
    end
    if (index == 3) then
        charModel = "models/smalls_civilians/pack2/female/hoodiezippedjeans/female_03_hoodiezippedjeans_pm.mdl"
    end
    if (index == 4) then
        charModel = "models/smalls_civilians/pack2/female/hoodiezippedsweats/female_04_hoodiezippedsweats_pm.mdl"
    end
    if (index == 5) then
        charModel = "models/smalls_civilians/pack2/female/parkajeans/female_06_parkajeans_pm.mdl"
    end
    if (index == 6) then
        charModel = "models/smalls_civilians/pack2/female/parkasweats/female_07_parkasweats_pm.mdl"
    end
    if (index == 7) then
        charModel = "models/smalls_civilians/pack2/male/baseballtee/male_01_baseballtee_pm.mdl"
    end
    if (index == 8) then
        charModel = "models/smalls_civilians/pack2/male/flannel/male_02_flannel_pm.mdl"
    end
    if (index == 9) then
        charModel = "models/smalls_civilians/pack2/male/leatherjacket/male_03_leather_jacket_pm.mdl"
    end
    if (index == 10) then
        charModel = "models/smalls_civilians/pack2/male/hoodie_jeans/male_04_hoodiejeans_pm.mdl"
    end
    if (index == 11) then
        charModel = "models/smalls_civilians/pack2/male/hoodie_sweatpants/male_05_hoodiesweatpants_pm.mdl"
    end
    if (index == 12) then
        charModel = "models/smalls_civilians/pack2/male/jacket_open/male_06_jacketopen_pm.mdl"
    end
    if (index == 13) then
        charModel = "models/smalls_civilians/pack2/male/jacketvneck_sweatpants/male_07_jacketvneck_sweatpants_pm.mdl"
    end
    if (index == 14) then
        charModel = "models/smalls_civilians/pack2/male/hoodie_jeans/male_08_hoodiejeans_pm.mdl"
    end
    if (index == 15) then
        charModel = "models/smalls_civilians/pack2/male/flannel/male_09_flannel_pm.mdl"
    end

    if (string.len(tostring(charName)) > 24) then
        return
    end
    if (string.len(tostring(charDesc)) > 50) then
        return
    end
    if (tostring(charName) != "" and string.len(tostring(charName)) < 5) then 
        return
    end
    if (tostring(charDesc) != "" and string.len(tostring(charDesc)) <= 10) then 
        return
    end

    ply:SetNWString("charName", tostring(charName))
    ply:SetNWString("charDesc", tostring(charDesc))
    ply:SetNWString("charModel", tostring(charModel))
    ply:Spawn()
end
net.Receive("visl_CharacterCreationInformation", setCharacterInformation)

function setNewCharacterInformation(len, ply)
    local charName = net.ReadString()
    local charDesc = net.ReadString()

    if (string.len(tostring(charName)) > 24) then
        return
    end
    if (string.len(tostring(charDesc)) > 50) then
        return
    end
    if (tostring(charName) != "" and string.len(tostring(charName)) < 5) then 
        return
    end
    if (tostring(charDesc) != "" and string.len(tostring(charDesc)) <= 10) then 
        return
    end

    ply:SetNWString("charName", charName)
    ply:SetNWString("charDesc", charDesc)
end
net.Receive("visl_CharacterInformationChange", setNewCharacterInformation)

function setNewCharacterModel(len, ply)
    local charmodel = ""
    local index = net.ReadUInt(5)
    if (index < 1 or index > 15) then return end

    if (index == 1) then
        charModel = "models/smalls_civilians/pack2/female/hoodiepulloverjeans/female_01_hoodiepulloverjeans_pm.mdl"
    end
    if (index == 2) then
        charModel = "models/smalls_civilians/pack2/female/hoodiepulloversweats/female_02_hoodiepulloversweats_pm.mdl"
    end
    if (index == 3) then
        charModel = "models/smalls_civilians/pack2/female/hoodiezippedjeans/female_03_hoodiezippedjeans_pm.mdl"
    end
    if (index == 4) then
        charModel = "models/smalls_civilians/pack2/female/hoodiezippedsweats/female_04_hoodiezippedsweats_pm.mdl"
    end
    if (index == 5) then
        charModel = "models/smalls_civilians/pack2/female/parkajeans/female_06_parkajeans_pm.mdl"
    end
    if (index == 6) then
        charModel = "models/smalls_civilians/pack2/female/parkasweats/female_07_parkasweats_pm.mdl"
    end
    if (index == 7) then
        charModel = "models/smalls_civilians/pack2/male/baseballtee/male_01_baseballtee_pm.mdl"
    end
    if (index == 8) then
        charModel = "models/smalls_civilians/pack2/male/flannel/male_02_flannel_pm.mdl"
    end
    if (index == 9) then
        charModel = "models/smalls_civilians/pack2/male/leatherjacket/male_03_leather_jacket_pm.mdl"
    end
    if (index == 10) then
        charModel = "models/smalls_civilians/pack2/male/hoodie_jeans/male_04_hoodiejeans_pm.mdl"
    end
    if (index == 11) then
        charModel = "models/smalls_civilians/pack2/male/hoodie_sweatpants/male_05_hoodiesweatpants_pm.mdl"
    end
    if (index == 12) then
        charModel = "models/smalls_civilians/pack2/male/jacket_open/male_06_jacketopen_pm.mdl"
    end
    if (index == 13) then
        charModel = "models/smalls_civilians/pack2/male/jacketvneck_sweatpants/male_07_jacketvneck_sweatpants_pm.mdl"
    end
    if (index == 14) then
        charModel = "models/smalls_civilians/pack2/male/hoodie_jeans/male_08_hoodiejeans_pm.mdl"
    end
    if (index == 15) then
        charModel = "models/smalls_civilians/pack2/male/flannel/male_09_flannel_pm.mdl"
    end

    ply:SetNWString("charModel", charModel)
end
net.Receive("visl_CharacterModelChange", setNewCharacterModel)

-- Store player data on disconnect
function GM:PlayerDisconnected(ply)
    timer.Remove("SalaryTimer"..ply:UserID())
    timer.Remove("HungerTimer"..ply:UserID())
    timer.Remove("visl_warrant_"..tostring(ply:UserID()))
    timer.Remove("visl_arrested_"..tostring(ply:UserID()))
    ply:SetNWBool("visl_warrant", nil)
    ply:SetNWBool("visl_arrested", nil)

    ply:SetPData("playerMoney", ply:GetNWInt("playerMoney"))
    ply:SetPData("charName", ply:GetNWString("charName"))
    ply:SetPData("charDesc", ply:GetNWString("charDesc"))
    ply:SetPData("charModel", ply:GetNWString("charModel"))
    ply:SetPData("visl_max_invsize", ply:GetNWInt("visl_max_invsize"))
    
    -- Clothing
    ply:SetPData("vislrp_m_purchasedplayerModel", ply:GetNWString("vislrp_m_purchasedplayerModel"))
    ply:SetPData("visl_m_bodygroup1", ply:GetNWString("visl_m_bodygroup1"))
    ply:SetPData("visl_m_bodygroup2", ply:GetNWString("visl_m_bodygroup2"))
    ply:SetPData("visl_m_bodygroup3", ply:GetNWString("visl_m_bodygroup3"))

    ply:SetPData("vislrp_f_purchasedplayerModel", ply:GetNWString("vislrp_f_purchasedplayerModel"))
    ply:SetPData("visl_f_bodygroup1", ply:GetNWString("visl_f_bodygroup1"))
    ply:SetPData("visl_f_bodygroup2", ply:GetNWString("visl_f_bodygroup2"))
    ply:SetPData("visl_f_bodygroup3", ply:GetNWString("visl_f_bodygroup3"))

    --database
    ply:databaseDisconnect()
end

-- Store all players data on server shutdown
function GM:ShutDown()
    for k,v in pairs(player.GetAll()) do
        v:SetPData("playerMoney", v:GetNWInt("playerMoney"))
        v:SetPData("charName", v:GetNWString("charName"))
        v:SetPData("charDesc", v:GetNWString("charDesc"))
        v:SetPData("charModel", v:GetNWString("charModel"))
        v:SetPData("visl_max_invsize", ply:GetNWInt("visl_max_invsize"))

        v:SetPData("vislrp_m_purchasedplayerModel", ply:GetNWString("vislrp_m_purchasedplayerModel"))
        v:SetPData("visl_m_bodygroup1", ply:GetNWString("visl_m_bodygroup1"))
        v:SetPData("visl_m_bodygroup2", ply:GetNWString("visl_m_bodygroup2"))
        v:SetPData("visl_m_bodygroup3", ply:GetNWString("visl_m_bodygroup3"))

        v:SetPData("vislrp_f_purchasedplayerModel", ply:GetNWString("vislrp_f_purchasedplayerModel"))
        v:SetPData("visl_f_bodygroup1", ply:GetNWString("visl_f_bodygroup1"))
        v:SetPData("visl_f_bodygroup2", ply:GetNWString("visl_f_bodygroup2"))
        v:SetPData("visl_f_bodygroup3", ply:GetNWString("visl_f_bodygroup3"))
    end
end

function GM:PlayerAuthed(ply, steamID, uniqueID)
    ply:databaseCheck()
end

function GM:PlayerSpawn(ply)
    ply:SetGravity(0.9)
    local plyClass = PLAYER_CLASSES[ply:GetNWInt("playerJob")]
    
    -- Initialize hunger/stamina
    ply:SetNWInt("visl_stamina", 1000)
    ply:SetNWInt("visl_hunger", 75)
    InitializePlayerHunger(ply)

    -- Timer for salary
    setSalaryTimer(ply)

    -- if in government, give ammo:
    if table.HasValue(govJobs, ply:GetNWInt("playerJob")) then
        ply:SetAmmo(150, "ar2")
        ply:SetAmmo(150, "smg1")
        ply:SetAmmo(150, "pistol")
    else
        ply:SetAmmo(0, "ar2")
        ply:SetAmmo(0, "smg1")
        ply:SetAmmo(0, "pistol")
        ply:SetAmmo(0, "SniperPenetratedRound")
        ply:SetAmmo(0, "buckshot")
    end

    -- Initialize job features
    ply:SetMaxHealth(plyClass.health)
    ply:SetRunSpeed(plyClass.runspeed)
    ply:SetWalkSpeed(plyClass.walkspeed)

    ply:StripWeapons()

    hook.Call("PlayerLoadout", GAMEMODE, ply)
    hook.Call("PlayerSetModel", GAMEMODE, ply)
end

function GM:PlayerLoadout(ply)
    local plyClass = PLAYER_CLASSES[ply:GetNWInt("playerJob")]
    for k,v in pairs(plyClass.weapons) do
        ply:Give(v)
    end
    return true
end

function GM:PlayerSetModel(ply)
    local plyClass = PLAYER_CLASSES[ply:GetNWInt("playerJob")]
    local playermodel = ply:GetNWString("charModel")
    local finalmodel = ""
    
    if (plyClass.model == "none") then
        ply:SetModel(playermodel)
    elseif plyClass.specialmodel != 1 then
        local selectedmodel = playermodel
        local modelnamemale = plyClass.modelmale
        local modelnamefemale = plyClass.modelfemale

        local explstr = string.Explode("/",selectedmodel)
        local explstr2 = string.Explode("_",explstr[#explstr])
        local charactertype = explstr2[1].."_"..explstr2[2]

        if charactertype == "female_07" and (ply:GetNWInt("playerJob") == 4 or ply:GetNWInt("playerJob") == 5 or ply:GetNWInt("playerJob") == 7) then
            charactertype = "female_07"
        end
        if charactertype == "female_07" and (ply:GetNWInt("playerJob") == 13 or ply:GetNWInt("playerJob") == 14 or ply:GetNWInt("playerJob") == 1) then -- stupid models names...
            charactertype = "female_05"
        end

        local substring = string.sub(charactertype, 1, 1 )

        if substring == "f" then
            finalmodel = string.Replace(modelnamefemale,"HERE",charactertype)
        else
            finalmodel = string.Replace(modelnamemale,"HERE",charactertype)
        end

        ply:SetModel(finalmodel)
    else
        ply:SetModel(plyClass.model)
    end
    ply:SetupHands()
end

function GM:OnPlayerDeath(victim, inflictor, attacker)
    attacker:SetFrags(attacker:Frags() + 1)
    timer.Remove("SalaryTimer"..victim:UserID())
    timer.Remove("visl_warrant_"..tostring(victim:UserID()))
    timer.Remove("visl_arrested_"..tostring(victim:UserID()))
    victim:SetNWBool("visl_warrant", nil)
    victim:SetNWBool("visl_arrested", nil)
    
end

function GM:OnNPCKilled(npc, attacker, inflictor)
    attacker:SetNWInt("playerMoney", attacker:GetNWInt("playerMoney") + 100)
end

function GM:PhysgunPickup(ply, ent)
    if (ent.Owner == ply) then
        return false
    end
    return true
end

function GM:ShowSpare2(ply)
    ply:ConCommand("open_f4_menu")
end

function GM:GravGunPunt(player, entity)
    return false
end

function GM:PlayerSay(ply, text)
    local playerMsg = string.Explode(" ", text)
    local plyClass = PLAYER_CLASSES[ply:GetNWInt("playerJob")]

    if (playerMsg[1] == "/dropmoney") then
        if (tonumber(playerMsg[2])) then
            local amount = tonumber(playerMsg[2])
            local plyBalance = ply:GetNWInt("playerMoney")
            if (amount > 0 and amount <= plyBalance) then
                ply:SetNWInt("playerMoney", plyBalance - amount)

                scripted_ents.Get("money"):SpawnFunction(ply, ply:GetEyeTrace(), "money"):SetValue(amount)
            else
                --ply:notification.AddLegacy("You do not have enough money to drop this much", NOTIFY_ERROR,5)
            end

            return ""
        else
            --ply:notification.AddLegacy("The amount of money has to be a number", NOTIFY_ERROR,5)
        end
    end
    if (playerMsg[1] == "/holster") then
        local noHolsterJobs = {1,2,3,4,5,6,7}
        if table.HasValue(noHolsterJobs, ply:GetNWInt("playerJob")) then
            return ""
        end
        local noHolster = {"weapon_fists", "weapon_physgun", "weapon_physcannon", "gmod_tool", "weapon_keys"}
        if table.HasValue(noHolster, tostring(ply:GetActiveWeapon():GetClass())) then
            return ""
        else
            ply:inventoryGiveItem(ply:GetActiveWeapon():GetClass(), 1)
            ply:StripWeapon(ply:GetActiveWeapon():GetClass())
            return ""
        end
    end

    if (string.lower(playerMsg[1]) == "/law" and plyClass.name == "District Governor") then
        local newtext = string.Replace(text, "/law", "")
        table.insert(global_law_table, newtext)
        net.Start("visl_SyncLaws")
            net.WriteTable(global_law_table)
        net.Broadcast()
    end

    if (string.lower(playerMsg[1]) == "/lawremove" and plyClass.name == "District Governor") then
        local lawtoremove = tonumber(playerMsg[2])
        table.remove(global_law_table, lawtoremove)
        net.Start("visl_SyncLaws")
            net.WriteTable(global_law_table)
        net.Broadcast()
        return ""
    end

    return tostring(text)
end

net.Receive("VISL_KEY_Q", function(len, ply)
    hook.Call("VISL_KEY_Q", GAMEMODE, ply)
end)

hook.Add( "InitPostEntity", "visl_init_npcs", function()
    local drug_npc_pos_table = {
        Vector(-5415.754395, 6412.439453, -1422.822876+72),
        Vector(-10858.317383, -14286.237305, -2085.071533+72),
        Vector(102.858337, -5584.930176, -1804.968750+72),
    }
	local drug_npc = ents.Create( "drug_npc" )
    drug_npc:SetPos( Vector(102.858337, -5584.930176, -1804.968750+72) )
    drug_npc:Spawn()

    timer.Create("visl_drug_npc_random_locations", 600, 0, function() 
        drug_npc:SetPos(drug_npc_pos_table[math.random(1,3)])
    end)


    local gasstation_npc = ents.Create("gasstation_npc")
    gasstation_npc:SetPos(Vector(-7888.956543, 5400.031250, -1417.968750+72))
    gasstation_npc:SetAngles(Angle(0, -90, 0))
    gasstation_npc:Spawn()

    local clothesshop_npc = ents.Create("clothesshop_npc")
    clothesshop_npc:SetPos(Vector(5820.283691, -1652.662964, -1804.968750))
    clothesshop_npc:SetAngles(Angle(0, 90, 0))
    clothesshop_npc:Spawn()
end )

function GM:PlayerCanSeePlayersChat(text, teamOnly, listener, speaker) --str, bool, ply, ply
    local dist = listener:GetPos():Distance(speaker:GetPos())
    local playerMsg = string.Explode(" ", text)

    if (playerMsg[1] == "/warrant") then
        local workers = {1,2,3,4,5,6,7}
        if table.HasValue(workers, listener:GetNWInt("playerJob")) then
            return true
        else
            return false
        end
    end
    if (string.lower(playerMsg[1]) == "/law") then
        return true
    end
    if (string.lower(playerMsg[1]) == "/tax") then
        return true
    end
    if (string.lower(playerMsg[1]) == "/ooc") then
        return true    
    end
    if (string.lower(playerMsg[1]) == "/y" or string.lower(playerMsg[1]) == "/yell") then
        if (dist <= 500) then
            return true
        else
            return false
        end 
    end
    if (string.lower(playerMsg[1]) == "/w" or string.lower(playerMsg[1]) == "/whisper") then
        if (dist <= 200) then
            return true
        else
            return false
        end 
    end
    if string.StartWith(text, "//") then
        return true
    end

    if (dist <= 350) then
        return true
    else
        return false
    end
end

function GM:PlayerCanHearPlayersVoice(listener, speaker)
    if speaker:Alive() then
        return (listener:GetPos():Distance(speaker:GetPos()) < 350 )
    else
        return false
    end
end