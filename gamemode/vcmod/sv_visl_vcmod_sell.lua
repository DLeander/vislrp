hook.Add("VC_canAddMoney", "VC_RestrictSellingSpecificVehicle", function(ply, amount, info)

	-- -- Split the info into prefix and a variable
	-- local data = string.Explode("_", info)

	-- -- Get the prefix
	-- local prefix = data[1]

	-- -- Remove prefix from data chunks
	-- data[1] = nil

	-- -- Get the variable
	-- local var = string.Implode("_", data)

	-- if var and prefix == "CDvehSell" then
	-- 	local model, name, skin = VC_CD_getvehicleDataFromID(var)
	-- 	if model == "models/vehicle.mdl" then
	-- 		--print("Player :"..ply:Nick().." is attempting to sell that one blocked vehicle, stopping.")
	-- 		return
	-- 	end
	-- end

	--print("Player :"..ply:Nick().." is receiving "..amount.." amount of money.")
	-- Lets call our custom gamemode function
    ply:AddToBalance(amount)

	local can = false
	return can
end)