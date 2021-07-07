function ENT:SetupDataTables()
    self:NetworkVar("String", 0, "Buyer")
    self:NetworkVar("Int", 0, "Storage")
    self:NetworkVar("Int", 1, "PrintAmount")
end

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Basic Money Printer"
ENT.Author = "Dexter"
ENT.Contact = ""
ENT.Purpose = "Print money"
ENT.Instructions = "Print money"
ENT.Spawnable = true
ENT.AdminSpawnable = false

ENT.BaseHealth = 100
ENT.PrintRate = 300 -- seconds
--ENT.PrintAmount = 200

ENT.Model = "models/basic_money_printer/basic_money_printer.mdl"
