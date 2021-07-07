include("../config/custom_classes.lua")


local name_icon = Material( "icon16/user.png" )
local description_icon = Material( "icon16/page.png" )
local job_icon = Material( "icon16/bullet_wrench.png" )
local wallet_icon = Material( "icon16/money.png" )
local salary_icon = Material( "icon16/time.png" )


function HUD()
    local client = LocalPlayer()
    local plyClass = PLAYER_CLASSES[client:GetNWInt("playerJob")]

    if !client:Alive() then
        return
    end

    width = 250
    height = 150

    healthheight = 60
    staminaheight = healthheight - 20
    hungerheight = staminaheight - 20

    -- Main Heads up Display:
    draw.RoundedBox(0, 0, ScrH() - height, width, height, Color(50,50,50, 230)) -- amount of roundness, x cord, y cord, width, height, color
    draw.SimpleText("Full Name:  "..client:GetNWString("charName"), "DermaDefaultBold", 25, ScrH() - 130, Color(255,255,255), 0, 0)
    draw.SimpleText("Description: "..client:GetNWString("charDesc"), "DermaDefaultBold", 25, ScrH() - 110, Color(255,255,255), 0, 0)
    draw.SimpleText("Job: " .. plyClass.name, "DermaDefaultBold", 25, ScrH() - 90, Color(255,255,255), 0, 0)
    draw.SimpleText("Wallet: " .. client:GetNWInt("playerMoney").."$", "DermaDefaultBold", 25, ScrH() - 70, Color(255,255,255), 0, 0)
    draw.SimpleText("Salary: " .. plyClass.salary .."$", "DermaDefaultBold", 25, ScrH() - 50, Color(255,255,255), 0, 0)

    -- Health, Stamina and Hunger Display:
    --local healthWidth = (client:Health() / client:GetMaxHealth()) * 100
    draw.RoundedBox(0, ScrW() - 1665, ScrH() - healthheight, 100, 15, Color(50,50,50,100)) -- amount of roundness, x cord, y cord, width, height, color
    draw.RoundedBox(1, ScrW() - 1665, ScrH() - healthheight, client:Health(), 15, Color(255,0,50))
    draw.SimpleText("Health: "..client:Health(), "DermaDefaultBold", ScrW() - 1645, ScrH() - healthheight, Color(255,255,255), 0, 0)

    draw.RoundedBox(0, ScrW() - 1665, ScrH() - staminaheight, 100, 15, Color(50,50,50,100))
    draw.RoundedBox(1, ScrW() - 1665, ScrH() - staminaheight, client:GetNWFloat("visl_stamina"), 15, Color(0, 0, 255))
    draw.SimpleText("Stamina", "DermaDefaultBold", ScrW() - 1640, ScrH() - staminaheight, Color(255,255,255), 0, 0)

    --local hungerWidth = (client:GetNWInt("visl_hunger"))
    draw.RoundedBox(0, ScrW() - 1665, ScrH() - hungerheight, 100, 15, Color(50,50,50,100))
    draw.RoundedBox(1, ScrW() - 1665, ScrH() - hungerheight, client:GetNWInt("visl_hunger")/10000, 15, Color(0,190,75,255))
    draw.SimpleText("Hunger: " .. math.Round(client:GetNWInt("visl_hunger")/10000, 0), "DermaDefaultBold", ScrW() - 1645, ScrH() - hungerheight, Color(255,255,255), 0, 0)

    --Ammo Display:
    if (client:Alive()) then
        if (IsValid(client:GetActiveWeapon())) then
            local curWeapon = client:GetActiveWeapon():GetClass()
        end
        if (IsValid(client:GetActiveWeapon()) && client:GetActiveWeapon():Clip1() != -1 && curWeapon != "weapon_physcannon") then -- Might need to add more weapons to not show ammo here
            draw.RoundedBox(0, ScrW() - 1665, ScrH() - 80, 100, 15, Color(50,50,50,200))
            draw.SimpleText("Ammo: ".. client:GetActiveWeapon():Clip1() .. " / " .. client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()), "DermaDefaultBold", ScrW() - 1650, ScrH() - 80, Color(255,255,255), 0, 0)
        end
    else
        return
    end

    --Display Icons
    surface.SetMaterial(name_icon)
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.DrawTexturedRect( 5, ScrH()-132, 16, 16 )

    surface.SetMaterial(description_icon)
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.DrawTexturedRect( 5, ScrH() - 112, 16, 16 )

    surface.SetMaterial(job_icon)
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.DrawTexturedRect( 5, ScrH() - 92, 16, 16 )

    surface.SetMaterial(wallet_icon)
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.DrawTexturedRect( 5, ScrH() - 72, 16, 16 )

    surface.SetMaterial(salary_icon)
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.DrawTexturedRect( 5, ScrH() - 52, 16, 16 )

    -- Server Information
    draw.SimpleText("Visit www.VislRP.com for all information [VL]", "DermaDefaultBold", ScrW() - 250, ScrH() - 15, Color(255,255,255), 0, 0)

end
hook.Add("HUDPaint", "Hud", HUD)

function GM:HUDDrawTargetID()

	local tr = util.GetPlayerTrace( LocalPlayer() )
	local trace = util.TraceLine( tr )
	if ( !trace.Hit ) then return end
	if ( !trace.HitNonWorld ) then return end

    local startpos = LocalPlayer():EyePos()
	local endpos = LocalPlayer():GetAimVector()
    local distance = trace.StartPos:Distance(trace.HitPos)

    if (distance < 125) then
        surface.CreateFont( "LookatPlayer", {
            font = "Marlett", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
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
        
        local text = "ERROR"
        local font = "LookatPlayer"
        
        if ( trace.Entity:IsPlayer() ) then
            text = trace.Entity:GetNWString("charName")
        else
            return
            --text = trace.Entity:GetClass()
        end
        
        surface.SetFont( font )
        local w, h = surface.GetTextSize( text )
        
        local MouseX, MouseY = gui.MousePos()
        
        if ( MouseX == 0 && MouseY == 0 ) then
        
            MouseX = ScrW() / 2
            MouseY = ScrH() / 2
        
        end
        
        local x = MouseX
        local y = MouseY
        
        x = x - w / 2 - 20
        y = y + 30
        
        local pointedClass = PLAYER_CLASSES[trace.Entity:GetNWInt("playerJob")]
        -- The fonts internal drop shadow looks lousy with AA on
        draw.SimpleText( text, font, x + 1, y + 1, Color( 0, 0, 0, 120 ) )
        draw.SimpleText( text, font, x + 2, y + 2, Color( 0, 0, 0, 50 ) )
        draw.SimpleText( text, font, x, y, Color(255,255,255,255))
        
        y = y + h + 5


        local font = "LookatPlayer"
            
        surface.SetFont( font )
        local w, h = surface.GetTextSize( text )
        local x = MouseX - w / 2
            
        draw.SimpleText( trace.Entity:GetNWString("charDesc"), font, x + 1, y + 1, Color( 0, 0, 0, 120 ) )
        draw.SimpleText( trace.Entity:GetNWString("charDesc"), font, x + 2, y + 2, Color( 0, 0, 0, 50 ) )
        draw.SimpleText( trace.Entity:GetNWString("charDesc"), font, x, y, Color(255,255,255,255)) 

        y = y + h + 5


        local font = "LookatPlayer"
            
        surface.SetFont( font )
        local w, h = surface.GetTextSize( text )
        local x = MouseX - w / 2
            
        draw.SimpleText( pointedClass.name, font, x + 1, y + 1, Color( 0, 0, 0, 120 ) )
        draw.SimpleText( pointedClass.name, font, x + 2, y + 2, Color( 0, 0, 0, 50 ) )
        draw.SimpleText( pointedClass.name, font, x, y, Color(pointedClass.color[1],pointedClass.color[2],pointedClass.color[3],255)) 
        
        y = y + h + 5
        if trace.Entity:Health() <= 100 and trace.Entity:Health() >= 80 then
            local font = "LookatPlayer"
            
            surface.SetFont( font )
            local w, h = surface.GetTextSize( text )
            local x = MouseX - w / 2
            
            draw.SimpleText( "Very Healthy", font, x + 1, y + 1, Color( 0, 0, 0, 120 ) )
            draw.SimpleText( "Very Healthy", font, x + 2, y + 2, Color( 0, 0, 0, 50 ) )
            draw.SimpleText( "Very Healthy", font, x, y, Color(0,255,0,255)) 
        elseif trace.Entity:Health() < 80 and trace.Entity:Health() >= 50 then
            local font = "LookatPlayer"
            
            surface.SetFont( font )
            local w, h = surface.GetTextSize( text )
            local x = MouseX - w / 2
            
            draw.SimpleText( "Healthy", font, x + 1, y + 1, Color( 0, 0, 0, 120 ) )
            draw.SimpleText( "Healthy", font, x + 2, y + 2, Color( 0, 0, 0, 50 ) )
            draw.SimpleText( "Healthy", font, x, y, Color(124,192,5,255)) 
        elseif trace.Entity:Health() < 50 and trace.Entity:Health() >= 30 then
            local font = "LookatPlayer"
            
            surface.SetFont( font )
            local w, h = surface.GetTextSize( text )
            local x = MouseX - w / 2
            
            draw.SimpleText( "Fine", font, x + 1, y + 1, Color( 0, 0, 0, 120 ) )
            draw.SimpleText( "Fine", font, x + 2, y + 2, Color( 0, 0, 0, 50 ) )
            draw.SimpleText( "Fine", font, x, y, Color(245,245,50,255)) 
        else
            local font = "LookatPlayer"
            
            surface.SetFont( font )
            local w, h = surface.GetTextSize( text )
            local x = MouseX - w / 2
            
            draw.SimpleText( "Injured", font, x + 1, y + 1, Color( 0, 0, 0, 120 ) )
            draw.SimpleText( "Injured", font, x + 2, y + 2, Color( 0, 0, 0, 50 ) )
            draw.SimpleText( "Injured", font, x, y, Color(198,69,69,255)) 
        end
    end

end


function HideHud(name)
    for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
       if name == v then
            return false
       end
    end
end
hook.Add("HUDShouldDraw", "HideDefaultHud", HideHud)

