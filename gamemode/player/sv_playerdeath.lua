local govTable = {1,2,3,4,5,6,7}
local nondropweps = {"weapon_fists", "gmod_tool", "weapon_physgun", "weapon_keys", "weapon_physcannon"}

hook.Add( "PlayerDeath", "GovernorDeath", function( victim, inflictor, attacker )
    if ( victim:GetNWInt("playerJob") == 1 ) then
        PrintMessage(HUD_PRINTTALK, "The governor has been killed.")
        global_tax = 0
        global_law_table = {}
        net.Start("visl_SyncLaws")
            net.WriteTable(global_law_table)
        net.Broadcast()
        victim:SetNWInt("playerJob", 8)
    end
end )

hook.Add( "PlayerDeath", "visl_PlayerDeath", function( victim, inflictor, attacker )
    if !table.HasValue(govTable, victim:GetNWInt("playerJob")) then
        for k,v in pairs(victim:GetWeapons()) do
            if !table.HasValue(nondropweps, v:GetClass()) then
                CreateItem(victim, v:GetClass(), itemSpawnPos(victim))
                --print(v:GetClass())
            end
        end
    end
end )