-- setup physics and such
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


function ENT:Initialize()
	self:SettimeStamp(false)
	self:SetPreCurTime(CurTime())
	self:Setlvl(0)
	self:SetModel("models/nater/weedplant_pot_dirt.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		timerInit()
	end
end
--start a timer using a basic curtime() timer.
function timerInit()
	end -- func end

function ENT:Think()
	if(self:Getlvl() == 7) then return false end
	if(CurTime() >= self:GetPreCurTime()+5) then
		local lvlv = self:Getlvl()
		self:Setlvl(lvlv+1)
		local getLvlFixed = tostring(self:Getlvl())
		lvlModel = "models/nater/weedplant_pot_growing"..getLvlFixed..".mdl"
		self:SetModel(lvlModel)
		self:SetPreCurTime(CurTime())
		end -- ifPre.. end
end

-- setup some derma for extraction to the drug_bag, drug_pot and then delete itself itself.
function ENT:Use(activator, caller)
	if(self:Getlvl() == 7) then
		activator:inventoryGiveItem("weedbag", math.random(2,5))
		local newEnt = ents.Create("drug_pot_with_soil")
		newEnt:SetPos(self:GetPos())
		newEnt:Spawn()
		self:Remove()
	else
		if(self:GettimeStamp() == false) then
		self:SettimeStamp(true)
		timer.Simple(1,function() self:SettimeStamp(false) end)
		end
	end
end

function ENT:OnTakeDamage()
	self:Remove()
end