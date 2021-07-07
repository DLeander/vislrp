include("shared.lua")

local printerinfo = {}

function ENT:Draw()
    self:DrawModel()

    local Pos = self:GetPos()
    local Ang = self:GetAngles()

    Ang:RotateAroundAxis(Ang:Up(), 90)

    local EntityName = "Basic Money Printer"
    local PrinterOwner = self:GetBuyer()
    local MoneyAmount = self:GetStorage()

    printerinfo = {self, EntityName, PrinterOwner, MoneyAmount}
end

surface.CreateFont( "LookatPrinter", {
    font = "Trebuchet18", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    extended = false,
    size = 20,
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

hook.Add( "HUDDrawTargetID", "BasicPlayerLookAt", function()
    if LocalPlayer():GetEyeTrace().Entity == printerinfo[1] and LocalPlayer():GetPos():DistToSqr( printerinfo[1]:GetPos() ) < 10000 then
        local MouseX, MouseY = gui.MousePos()
        
        if ( MouseX == 0 && MouseY == 0 ) then
        
            MouseX = ScrW() / 2
            MouseY = ScrH() / 2
        
        end
        
        local x = MouseX
        local y = MouseY
        draw.SimpleText( printerinfo[2], "LookatPrinter", x, y+30, Color( 255, 255, 255, 255 ),1  ) --(antalet bokstäver*10)/2
        draw.SimpleText( "Owner: "..printerinfo[3], "LookatPrinter", x, y+50, Color( 255, 227, 132, 255 ), 1 ) --(antalet bokstäver*10)/2
        draw.SimpleText( printerinfo[4].."$", "LookatPrinter", x, y+70, Color( 255, 227, 132, 255 ), 1 ) --(antalet bokstäver*10)/2
    end
end )