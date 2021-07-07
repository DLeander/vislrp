util.AddNetworkString( "visl_opendrugmenu" )
util.AddNetworkString( "visl_buydrugs" )

include("shared.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")


function ENT:Initialize( )
	self:SetModel( "models/Humans/Group03/Male_01.mdl" )
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal()
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid(  SOLID_BBOX )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE && CAP_TURN_HEAD )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
	self:SetMaxYawSpeed( 90 )
	self.timeStamp = false
end

function ENT:AcceptInput( inn, a, c )	
	if inn == "Use" && c:IsPlayer() && c:IsValid() then
		if c:inventoryHasItem("weedbag", 1) then
			net.Start( "visl_opendrugmenu" )
			net.Send(c)
		else
			c:PrintMessage(HUD_PRINTTALK, "Dont you talk to me unless you got some-o-da goodgood")
		end
	end
end

function characterBuyDrugs(len, ply)
	local weedprice = 200
	local amountofbags = net.ReadString()
	if ply:inventoryHasItem("weedbag", tonumber(amountofbags)) then
		ply:inventoryTakeItem ("weedbag", tonumber(amountofbags))
		ply:SetNWInt("playerMoney", ply:GetNWInt("playerMoney") + weedprice*tonumber(amountofbags))
		if tonumber(amountofbags) > 1 then
			ply:PrintMessage(HUD_PRINTTALK, "Ay thanks for "..amountofbags.." bags, here have "..tostring(weedprice*tonumber(amountofbags)).."$")
		else
			ply:PrintMessage(HUD_PRINTTALK, "Ay thanks for "..amountofbags.." bag, here have "..tostring(weedprice*tonumber(amountofbags)).."$")
		end
	else
		ply:PrintMessage(HUD_PRINTTALK, "Who you foolin? You aint got that many bags on you...")
	end
end
net.Receive("visl_buydrugs", characterBuyDrugs)

-- function ENT:ChangeModel(newModel)
-- 	self:SetModel(newModel)
-- end