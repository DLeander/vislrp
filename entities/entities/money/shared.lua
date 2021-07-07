function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "Value")
end

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Money"
ENT.Autohr = "Dexter"
ENT.Contact = ""
ENT.Purpose = "Physical Version of Money"
ENT.Instruction = "Pick up"

ENT.Spawnable = false
ENT.AdminSpawnable = true

ENT.Model = "models/props/cs_assault/Money.mdl"
