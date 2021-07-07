include("shared.lua")
surface.CreateFont( "textDefaultFont", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 16,
	weight = 500,
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
surface.CreateFont( "textDefaultFont2", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 15,
	weight = 500,
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

-- net.Receive("noti",function(len, ply) 
-- 	local notiString = net.ReadString()
-- 	local notiSound = net.ReadString()
-- 	local notiType = net.ReadInt(3)
-- 	notification.AddLegacy( notiString, notiType, 5 )
-- 	surface.PlaySound( notiSound )
-- 	end )

function ENT:Draw()
	self:DrawModel()
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	local bottomText = nil
	Ang:RotateAroundAxis(self:GetAngles():Forward(),90)
	-- cam.Start3D2D(Pos + Ang:Up() * 10, Ang, 0.1)
	-- 	draw.RoundedBox(8,-71,-130,145,30,Color(0,0,0,165))
	-- 	draw.RoundedBox(8,-99,-90,200,30,Color(0,0,0,165))
	-- 	draw.SimpleText("Weed Plant lvl: "..self:Getlvl().."/7","textDefaultFont",0,-125,Color(255,255,255),1)
	-- 	if(self:Getlvl() == 7) then 
	-- 		bottomText = "Plant ready. Press E(use) to harvest"
	-- 	else
	-- 		bottomText = "Plant not ready"
	-- 	end
	-- 	draw.SimpleText(bottomText,"textDefaultFont2",0,-83,Color(255,255,255),1)
	-- cam.End3D2D()
	end

