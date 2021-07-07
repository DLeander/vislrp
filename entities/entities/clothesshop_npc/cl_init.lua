include("shared.lua")
include("config.lua")

function ENT:Initialize()
	surface.CreateFont( "textDefaultFont3", {
		font = "Roboto-Regular", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = 30,
		weight = 50,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )
end

function ENT:Draw()
	self:DrawModel()
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	Ang:RotateAroundAxis(self:GetAngles():Right(),270)
	Ang:RotateAroundAxis(self:GetAngles():Forward(),90)
	if(CurTime() >= 5) then
	cam.Start3D2D(Pos + Ang:Forward() * -15 + Ang:Right() * -82, Ang, 0.1)
		--draw.RoundedBox(4,0,0,300,70,Color(0,0,0,165))
		draw.SimpleText("Bulwin Angy","textDefaultFont3",140,50,Color(255,255,255),1)
	cam.End3D2D()
	end
end

net.Receive( "visl_openclothesshopmenu", function( len, ply )
	local ply = LocalPlayer()
	local selected_clothing

	local frame = vgui.Create( "DFrame" )
	frame:SetSize( 600, 400 )
	frame:Center()
	frame:MakePopup()
	frame:SetTitle("Currently talking to Bulwin Angy...")
	frame.Paint = function()
        surface.SetDrawColor(50,50,50,230)
        surface.DrawRect(0,0,frame:GetWide(), frame:GetTall())

        surface.SetDrawColor(20,20,20,255)
        surface.DrawRect(0,24, frame:GetWide(), 1)
        draw.DrawText("Select the outfit you want to buy.", "DermaDefaultBold", 100, 30, Color(255,255,255,255), 1)
		draw.DrawText("The price of an outfit is 10,000$", "DermaDefaultBold", 93, 45, Color(255,100,255,255), 1)
    end

	local ModelView = vgui.Create("DModelPanel", frame)
    ModelView:SetSize(350,350)
    ModelView:SetPos(300,15)
    ModelView:SetFOV(55)
	ModelView:SetModel(ply:GetNWString("charModel"))
    ModelView:SetCamPos(ModelView:GetCamPos() + Vector(0,0,15))
    function ModelView:LayoutEntity(ent) return end

	local DComboBox = vgui.Create("DComboBox", frame)
	DComboBox:SetPos(10, 70)
	DComboBox:SetSize(165, 20)

	tableofgenderinformation = getGender(ply)
	if tableofgenderinformation[1] == "f" then
		DComboBox:SetValue("Select your New Style")
		-- Should just be a for loop, this way is dumb.. The same goes for similar implementations.
		DComboBox:AddChoice("Clothing Style 1")
		DComboBox:AddChoice("Clothing Style 2")
		DComboBox:AddChoice("Clothing Style 3")
		DComboBox:AddChoice("Clothing Style 4")
		DComboBox:AddChoice("Clothing Style 5")
		DComboBox:AddChoice("Clothing Style 6")

		DComboBox.OnSelect = function(self, index, value)
			if index == 1 then
				ModelView:SetModel("models/smalls_civilians/pack2/female/hoodiepulloverjeans/"..tableofgenderinformation[2].."_hoodiepulloverjeans_pm.mdl")
				modelSelected = 1
			elseif index == 2 then
				ModelView:SetModel("models/smalls_civilians/pack2/female/hoodiepulloversweats/"..tableofgenderinformation[2].."_hoodiepulloversweats_pm.mdl")
				modelSelected = 2
			elseif index == 3 then
				ModelView:SetModel("models/smalls_civilians/pack2/female/hoodiezippedjeans/"..tableofgenderinformation[2].."_hoodiezippedjeans_pm.mdl")
				modelSelected = 3
			elseif index == 4 then
				ModelView:SetModel("models/smalls_civilians/pack2/female/hoodiezippedsweats/"..tableofgenderinformation[2].."_hoodiezippedsweats_pm.mdl")
				modelSelected = 4
			elseif index == 5 then
				ModelView:SetModel("models/smalls_civilians/pack2/female/parkajeans/"..tableofgenderinformation[2].."_parkajeans_pm.mdl")
				modelSelected = 5
			elseif index == 6 then
				ModelView:SetModel("models/smalls_civilians/pack2/female/parkasweats/"..tableofgenderinformation[2].."_parkasweats_pm.mdl")
				modelSelected = 6
			end
		end
	else
		DComboBox:AddChoice("Clothing Style 1")
		DComboBox:AddChoice("Clothing Style 2")
		DComboBox:AddChoice("Clothing Style 3")
		DComboBox:AddChoice("Clothing Style 4")
		DComboBox:AddChoice("Clothing Style 5")
		DComboBox:AddChoice("Clothing Style 6")
		DComboBox:AddChoice("Clothing Style 7")

		DComboBox.OnSelect = function(self, index, value)
			if index == 1 then
				ModelView:SetModel("models/smalls_civilians/pack2/male/baseballtee/"..tableofgenderinformation[2].."_baseballtee_pm.mdl")
				modelSelected = 1
			elseif index == 2 then
				ModelView:SetModel("models/smalls_civilians/pack2/male/flannel/"..tableofgenderinformation[2].."_flannel_pm.mdl")
				modelSelected = 2
			elseif index == 3 then
				ModelView:SetModel("models/smalls_civilians/pack2/male/leatherjacket/"..tableofgenderinformation[2].."_leather_jacket_pm.mdl")
				modelSelected = 3
			elseif index == 4 then
				ModelView:SetModel("models/smalls_civilians/pack2/male/hoodie_jeans/"..tableofgenderinformation[2].."_hoodiejeans_pm.mdl")
				modelSelected = 4
			elseif index == 5 then
				ModelView:SetModel("models/smalls_civilians/pack2/male/hoodie_sweatpants/"..tableofgenderinformation[2].."_hoodiesweatpants_pm.mdl")
				modelSelected = 5
			elseif index == 6 then
				ModelView:SetModel("models/smalls_civilians/pack2/male/jacket_open/"..tableofgenderinformation[2].."_jacketopen_pm.mdl")
				modelSelected = 6
			elseif index == 7 then
				ModelView:SetModel("models/smalls_civilians/pack2/male/jacketvneck_sweatpants/"..tableofgenderinformation[2].."_jacketvneck_sweatpants_pm.mdl")
				modelSelected = 7
			end
		end
	end

	local DComboBoxBg1 = vgui.Create("DComboBox", frame)
	DComboBoxBg1:SetValue( "Bodygroup 1" )
	DComboBoxBg1:SetPos(200, 70)
	DComboBoxBg1:SetSize(165, 20)
	for i=1,ModelView:GetEntity():GetBodygroupCount(1) do 
		DComboBoxBg1:AddChoice( "Alternative "..tostring(i), nil, false)
	end 
	function DComboBoxBg1:OnSelect( index, text, data )
		ModelView:GetEntity():SetBodygroup(1, index-1)
	end

	local DComboBoxBg2 = vgui.Create("DComboBox", frame)
	DComboBoxBg2:SetValue( "Bodygroup 2" )
	DComboBoxBg2:SetPos(200, 140)
	DComboBoxBg2:SetSize(165, 20)
	for i=1,ModelView:GetEntity():GetBodygroupCount(2) do 
		DComboBoxBg2:AddChoice( "Alternative "..tostring(i), nil, false)
	end 
	function DComboBoxBg2:OnSelect( index, text, data )
		ModelView:GetEntity():SetBodygroup(2, index-1)
	end

	local DComboBoxBg3 = vgui.Create("DComboBox", frame)
	DComboBoxBg3:SetValue( "Bodygroup 3" )
	DComboBoxBg3:SetPos(200, 210)
	DComboBoxBg3:SetSize(165, 20)
	for i=1,ModelView:GetEntity():GetBodygroupCount(3) do 
		DComboBoxBg3:AddChoice( "Alternative "..tostring(i), nil, false)
	end
	function DComboBoxBg3:OnSelect( index, text, data )
		ModelView:GetEntity():SetBodygroup(3, index-1)
	end

	local doneButton = vgui.Create( "DButton", frame )
	doneButton:SetText( "Purchase Clothing" )
	doneButton:SetPos( 10, 350 )
	doneButton:SetSize( 250, 30 )

	doneButton.DoClick = function()
		if ply:CanAfford(1) then
			if DComboBoxBg1:GetSelectedID() == nil or DComboBoxBg2:GetSelectedID() == nil or DComboBoxBg3:GetSelectedID() == nil then
				return
			end
			-- if !isnumber(DComboBoxBg1:GetSelectedID()-1) or !isnumber(DComboBoxBg2:GetSelectedID()-1) or !isnumber(DComboBoxBg3:GetSelectedID()-1) then
			-- 	return
			-- end

			net.Start("visl_buyfromclothesshop")
				net.WriteString(tostring(ModelView:GetModel()))
				net.WriteUInt(tonumber(DComboBoxBg1:GetSelectedID())-1, 4)
				net.WriteUInt(tonumber(DComboBoxBg2:GetSelectedID())-1, 4)
				net.WriteUInt(tonumber(DComboBoxBg3:GetSelectedID())-1, 4)
			net.SendToServer()
			notification.AddLegacy("You just purchased some new clothes!", NOTIFY_GENERIC,5)
			frame:Close()
		else
			notification.AddLegacy("You do not have enough money to purchase this", NOTIFY_ERROR,5)
			frame:Close()
		end
	end
end )

local function getGender(ply)
	local playermodel = ply:GetNWString("charModel")

	local explstr = string.Explode("/", playermodel)
    local explstr2 = string.Explode("_", explstr[#explstr])
    local charactertype = explstr2[1].."_"..explstr2[2]

	local substring = string.sub(charactertype, 1, 1 )
	local table_of_gender = {substring, charactertype}

	return table_of_gender
end
