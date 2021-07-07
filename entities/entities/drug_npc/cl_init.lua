include("shared.lua")

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
		draw.SimpleText("Getty Domein","textDefaultFont3",140,50,Color(255,255,255),1)
	cam.End3D2D()
	end
end

net.Receive( "visl_opendrugmenu", function( len, ply )
	local amountofbags

	local DFrame = vgui.Create( "DFrame" ) 	-- The name of the panel we don't have to parent it.
	DFrame:SetPos( ScrW()/2 - 300/2, ScrH()/2 - 200/2) 				-- Set the position to 100x by 100y. 
	DFrame:SetSize( 300, 100 ) 				-- Set the size to 300x by 200y.
	DFrame:SetTitle( "Talking to potential buyer" ) 		-- Set the title in the top left to "Derma Frame".
	DFrame:SetDraggable( false )
	DFrame:MakePopup() 						-- Makes your mouse be able to move around.

	DFrame.Paint = function( self, w, h )	-- Paint function w, h = how wide and tall it is.
		-- Draws a rounded box with the color faded_black stored above.
		draw.RoundedBox( 2, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
		-- Draws text in the color white.
		draw.SimpleText( "How many bags would you like to sell?", "default", 100, 35, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local amountInput = vgui.Create( "DTextEntry", DFrame)
    amountInput:SetUpdateOnType(true)
    amountInput:SetSize(82,22)
    amountInput:SetPos(10,50)
	amountInput:SetNumeric( true )
    amountInput:SetPlaceholderText("Number of bags")
    --NameInput:SetValue(oldName)
    amountInput.OnValueChange = function()
        amountofbags = amountInput:GetValue()
    end

	local buttonSell = vgui.Create("DButton", DFrame)
	buttonSell:SetSize(75,30)
	buttonSell:SetPos(220, 65)
	buttonSell:SetText("Sell Bags")
	buttonSell.DoClick = function()
		if (tonumber(amountofbags) != nil) then
			net.Start("visl_buydrugs")
			net.WriteString(amountofbags)
			net.SendToServer()
			DFrame:Close()
		else
			return
		end
    end

end )
