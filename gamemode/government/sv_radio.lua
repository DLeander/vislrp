allowedjobs = {1,2,3,4,5,6,7}

hook.Add("PlayerCanSeePlayersChat", "visl_radio_pcspc", function(text, teamOnly, listener, speaker)
    local playerMsg = string.Explode(" ", text)
    if (playerMsg[1] == "/radio") then
        if table.HasValue(allowedjobs, listener:GetNWInt("playerJob")) then
            return true
        else
            return false
        end
    end
end)