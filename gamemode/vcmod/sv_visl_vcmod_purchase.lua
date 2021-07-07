hook.Add("VC_canRemoveMoney", "VC_RestrictBuyingSpecificVehicle", function(ply, amount, info)

	-- -- Split the info into prefix and a variable
	-- local data = string.Explode("_", info)

	-- -- Get the prefix
	-- local prefix = data[1]

	-- -- Remove prefix from data chunks
	-- data[1] = nil

	-- -- Get the variable
	-- local var = string.Implode("_", data)

	-- if var and prefix == "CDvehBuy" then
	-- 	local model, name, skin = VC_CD_getvehicleDataFromID(var)
	-- 	if model == "models/vehicle.mdl" then
	-- 		--print("Player :"..ply:Nick().." is attempting to buy that one blocked vehicle, stopping.")
	-- 		return
	-- 	end
	-- end

	--print("Player :"..ply:Nick().." is attempting to spend "..amount.." amount of money.")

	-- Lets call our custom gamemode function
	ply:RemoveFromBalance(amount)

	local can = false
	return can
end)