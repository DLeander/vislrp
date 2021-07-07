global_tax = 0

hook.Add("PlayerSay", "visl_tax", function( ply, text )
    local playerMsg = string.Explode(" ", text)
    local plyClass = PLAYER_CLASSES[ply:GetNWInt("playerJob")]

	if (string.lower(playerMsg[1]) == "/tax" and plyClass.name == "District Governor") then
        if (tonumber(playerMsg[2]) >= 0 and tonumber(playerMsg[2]) <= 20) then
            global_tax = tonumber(playerMsg[2])
        else
		    return ""
        end
	end
    --return ""
end)