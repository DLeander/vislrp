AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()
	self:SetModel("models/nater/weedplant_pot.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Touch( entity )
	if(entity:GetClass() == "drug_soil") then
		timer.Create("drug_with_soil_spawn",0,1,function()
			local newEnt = ents.Create("drug_pot_with_soil")
			entity:Remove()
			newEnt:SetPos(self:GetPos())
			newEnt:Spawn()
			self:Remove()
		end)
	end
end

function ENT:OnTakeDamage()
	self:Remove()
end