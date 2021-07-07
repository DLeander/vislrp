allowedjobs = {1,2,3,4,5,6,7}

hook.Add("OnPlayerChat", "visl_radio_opc", function(ply, text, teamChat, isDead)
    if (isDead) then return true end
    local playerMsg = string.Explode(" ", text)
    if (string.lower(playerMsg[1]) == "/radio") then
        local newtext = string.Replace(text, "/radio ", "")
        chat.AddText(Color(40,255,119), ply:GetNWString("charName").." speaks in the radio", Color(255,255,255), ": "..newtext)
        return true
    end
end)

-- hook.Add("PlayerSay", "visl_radio_ps", function( ply, text )
--     local playerMsg = string.Explode(" ", text)
--     local plyClass = PLAYER_CLASSES[ply:GetNWInt("playerJob")]

-- 	if (string.lower(playerMsg[1]) == "/radio" and table.HasValue(allowedjobs, ply:GetNWInt("playerJob"))) then
--        return text
--     else
--         return ""
-- 	end
-- end)