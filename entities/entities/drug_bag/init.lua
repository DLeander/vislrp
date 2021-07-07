AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
resource.AddFile("models/katharsmodels/contraband/zak_wiet/zak_wiet.mdl")


function ENT:Initialize()
	self:SetModel("models/katharsmodels/contraband/zak_wiet/zak_wiet.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	for k,v in pairs(player.GetAll()) do
		if v.numberOfBags == nil then
			v.numberOfBags = 0
			print("[WeedMod]No storagevar for player: " .. v:Nick() .. ", making it.")
		end
	end
end

function ENT:Use(a, c)
	if IsValid( c ) and c:IsPlayer() then
		if c.numberOfBags != nil then
			c.numberOfBags = c.numberOfBags + 1
		else
			c.numberOfBags = 1
		end
		print("[WeedMod]"..c:Nick() .. " now have " .. c.numberOfBags .. " weed-bags in their inv.")
		self:Remove()
	end
end

function ENT:OnTakeDamage()
	self:Remove()
end