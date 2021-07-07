AddCSLuaFile()

local prisoncelllocations = {
    Vector(438.504242 -2355.573975 -363.968750-65),
    Vector(562.057434 -2329.696045 -363.968750-65),
    Vector(692.461792 -2328.395020 -363.968750-65),
    Vector(823.501160 -2340.213379 -363.968750-65),
    Vector(833.679077 -1990.438477 -363.968750-65),
    Vector(707.702515 -2013.481567 -363.968750-65),
    Vector(581.696045 -2000.817871 -363.968750-65),
    Vector(443.507874 -2009.304077 -363.968750-65)
}

SWEP.Author = "Dexter"
SWEP.Base = "weapon_base"
SWEP.PrintName = "Arrest Baton"
SWEP.Instructions = "Left click to arrest warranted player"
SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"
SWEP.SetHoldType = "melee"
SWEP.Category = "VislRP"
SWEP.ShouldDropOnDie = false

SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false

SWEP.Slot = 4
SWEP.SlotPos = 0

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Spawnable = true
SWEP.AdminSpawnable = true


SWEP.Primary.ClipSize = 0
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = false
SWEP.Primary.Recoil = 5
SWEP.Primary.Damage = 0
SWEP.Primary.NumShots = 0
SWEP.Primary.Spread = 0
SWEP.Primary.Cone = 0
SWEP.Primary.Clone = 0
SWEP.Primary.Delay = 3

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false

--local ShootSound = Sound()
function SWEP:Initialize()
    self:SetHoldType("melee")
end

function SWEP:PrimaryAttack()
    -- if (not self:CanPrimaryAttack()) then
    --     return
    -- end
    if (CLIENT) then return end

    local ply = self:GetOwner()

    ply:LagCompensation(true)

    local shootpos = ply:GetShootPos()
    local endshootpos = shootpos + ply:GetAimVector() * 50
    local tmin = Vector(1,1,1) * -10
    local tmax = Vector(1,1,1) * 10

    local tr = util.TraceHull({
        start = shootpos,
        endpos = endshootpos,
        filter = ply,
        mask = MASK_SHOT_HULL,
        mins = tmin,
        maxs = tmax 
    })
    
    if (not IsValid(tr.Entity)) then
        tr = util.TraceLine({
            start = shootpos,
            endpos = endshootpos,
            filter = ply,
            mask = MASK_SHOT_HULL 
        })
    end

    local ent = tr.Entity
    if (IsValid(ent) && (ent:IsPlayer() || ent:IsNPC())) then
        self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
        ply:SetAnimation(PLAYER_ATTACK1)
        if ent:GetNWBool("visl_warrant") == true then
            ent:SetNWBool("visl_arrested", true)
            ent:SetNWBool("visl_warrant", nil)
            ent:StripWeapons()
            ent:SetRunSpeed(100)
            ent:SetWalkSpeed(100)

            local finalmodel = ""
            local playermodel = ent:GetNWString("charModel")
            local explstr = string.Explode("/",playermodel)
            local charactertype = string.Replace(explstr[#explstr],".mdl","")
            print(charactertype)
            finalmodel = string.Replace("models/player/Group01/HERE.mdl","HERE",charactertype)

            ent:SetModel(finalmodel)
            ent:SetPlayerColor(Vector(255, 144, 0))
            ent:SetPos(prisoncelllocations[math.random(1,8)])

            timer.Create("visl_arrested_"..tostring(ent:UserID()), 300, 1, function()
                ent:SetNWBool("visl_arrested", nil)
                ent:Spawn()
            end)
        else
            return
        end
    elseif (!IsValid(ent)) then
        self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
        ply:SetAnimation(PLAYER_ATTACK1)
    end
    self:SetNextPrimaryFire(CurTime() + self:SequenceDuration() + 0.1)
    ply:LagCompensation(false)
end

function SWEP:CanSecondaryAttack()
    return false
end

function SWEP:ShouldDropOnDie()
    return false
end