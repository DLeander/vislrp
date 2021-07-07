include("shared.lua")
include("hud/hud.lua")
include("menus/f4menu.lua")
include("scoreboard/scoreboard.lua")
include("player/sh_player.lua")
include("market/sh_market.lua")
include("menus/characterselect.lua")
include("menus/changemodelmenu.lua")
include("menus/changecharinfomenu.lua")
include("config/custom_classes.lua")
include("database/cl_database.lua")
include("database/items.lua")
include("government/cl_radio.lua")
include("warrant/cl_warrant.lua")
-- include("doors/cl_door.lua")

-- Disable context menu to prevent player model change.
function GM:ContextMenuOpen()
    return true
end

local function visl_pickup_keyQ()
    if input.IsKeyDown(KEY_E) then
        net.Start("VISL_KEY_Q")
        net.SendToServer()

        hook.Call("VISL_KEY_Q", GAMEMODE, ply)
    end
end
hook.Add("Think", "q_pressed", visl_pickup_keyQ)

function GM:PreDrawHalos()
    halo.Add(ents.FindByClass("item_basic"), Color(255,255,255), 1, 1, 5, true, false) 
end

-- function GM:OnPlayerChat(ply, text, teamChat, isDead)
--     if (isDead) return end

--     local plyClass = PLAYER_CLASSES[ply:GetNWInt("playerJob")]
--     chat.AddText( Color( plyClass.Color[1], plyClass.Color[2], plyClass.Color[3] ), ply:GetNWString("charName"), text, Color( 255, 255, 255 ))
--     return true
-- end

hook.Add("OnPlayerChat", "visl_radio", function(ply, text, teamChat, isDead)
    if (isDead) then return true end

    local plyClass = PLAYER_CLASSES[ply:GetNWInt("playerJob")]
    local playerMsg = string.Explode(" ", text)

    if (string.lower(playerMsg[1]) == "/warrant") then

        local workers = {1,2,3,4,5,6,7}
        if (!(table.HasValue(workers, ply:GetNWInt("playerJob")))) then
            return false
        end
        
        local userid = tonumber(playerMsg[2])
        local selectedplayer = Player(userid)
        local reasonwithID = string.Replace(text, "/warrant ", "")
        local reason = string.Replace(reasonwithID, tostring(userid).." ", "")
        if (ply:GetNWInt("playerJob") != 1) then
            chat.AddText(Color(40,255,119), ply:GetNWString("charName").." speaks in the radio", Color(255,255,255), ": Please warrant ".."["..tostring(userid).."]".." for reason: "..reason)
            return true
        else
            chat.AddText(Color(40,255,119), ply:GetNWString("charName").." speaks in the radio", Color(255,255,255), ": ".."["..tostring(userid).."]".." has been warranted for reason: "..reason)
            return true
        end
    end

    if (string.lower(playerMsg[1]) == "/law" and plyClass.name == "District Governor") then
        local newtext = string.Replace(text, "/law", "")
        chat.AddText(Color(255,0,0), "The governor has issued a new law", Color(255,255,255), ": "..newtext)
        return true
    end

    if string.lower(playerMsg[1]) == "/ooc" then
        local newtext = string.Replace(text, "/ooc ", "")
        chat.AddText(Color(240,240,100), "(OOC) ", Color( plyClass.color[1], plyClass.color[2], plyClass.color[3] ), ply:GetNWString("charName"), Color( 255, 255, 255 ), ": "..newtext)
        return true
    end

    if string.StartWith(text, "// ") then
        local newtext = string.Replace(text, "// ", "")
        chat.AddText(Color(240,240,100), "(OOC) ", Color( plyClass.color[1], plyClass.color[2], plyClass.color[3] ), ply:GetNWString("charName"), Color( 255, 255, 255 ), ": "..newtext)
        return true
    elseif string.StartWith(text, "//") then
        local newtext = string.Replace(text, "//", "")
        chat.AddText(Color(240,240,100), "(OOC) ", Color( plyClass.color[1], plyClass.color[2], plyClass.color[3] ), ply:GetNWString("charName"), Color( 255, 255, 255 ), ": "..newtext)
        return true
    end

    if string.lower(playerMsg[1]) == "/tax" then
        local newtext = string.Replace(text, "/ooc ", "")
        chat.AddText(Color( 255,0,0 ), "The governor has set a new tax of: "..playerMsg[2])
        return true
    end

    if string.lower(playerMsg[1]) == "/w" then
        local newtext = string.Replace(text, "/w ", "")
        chat.AddText( Color( plyClass.color[1], plyClass.color[2], plyClass.color[3] ), ply:GetNWString("charName"), Color(63,132,222), " whispers", Color( 255, 255, 255 ), ": "..newtext)
        return true
    elseif string.lower(playerMsg[1]) == "/whisper" then
        local newtext = string.Replace(text, "/whisper ", "")
        chat.AddText( Color( plyClass.color[1], plyClass.color[2], plyClass.color[3] ), ply:GetNWString("charName"), Color(63,132,222), " whispers", Color( 255, 255, 255 ), ": "..newtext)
        return true
    end

    if string.lower(playerMsg[1]) == "/y" then
        local newtext = string.Replace(text, "/y ", "")
        chat.AddText( Color( plyClass.color[1], plyClass.color[2], plyClass.color[3] ), ply:GetNWString("charName"), Color(218,70,70), " yells", Color( 255, 255, 255 ), ": "..newtext)
        return true
    elseif string.lower(playerMsg[1]) == "/yell" then
        local newtext = string.Replace(text, "/yell ", "")
        chat.AddText( Color( plyClass.color[1], plyClass.color[2], plyClass.color[3] ), ply:GetNWString("charName"), Color(218,70,70), " yells", Color( 255, 255, 255 ), ": "..newtext)
        return true
    end

    chat.AddText( Color( plyClass.color[1], plyClass.color[2], plyClass.color[3] ), ply:GetNWString("charName").." says", Color( 255, 255, 255 ), ": "..text)
    return true
end)