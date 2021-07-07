local governmentaljobs = {1,2,3,4,5,6,7}

hook.Add("VC_CD_canUse", "VC_Job_Restriction", function(NPC, ply)
	local ID, name, model, data = NPC:VC_CD_getInfo()
    local plyJob = ply:GetNWInt("playerJob")

    if (name == "Christopher NoLand" or name == "Judith Moss" or name == "Johnny Gertz") and !table.HasValue(governmentaljobs, plyJob) then
        ply:PrintMessage( HUD_PRINTTALK, name.." says: Please back off, I'm working here..." )
        return false
    end
end)

hook.Add("VC_CD_canSpawnVehicle", "VC_job_res_canSpawnVehicle", function(ply, vehID, pos, ang, npc, ranksRestr, jobRestr)
    local npcID, npcname, npcmodel, npcdata = npc:VC_CD_getInfo()

    if (npcname == "Christopher NoLand" or npcname == "Judith Moss" or npcname == "Johnny Gertz") then
        local model, name, skin = VC_CD_getVehicleDataFromID(vehID)
        local dist = pos:Distance(Vector(0,0,0))

        print(model)
        if (model == "models/tdmcars/emergency/for_crownvic.mdl" or model == "models/tdmcars/emergency/dod_charger12.mdl") and (ply:GetNWInt("playerJob") != 4 or ply:GetNWInt("playerJob") != 5) then
            print("hej1")
            print(model)
            return true
        else
            return true
        end
        if (ply:GetNWInt("playerJob") != 7) then
            print("hej2")
            print(model)
            return false
        end
        if model == "models/tdmcars/trucks/scania_firetruck.mdl" and ply:GetNWInt("playerJob") != 6 then
            print("hej3")
            print(model)
            return false
        else
            return true
        end
    end
end)