hook.Add("InitPostEntity", "visl_remove_map_props", function()
    for k,v in pairs(ents.FindByModel("models/props_urban/gas_pump001.mdl")) do
        SafeRemoveEntity(v)
    end

    for k,v in pairs(ents.FindByModel("models/props_equipment/gas_pump.mdl")) do
        SafeRemoveEntity(v)
    end
end)