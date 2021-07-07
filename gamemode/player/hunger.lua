function InitializePlayerHunger(ply)
    timer.Create("HungerTimer"..ply:UserID(), 300, 0, function()
        local hunger = ply:GetNWInt("visl_hunger")
        ply:SetNWInt("visl_hunger", hunger - math.random(3,7))
        local newhunger = ply:GetNWInt("visl_hunger")

        if newhunger <= 0 then
            ply:Spawn()
            --timer.Remove("HungerTimer"..ply:UserID())
        end

        if newhunger <= 20 then
            ply:PrintMessage(HUD_PRINTCENTER, "You are getting hungry...")
        end

        if newhunger <= 15 then
            ply:PrintMessage(HUD_PRINTCENTER, "You are getting more hungry...")
        end

        if newhunger <= 10 then
            ply:PrintMessage(HUD_PRINTCENTER, "You are getting very hungry...")
        end

        if newhunger <= 5 then
            ply:PrintMessage(HUD_PRINTCENTER, "You are getting extremely hungry...")
        end

    end) -- timer name, time in sec, how often
end

-- hook.Add( "PlayerTick", "DoHungerSystem", function( ply )
-- 	local hunger = ply:GetNWInt("visl_hunger")
--     local newhunger = ply:SetNWInt("visl_hunger", hunger - math.random(3,10))
--     if hunger > 1000000 then
--         ply:SetNWInt("visl_hunger", 1000000)
--     end
--     if hunger <= 0 then
--         ply:Spawn()
--         --timer.Remove("HungerTimer"..ply:UserID())
--     end

--     if hunger == 200000 then
--         ply:PrintMessage(HUD_PRINTCENTER, "You are getting hungry...")
--     end

--     if hunger == 150000 then
--         ply:PrintMessage(HUD_PRINTCENTER, "You are getting more hungry...")
--     end

--     if hunger == 100000 then
--         ply:PrintMessage(HUD_PRINTCENTER, "You are getting very hungry...")
--     end

--     if hunger == 50000 then
--         ply:PrintMessage(HUD_PRINTCENTER, "You are getting extremely hungry...")
--     end
-- end)