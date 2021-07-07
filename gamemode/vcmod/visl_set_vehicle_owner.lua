hook.Add("VC_CD_spawnedVehicle", "visl_set_vehicle_owner", function(ply, ent, test)
    ent:VC_lock()
    ply:SetNWEntity( "visl_spawned_vehicle", ent )
end)