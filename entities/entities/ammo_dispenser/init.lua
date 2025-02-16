AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
    if (IsValid(phys)) then
        phys:Wake()
    end

    self:SetHealth(self.BaseHealth)
end

function ENT:OnTakeDamage(damage)
    self:SetHealth(self:Health() - damage:GetDamage())

    if (self:Health() <= 0) then
        self:Remove()
    end
end

-- function ENT:SpawnFunction(ply, tr, ClassName)
--     if (!tr.Hit) then return end -- Disable spawning far away

--     local SpawnPos = ply:GetShootPos() + ply:GetForward() * 80
--     local ent = ents.Create(ClassName)
--     self.Owner = ply
--     ent:SetPos(SpawnPos)
--     ent:Spawn()
--     ent:Activate()
--     return ent
-- end

-- function ENT:OnRemove()
--     local Owner = self.Owner
--     local ClassName = self:GetClass()
--     local entCount = Owner:GetNWInt(ClassName .. "count")

--     if (Owner:IsValid()) then 
--         if (Owner:GetNWInt(ClassName .. "count") > 0) then
--             Owner:SetNWInt(ClassName .. "count", entCount - 1)
--         end
--     end
-- end

function ENT:Use(activator, caller)
    local ammoType = activator:GetActiveWeapon():GetPrimaryAmmoType() -- Get held weapon ammo
    activator:GiveAmmo(30, ammoType, true)
    --Whenever the player uses the entity
end

function ENT:Think()
   -- Called Every tick
end