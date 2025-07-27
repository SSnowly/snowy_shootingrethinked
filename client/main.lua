local MathUtils = require('client.math_utils')
local WeaponData = require('client.weapon_data')

local isShootingEnabled = true
local lastShotTime = 0
local keyDetectionMode = false


local mainThreadActive = false


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




function HandleRealisticShooting()
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
        local muzzleX, muzzleY, muzzleZ, playerRotation, destination = MathUtils.getWeaponMuzzlePosition(cache.ped)
        FireWeaponWithSnapshot(cache.ped, cache.weapon, muzzleX, muzzleY, muzzleZ, destination)
    end
end




function FireWeaponWithSnapshot(playerPed, weaponHash, muzzleX, muzzleY, muzzleZ, destination)

    local weaponConfig = WeaponData.getWeaponConfig(weaponHash)


    local currentAmmo = GetAmmoInPedWeapon(playerPed, weaponHash)
    if currentAmmo <= 0 then
        PlaySoundFrontend(-1, "WEAPON_EMPTY", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
        return
    end


    local endX, endY, endZ = MathUtils.calculateBulletTrajectory(
        muzzleX, muzzleY, muzzleZ,
        destination.x, destination.y, destination.z,
        weaponConfig.accuracy
    )

    SetPedShootsAtCoord(playerPed, endX, endY, endZ, true)




    SetPedCurrentWeaponVisible(playerPed, true, true, true, true)





    WeaponData.updateShotTime(weaponHash)
end






function GetCrosshairPosition()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local playerRotation = GetGameplayCamRot(2)


    local camX, camY, camZ = GetGameplayCamCoord()


    if not camX or not camY or not camZ then

        camX, camY, camZ = table.unpack(playerCoords)
    end


    local direction = RotationToDirection(playerRotation)


    if not direction or not direction.x or not direction.y or not direction.z then

        direction = {x = 0.0, y = 1.0, z = 0.0}
    end


    local targetX = camX + direction.x * Config.MaxShootingDistance
    local targetY = camY + direction.y * Config.MaxShootingDistance
    local targetZ = camZ + direction.z * Config.MaxShootingDistance

    return targetX, targetY, targetZ
end


function RotationToDirection(rotation)

    if not rotation or not rotation.x or not rotation.y or not rotation.z then
        return {x = 0.0, y = 1.0, z = 0.0}
    end

    local z = math.rad(rotation.z)
    local x = math.rad(rotation.x)
    local num = math.abs(math.cos(x))

    return {
        x = -math.sin(z) * num,
        y = math.cos(z) * num,
        z = math.sin(x)
    }
end

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