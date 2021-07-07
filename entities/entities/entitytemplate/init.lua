AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
end

function ENT:SpawnFunction(ply, tr, ClassName)
end

function ENT:Use(activator, caller)
    --Whenever the player uses the entity
end

function ENT:Think()
   -- Called Every tick
end