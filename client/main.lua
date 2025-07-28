local MathUtils = require('client.math_utils')
local WeaponData = require('client.weapon_data')

local isShootingEnabled = true
local mainThreadActive = false

local function FireWeaponWithSnapshot(weaponHash, muzzleX, muzzleY, muzzleZ, destination)

    local weaponConfig = WeaponData.getWeaponConfig(weaponHash)


    local currentAmmo = GetAmmoInPedWeapon(cache.ped, weaponHash)
    if currentAmmo <= 0 then
        PlaySoundFrontend(-1, "WEAPON_EMPTY", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
        return
    end


    local endX, endY, endZ = MathUtils.calculateBulletTrajectory(
        muzzleX, muzzleY, muzzleZ,
        destination.x, destination.y, destination.z,
        weaponConfig.accuracy
    )

    SetPedShootsAtCoord(cache.ped, endX, endY, endZ, true)




    SetPedCurrentWeaponVisible(cache.ped, true, true, true, true)





    WeaponData.updateShotTime(weaponHash)
end

local function HandleRealisticShooting()
    if IsPedDeadOrDying(cache.ped, false) then
        return
    end

    if cache.vehicle then
        return
    end

    if not cache.weapon then
        return
    end

    if not IsPlayerFreeAiming(PlayerId()) or IsPedUsingAnyScenario(cache.ped) or IsEntityPlayingAnim(cache.ped, "move_dual", "roll_fwd", 3) or GetEntityAnimCurrentTime(cache.ped, 0, 0) > 0 or IsEntityPlayingAnim(cache.ped, "weapons@pistol@pistol_fp", "fire", 3) or IsPedReloading(cache.ped) or not WeaponData.canFire(cache.weapon) then
        return
    end
    local isShootingPressed = IsDisabledControlJustPressed(0, 24)
    local isShootingHeld = IsDisabledControlPressed(0, 24)

    if isShootingPressed or isShootingHeld then
        local muzzleX, muzzleY, muzzleZ, playerRotation, destination = MathUtils.getWeaponMuzzlePosition()
        FireWeaponWithSnapshot(cache.weapon, muzzleX, muzzleY, muzzleZ, destination)
    end
end



Citizen.CreateThread(function()
    print("^2[Snowy Shooting Rethinked] Realistic shooting system initialized^0")
    mainThreadActive = true

    while mainThreadActive do
        if Config.EnableRealisticShooting and isShootingEnabled then
            local isAiming = IsPlayerFreeAiming(PlayerId())

            if isAiming then
                Wait(0)
                DisablePlayerFiring(PlayerId(), true)
                HandleRealisticShooting()
            else
                Wait(100)
                DisablePlayerFiring(PlayerId(), true)
            end
        else
            Wait(100)
            DisablePlayerFiring(PlayerId(), false)
        end
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print("^2[Snowy Shooting Rethinked] Resource started^0")
        DisablePlayerFiring(PlayerId(), true)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print("^1[Snowy Shooting Rethinked] Resource stopped^0")
        mainThreadActive = false
        WeaponData.cleanup()
        MathUtils.cleanup()
        DisablePlayerFiring(PlayerId(), false)
    end
end)