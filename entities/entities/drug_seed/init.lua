AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_junk/garbage_bag001a.mdl") --models/weapons/w_bugbait.mdl
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

-- function ENT:StartTouch(ent)
-- 	if(ent:GetClass() == "drug_soil") then
-- 		local newEnt = ents.Create("drug_pot_with_soil")
-- 		ent:Remove()
-- 		newEnt:SetPos(self:GetPos())
-- 		newEnt:Spawn()
-- 		--newEnt:SetOwner(self:Getowning_ent())
-- 		self:Remove()
-- 	end
-- end

function ENT:OnTakeDamage()
	self:Remove()
end