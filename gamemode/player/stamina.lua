sound.Add( {
	name = "low_stamina_breath",
	channel = CHAN_STATIC,
	volume = 1,
	level = 60,
	pitch = { 80, 120 },
	sound = "player/breathe1.wav"
} )

hook.Add( "PlayerInitialSpawn", "SetUpDefaultValues", function( ply )

	ply.DEFAULTRUN = ply:GetRunSpeed()
	ply.DEFAULTWALK = ply:GetWalkSpeed()
	ply.DEFAULTJUMP = ply:GetJumpPower()

end )

hook.Add( "PlayerTick", "DoStaminaSystem", function( ply )

	local numup = 0
	if !ply:Alive() then return end
	if !ply:OnGround() then 
		numup = 0.2
	else
		numup = 0.2
	end
	--regen stamina
	ply:SetNWFloat( "visl_stamina", math.Clamp( ply:GetNWFloat( "visl_stamina", ply:GetNWFloat( "staminacap", 100 ) ) + numup, 0, 100 ) )
	--if you're running at the default value, but are actually slower than walking
	if ply:IsSprinting() and ply:GetRunSpeed() == ply.DEFAULTRUN and ply:GetVelocity():Length() >= ply.DEFAULTWALK and ply:OnGround() then
		ply:SetNWFloat( "visl_stamina", math.Clamp( ply:GetNWFloat( "visl_stamina" ) - 0.3, 0, 100 ) )
	--stamina drain underwater
	elseif ply:WaterLevel() >= 2 then
		if ply:IsSprinting() then
			ply:SetNWFloat( "visl_stamina", math.Clamp( ply:GetNWFloat( "visl_stamina" ) - 0.5, 0, 100 ) )
		else
			ply:SetNWFloat( "visl_stamina", math.Clamp( ply:GetNWFloat( "visl_stamina" ) - 0.5, 0, 100 ) )
		end
	end
	--exhaustion
	if ply:GetNWFloat( "visl_stamina" ) <= 25 then
		if !ply:IsSprinting() or ply:GetNWFloat( "visl_stamina" ) == 0 then
			ply:SetWalkSpeed( ply.DEFAULTWALK * 0.625 )
			ply:SetRunSpeed( ply.DEFAULTWALK * 0.625 )
		end
		ply:SetJumpPower( ply.DEFAULTJUMP / 2 )
		if !ply.soundisplaying then
			ply:EmitSound( "low_stamina_breath" )
			ply.soundisplaying = true
		end
	else
		ply:SetWalkSpeed( ply.DEFAULTWALK )
		ply:SetRunSpeed( ply.DEFAULTRUN )
		ply:SetJumpPower( ply.DEFAULTJUMP )
		if ply.soundisplaying then
			ply:StopSound( "low_stamina_breath" )
			ply.soundisplaying = false
			--ply:EmitSound( "player/suit_sprint.wav" )
		end
	end
	
end )

hook.Add( "KeyPress", "DecreaseStaminaOnJump", function( ply, key )

	if !ply:Alive() then return end
	if ply:InVehicle() then return end
	if !ply:OnGround() then return end
	if key == IN_JUMP then
		ply:SetNWFloat( "visl_stamina", math.Clamp( ply:GetNWFloat( "visl_stamina" ) - 15, 0, 100 ) )
	end

end )

hook.Add( "PlayerDeath", "ResetStamina", function( ply )

	ply:SetNWFloat( "visl_stamina", 1000 )
	ply:StopSound( "low_stamina_breath" )
	ply.soundisplaying = false

end )