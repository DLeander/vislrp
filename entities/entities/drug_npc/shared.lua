ENT.Base = "base_ai" -- This entity is based on "base_ai"
ENT.Type = "ai" -- What type of entity is it, in this case, it's an AI.
ENT.AutomaticFrameAdvance = true -- This entity will animate itself.
ENT.PrintName = "drug_npc"
ENT.Author = "Wanni - Edited by Dexter"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category = "VislRP"
 
function ENT:SetAutomaticFrameAdvance( bUsingAnim ) -- This is called by the game to tell the entity if it should animate itself.
	self.AutomaticFrameAdvance = bUsingAnim
end