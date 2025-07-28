local calculationCache = {}
local cacheTimeout = 20000
local lastCacheCleanup = 0
local cacheCleanupInterval = 5000

local function degToRad(degrees)
    return degrees * (math.pi / 180.0)
end

---@param radians number
---@return number
local function radToDeg(radians)
    return radians * (180.0 / math.pi)
end

local function RotationToDirection(rotation)
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

---@param x1 number
---@param y1 number
---@param z1 number
---@param x2 number
---@param y2 number
---@param z2 number
---@return number
local function getDistance(x1, y1, z1, x2, y2, z2)
    local dx = x2 - x1
    local dy = y2 - y1
    local dz = z2 - z1
    return math.sqrt(dx * dx + dy * dy + dz * dz)
end

---@param x number
---@param y number
---@param z number
---@return number, number, number
local function normalizeVector(x, y, z)
    local length = math.sqrt(x * x + y * y + z * z)
    if length == 0 then
        return 0, 0, 0
    end
    return x / length, y / length, z / length
end


---@param x1 number
---@param y1 number
---@param z1 number
---@param x2 number
---@param y2 number
---@param z2 number
---@return number
local function getAngleBetweenVectors(x1, y1, z1, x2, y2, z2)
    local dot = x1 * x2 + y1 * y2 + z1 * z2
    local mag1 = math.sqrt(x1 * x1 + y1 * y1 + z1 * z1)
    local mag2 = math.sqrt(x2 * x2 + y2 * y2 + z2 * z2)

    if mag1 == 0 or mag2 == 0 then
        return 0
    end

    local cosAngle = dot / (mag1 * mag2)
    cosAngle = math.max(-1, math.min(1, cosAngle))
    return math.acos(cosAngle)
end


---@return number, number, number, vector3, vector3
local function getWeaponMuzzlePosition()
    local playerCoords = GetEntityCoords(cache.ped)
    local cameraRotation = GetGameplayCamRot(2)
    local weapon = GetCurrentPedWeaponEntityIndex(cache.ped)
    local weapCoord = GetEntityCoords(weapon)
    local cameraCoord = GetGameplayCamCoord()
    local direction = RotationToDirection(cameraRotation)

    if not weapCoord or not cameraCoord then

        weapCoord = playerCoords
        cameraCoord = playerCoords
    end

    if not direction or not direction.x or not direction.y or not direction.z then

        direction = {x = 0.0, y = 1.0, z = 0.0}
    end


    local distance = Config.MaxShootingDistance
    local destination = vector3(
        cameraCoord.x + direction.x * distance,
        cameraCoord.y + direction.y * distance,
        cameraCoord.z + direction.z * distance
    )

    return weapCoord.x, weapCoord.y, weapCoord.z, cameraRotation, destination
end

---@param startX number
---@param startY number
---@param startZ number
---@param targetX number
---@param targetY number
---@param targetZ number
---@param accuracy number
---@return number, number, number
local function calculateBulletTrajectory(startX, startY, startZ, targetX, targetY, targetZ, accuracy)
    local cacheKey = string.format("%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f", startX, startY, startZ, targetX, targetY, targetZ, accuracy)
    local currentTime = GetGameTimer()

    if (currentTime - lastCacheCleanup) > cacheCleanupInterval then
        for key, entry in pairs(calculationCache) do
            if (currentTime - entry.time) > cacheTimeout then
                calculationCache[key] = nil
            end
        end
        lastCacheCleanup = currentTime
    end

    if calculationCache[cacheKey] and (currentTime - calculationCache[cacheKey].time) < cacheTimeout then
        local cached = calculationCache[cacheKey]
        return cached.endX, cached.endY, cached.endZ
    end

    local dirX = targetX - startX
    local dirY = targetY - startY
    local dirZ = targetZ - startZ

    local length = math.sqrt(dirX * dirX + dirY * dirY + dirZ * dirZ)
    if length == 0 then
        return startX, startY, startZ
    end

    local invLength = 1.0 / length
    dirX = dirX * invLength
    dirY = dirY * invLength
    dirZ = dirZ * invLength

    if accuracy < 1.0 then
        local spread = (1.0 - accuracy) * 0.1
        dirX = dirX + (math.random() - 0.5) * spread
        dirY = dirY + (math.random() - 0.5) * spread
        dirZ = dirZ + (math.random() - 0.5) * spread


        local newLength = math.sqrt(dirX * dirX + dirY * dirY + dirZ * dirZ)
        local invNewLength = 1.0 / newLength
        dirX = dirX * invNewLength
        dirY = dirY * invNewLength
        dirZ = dirZ * invNewLength
    end

    local endX = startX + dirX * Config.MaxShootingDistance
    local endY = startY + dirY * Config.MaxShootingDistance
    local endZ = startZ + dirZ * Config.MaxShootingDistance

    calculationCache[cacheKey] = {
        endX = endX,
        endY = endY,
        endZ = endZ,
        time = currentTime
    }

    return endX, endY, endZ
end


---@param worldX number
---@param worldY number
---@param worldZ number
---@return number, number
local function worldToScreen(worldX, worldY, worldZ)
    local onScreen, screenX, screenY = GetScreenCoordFromWorldCoord(worldX, worldY, worldZ)
    return screenX, screenY
end

---@param screenX number
---@param screenY number
---@return boolean
local function isOnScreen(screenX, screenY)
    return screenX >= 0.0 and screenX <= 1.0 and screenY >= 0.0 and screenY <= 1.0
end


---@return number, number, number
local function getCrosshairPosition()
    local screenW, screenH = GetActiveScreenResolution()
    local crosshairX = screenW / 2
    local crosshairY = screenH / 2

    local worldX, worldY, worldZ = GetScreenCoordFromWorldCoord(crosshairX, crosshairY, 0.0)
    return worldX, worldY, worldZ
end




---@param destination vector3
---@return boolean, number, vector3, vector3
local function shapeTestFromWeapon(destination)
    local weapon = GetCurrentPedWeaponEntityIndex(cache.ped)
    local weapCoord = GetEntityCoords(weapon)
    local cameraRotation = GetGameplayCamRot(2)

    if not weapCoord or not cameraRotation then
        return false, nil, nil, destination
    end

    local endCoords = GetOffsetFromCoordAndHeadingInWorldCoords(
        weapCoord.x, weapCoord.y, weapCoord.z,
        cameraRotation.z,
        100.0, 0.0, 0.0
    )
    local hit, entityHit, endCoords, surfaceNormal, _ = lib.raycast.fromCoords(
        weapCoord.x, weapCoord.y, weapCoord.z,
        endCoords.x, endCoords.y, endCoords.z,
        1
    )

    return hit, entityHit, endCoords, surfaceNormal
end


local function cleanup()
    calculationCache = {}
end

return {
    rotationToDirection = RotationToDirection,
    degToRad = degToRad,
    radToDeg = radToDeg,
    getDistance = getDistance,
    normalizeVector = normalizeVector,
    getAngleBetweenVectors = getAngleBetweenVectors,
    getWeaponMuzzlePosition = getWeaponMuzzlePosition,
    calculateBulletTrajectory = calculateBulletTrajectory,
    worldToScreen = worldToScreen,
    isOnScreen = isOnScreen,
    getCrosshairPosition = getCrosshairPosition,
    shapeTestFromWeapon = shapeTestFromWeapon,
    cleanup = cleanup
}