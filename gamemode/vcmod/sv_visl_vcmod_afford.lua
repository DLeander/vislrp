hook.Add("VC_canAfford", "customMoneyz_Has", function(ply, amount)
	--print("Player :"..ply:Nick().." is checking if he has "..amount.." amount of money.")

	-- Lets call our custom gamemode function

	local can = ply:CanAfford(amount)
	return can
end)