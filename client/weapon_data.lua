local lastShotTimes = {}
local minimumShotInterval = 50 -- Minimum 50ms between shots to prevent network spam


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
local function canFire(weaponHash)
    local currentTime = GetGameTimer()
    local lastShotTime = lastShotTimes[weaponHash] or 0
    local weaponFireRate = GetWeaponTimeBetweenShots(weaponHash)
    local weaponConfig = Config.Weapons[weaponHash] or Config.DefaultWeapon
    local configFireRate = weaponConfig.fireRate
    local fireRate = weaponFireRate > 0 and weaponFireRate or configFireRate
    
    -- Ensure minimum interval to prevent network spam
    fireRate = math.max(fireRate, minimumShotInterval)

    return (currentTime - lastShotTime) >= fireRate
end


---@param weaponHash number
local function updateShotTime(weaponHash)
    lastShotTimes[weaponHash] = GetGameTimer()

    if math.random(1, 10) == 1 then
        cleanupOldShotTimes()
    end
end


---@param weaponHash number
---@return table
local function getWeaponConfig(weaponHash)
    local config = Config.Weapons[weaponHash]
    if config then
        return config
    end

    return Config.DefaultWeapon
end


---@param weaponHash number
---@return boolean
local function isValidWeapon(weaponHash)

    if Config.Weapons[weaponHash] then
        return true
    end

    return true
end

---@param weaponHash number
---@return string
local function getWeaponName(weaponHash)
    return Config.Weapons[weaponHash].name
end


local function cleanup()
    lastShotTimes = {}
end

return {
    canFire = canFire,
    updateShotTime = updateShotTime,
    getWeaponConfig = getWeaponConfig,
    isValidWeapon = isValidWeapon,
    getWeaponName = getWeaponName,
    cleanup = cleanup
}