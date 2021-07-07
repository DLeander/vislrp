util.AddNetworkString( "visl_openclothesshopmenu" )
util.AddNetworkString( "visl_buyfromclothesshop" )

include("shared.lua")
AddCSLuaFile("config.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")


function ENT:Initialize( )
	self:SetModel( "models/suits/male_06_closed_tie.mdl" )
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
		net.Start( "visl_openclothesshopmenu" )
		net.Send(c)
	end
end

function characterBuyFromClothesShop(len, ply)
	local model = net.ReadString()
	local bg1 = net.ReadUInt(4)
	local bg2 = net.ReadUInt(4)
	local bg3 = net.ReadUInt(4)

	if ply:CanAfford(10000) then
		ply:RemoveFromBalance(10000)
		-- ply:SetModel(model)
		-- ply:SetBodygroup(1, bg1)
		-- ply:SetBodygroup(2, bg2)
		-- ply:SetBodygroup(3, bg3)
		tableofgenderinformation = getGender(ply)
		if tableofgenderinformation[1] == "m" then
			ply:SetNWString("vislrp_m_purchasedplayerModel", model)
			ply:SetNWInt("visl_m_bodygroup1", bg1)
			ply:SetNWInt("visl_m_bodygroup2", bg2)
			ply:SetNWInt("visl_m_bodygroup3", bg3)
			if ply:inventoryHasItem("malebundleofclothes") then
				return
			else
				ply:inventoryGiveItem("malebundleofclothes", 1)
			end
		else
			ply:SetNWString("vislrp_f_purchasedplayerModel", model)
			ply:SetNWInt("visl_f_bodygroup1", bg1)
			ply:SetNWInt("visl_f_bodygroup2", bg2)
			ply:SetNWInt("visl_f_bodygroup3", bg3)
			if ply:inventoryHasItem("femalebundleofclothes") then
				return
			else
				ply:inventoryGiveItem("femalebundleofclothes", 1)
			end
		end
	else
		return
	end
end
net.Receive("visl_buyfromclothesshop", characterBuyFromClothesShop)