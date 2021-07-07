ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "drug_plant"
ENT.Author = "Wanni"
ENT.Category = "VislRP"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
self:NetworkVar("Int",0,"lvl")
self:NetworkVar("Int",1,"PreCurTime")
self:NetworkVar("Bool",2,"timeStamp")
end