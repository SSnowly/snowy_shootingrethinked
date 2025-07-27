local WeaponData = {}


local lastShotTimes = {}


local function cleanupOldShotTimes()
    local currentTime = GetGameTimer()
    local cutoffTime = currentTime - 60000

    for weaponHash, lastTime in pairs(lastShotTimes) do
        if lastTime < cutoffTime then
            lastShotTimes[weaponHash] = nil
        end
    end
end


---@param weaponHash number
---@return boolean
function WeaponData.canFire(weaponHash)
    local currentTime = GetGameTimer()
    local lastShotTime = lastShotTimes[weaponHash] or 0
    local weaponFireRate = GetWeaponTimeBetweenShots(weaponHash)
    local weaponConfig = Config.Weapons[weaponHash] or Config.DefaultWeapon
    local configFireRate = weaponConfig.fireRate
    local fireRate = weaponFireRate > 0 and weaponFireRate or configFireRate

    return (currentTime - lastShotTime) >= fireRate
end


---@param weaponHash number
function WeaponData.updateShotTime(weaponHash)
    lastShotTimes[weaponHash] = GetGameTimer()

    if math.random(1, 10) == 1 then
        cleanupOldShotTimes()
    end
end


---@param weaponHash number
---@return table
function WeaponData.getWeaponConfig(weaponHash)
    local config = Config.Weapons[weaponHash]
    if config then
        return config
    end

    return Config.DefaultWeapon
end


---@param weaponHash number
---@return boolean
function WeaponData.isValidWeapon(weaponHash)

    if Config.Weapons[weaponHash] then
        return true
    end

    return true
end

---@param weaponHash number
---@return string
function WeaponData.getWeaponName(weaponHash)
    return Config.Weapons[weaponHash].name
end


function WeaponData.cleanup()
    lastShotTimes = {}
end

return WeaponData