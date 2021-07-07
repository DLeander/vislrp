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
		draw.SimpleText("Anton Cleanholt","textDefaultFont3",140,50,Color(255,255,255),1)
	cam.End3D2D()
	end
end

net.Receive( "visl_opengasstationmenu", function( len, ply )
	local ply = LocalPlayer()
	local frame = vgui.Create( "DFrame" )
	frame:SetSize( 600, 400 )
	frame:Center()
	frame:MakePopup()
	frame:SetTitle("Currently talking to Anton Cleanholt...")

	frame.Paint = function( self, w, h )	-- Paint function w, h = how wide and tall it is.
		-- Draws a rounded box with the color faded_black stored above.
		draw.RoundedBox( 2, 0, 0, w, h, Color( 150, 150, 150, 255 ) )
		-- Draws text in the color white.
	end

	local categoryList = vgui.Create("DCategoryList", frame)
    categoryList:Dock(FILL)
	categoryList:SetPaintBackground(Color( 50, 50, 50, 255 ))
	--categoryList:SetPos( ScrW()/2 - 600/2, ScrH()/2 - 400/2)
    for categoryName, categoryTbl in SortedPairs(GasStationItems) do
        local collapsibleCategory = vgui.Create("DCollapsibleCategory", categoryList)
        collapsibleCategory:SetLabel(categoryName)

        local iconLayout = vgui.Create("DIconLayout", collapsibleCategory)
        collapsibleCategory:SetContents(iconLayout)
		for itemName, itemTbl in SortedPairsByMemberValue(categoryTbl, "Price") do
            local model = itemTbl.Model
            local price = itemTbl.Price
            local jobrequirement = itemTbl.JobRequirement
            
            local icon = vgui.Create("SpawnIcon", iconLayout)
            icon:SetModel(model)
            if jobrequirement == "none" then
                icon:SetToolTip(itemTbl.Name.."\nPrice: ".. price)
            else
                icon:SetToolTip(itemTbl.Name.."\nPrice: ".. price.."\n Job Requirement: ".. jobrequirement)
            end
            icon.DoClick = function()
                if ply:CanAfford(price) then
					net.Start("visl_buyfromgasstation")
						net.WriteString(itemName)
					net.SendToServer()
					notification.AddLegacy("You just purchased "..itemTbl.Name, NOTIFY_GENERIC,5)
				else
					notification.AddLegacy("You do not have enough money to purchase this", NOTIFY_ERROR,5)
                end
            end
        end
	end
end )
