AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/nater/weedplant_pot_dirt.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Touch( entity )
	if(entity:GetClass() == "drug_seed") then
		timer.Create("drug_plant_seed_spawn",0,1,function()
			local newEnt = ents.Create("drug_plant")
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