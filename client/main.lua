local MathUtils = require('client.math_utils')
local WeaponData = require('client.weapon_data')

local isShootingEnabled = true
local mainThreadActive = false
local lastFireCheck = 0
local fireCheckThrottle = 16
local lastNetworkFire = 0
local networkFireThrottle = 100
local isCurrentlyShooting = false
local lastShootingCheck = 0

local function FireWeaponWithSnapshot(weaponHash, muzzleX, muzzleY, muzzleZ, destination)
    local currentTime = GetGameTimer()

    if (currentTime - lastNetworkFire) < networkFireThrottle then
        return
    end
    lastNetworkFire = currentTime

    local weaponConfig = WeaponData.getWeaponConfig(weaponHash)
    local currentAmmo = GetAmmoInClip(cache.ped, weaponHash)

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
        return false
    end

    if cache.vehicle then
        return false
    end

    if not cache.weapon then
        return false
    end

    if not IsPlayerFreeAiming(PlayerId()) or IsPedUsingAnyScenario(cache.ped) or IsEntityPlayingAnim(cache.ped, "move_dual", "roll_fwd", 3) or GetEntityAnimCurrentTime(cache.ped, 0, 0) > 0 or IsEntityPlayingAnim(cache.ped, "weapons@pistol@pistol_fp", "fire", 3) or IsPedReloading(cache.ped) or not WeaponData.canFire(cache.weapon) then
        return false
    end

    local currentTime = GetGameTimer()
    if (currentTime - lastFireCheck) < fireCheckThrottle then
        return isCurrentlyShooting
    end
    lastFireCheck = currentTime

    local isShootingPressed = IsDisabledControlJustPressed(0, 24)
    local isShootingHeld = IsDisabledControlPressed(0, 24)

    if isShootingPressed or isShootingHeld then
        local muzzleX, muzzleY, muzzleZ, playerRotation, destination = MathUtils.getWeaponMuzzlePosition()
        FireWeaponWithSnapshot(cache.weapon, muzzleX, muzzleY, muzzleZ, destination)
        return true
    end

    return false
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

                local currentTime = GetGameTimer()
                if (currentTime - lastShootingCheck) >= 8 and cache.weapon and GetAmmoInClip(cache.ped, cache.weapon or 0) > 0 then
                    isCurrentlyShooting = HandleRealisticShooting()
                    lastShootingCheck = currentTime
                end
            else
                Wait(100)
                DisablePlayerFiring(PlayerId(), true)
                isCurrentlyShooting = false
            end
        else
            Wait(100)
            DisablePlayerFiring(PlayerId(), false)
            isCurrentlyShooting = false
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