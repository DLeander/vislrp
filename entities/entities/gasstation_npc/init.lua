util.AddNetworkString( "visl_opengasstationmenu" )
util.AddNetworkString( "visl_buyfromgasstation" )

include("shared.lua")
AddCSLuaFile("config.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")


function ENT:Initialize( )
	self:SetModel( "models/Humans/Group01/male_07.mdl" )
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
		net.Start( "visl_opengasstationmenu" )
		net.Send(c)
	end
end

function characterBuyFromGasStation(len, ply)
	local itemName = net.ReadString()
	local price = MARKETTABLE.MarketItems["Gas Station Foods"][itemName].Price
	if ply:CanAfford(price) then
		ply:RemoveFromBalance(price)
		ply:inventoryGiveItem(itemName, 5)
	else
		return
	end
end
net.Receive("visl_buyfromgasstation", characterBuyFromGasStation)