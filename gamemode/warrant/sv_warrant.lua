local nonwarrantjobs = {
    1,
    2,
    3,
    4,
    5,
    6,
    7,
}

local workers = {2,3,4,5,6,7}

hook.Add("PlayerSay", "visl_warrant", function( ply, text )
    local playerMsg = string.Explode(" ", text)
    local plyClass = PLAYER_CLASSES[ply:GetNWInt("playerJob")]

    if (string.lower(playerMsg[1]) == "/warrant" and table.HasValue(workers, ply:GetNWInt("playerJob"))) then
        local userid = tonumber(playerMsg[2])
        local selectedplayer = Player(userid)

        if (!(userid)) then
            return ""
        end

        if (table.HasValue(nonwarrantjobs, selectedplayer:GetNWInt("playerJob"))) then
            ply:PrintMessage(HUD_PRINTTALK, "You can not warrant governmental workers.")
            return ""
        end

        if IsValid(selectedplayer) then
            return
        else
            ply:PrintMessage(HUD_PRINTTALK, tostring(userid).." is not a valid player.")
            return ""
        end
    end

    if (string.lower(playerMsg[1]) == "/warrant" and plyClass.name == "District Governor") then
        local userid = tonumber(playerMsg[2])
        local selectedplayer = Player(userid)
        
        if (!(isnumber(userid))) then
            return ""
        end

        local reasonwithID = string.Replace(text, "/warrant ", "")
        local reason = string.Replace(reasonwithID, tostring(userid).." ", "")
        if IsValid(selectedplayer) then
            if !(table.HasValue(nonwarrantjobs, selectedplayer:GetNWInt("playerJob"))) then
                selectedplayer:SetNWBool("visl_warrant", true)
                selectedplayer:PrintMessage(HUD_PRINTTALK, "You have a warrant for reason: "..reason)
                timer.Create("visl_warrant_"..tostring(userid), 300, 1, function()
                    if IsValid(selectedplayer) then
                        selectedplayer:SetNWBool("visl_warrant", nil)
                        return
                    else
                        return
                    end
                end)
                return
            else
                ply:PrintMessage(HUD_PRINTTALK, "You can not warrant governmental workers.")
                return ""
            end
        else
		    ply:PrintMessage(HUD_PRINTTALK, tostring(userid).." is not a valid player.")
            return ""
        end
    else
        return
	end
end)

-- hook.Add("PlayerCanSeePlayersChat", "visl_warrant_pcspc", function(text, teamOnly, listener, speaker)
--     local playerMsg = string.Explode(" ", text)
--     if (playerMsg[1] == "/warrant") then
--         if table.HasValue(nonwarrantjobs, listener:GetNWInt("playerJob")) then
--             return true
--         else
--             return false
--         end
--     end
-- end)

--timer.Create( string identifier, number delay, number repetitions, function func )