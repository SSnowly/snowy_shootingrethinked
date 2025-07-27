# 🎯 Shooting Rethinked

**Realistic Weapon-Based Shooting System for FiveM**

<div align="center">

[![Demo Video](https://img.shields.io/badge/Watch-Demo%20Video-red?style=for-the-badge&logo=youtube)](https://youtu.be/swdBPs5nA0o)

</div>

## Overview

A comprehensive shooting system that replaces GTA V's default shooting mechanics with realistic weapon handling, accuracy calculations, and bullet trajectory physics.

<div align="center">

[![Shooting Rethinked Demo](https://img.youtube.com/vi/swdBPs5nA0o/maxresdefault.jpg)](https://youtu.be/swdBPs5nA0o)

</div>

## Features

<div style="display: flex; justify-content: space-between; flex-wrap: wrap;">

<div style="flex: 1; min-width: 300px;">

### 🎯 Core Features
- ✅ Realistic weapon fire rates and accuracy
- ✅ Bullet trajectory calculations with spread
- ✅ Weapon-specific muzzle positioning
- ✅ Configurable weapon parameters

</div>

<div style="flex: 1; min-width: 300px;">

### ⚙️ Technical Features
- ✅ Automatic firing rate control
- ✅ Support for 40+ weapons
- ✅ ox_lib integration
- ✅ Performance optimized

</div>

</div>

## ⚡ Weapon Support

<div style="background: #f6f8fa; padding: 20px; border-radius: 8px; border-left: 4px solid #0366d6;">

**40+ Weapons Including:**
- **Pistols:** Pistol, Combat Pistol, Heavy Pistol, Deagle, etc.
- **Rifles:** Carbine, Assault Rifle, Bullpup, Special Carbine, etc.
- **Shotguns:** Pump Shotgun, Bullpup Shotgun, Assault Shotgun, etc.
- **SMGs:** SMG, Micro SMG, SMG MK2, etc.
- **Sniper Rifles:** Sniper Rifle, Heavy Sniper, Marksman Rifle, etc.

</div>

## Installation

<div style="background: #e8f5e8; padding: 20px; border-radius: 8px; border-left: 4px solid #28a745;">

1. Download and extract to your resources folder
2. Add `ensure snowy_shootingrethinked` to your `server.cfg`
3. Ensure `ox_lib` is installed and running
4. Restart your server

</div>

## Configuration

Edit `shared/config.lua` to customize:

- Weapon fire rates and accuracy
- Muzzle offset positions
- Recoil settings
- Maximum shooting distance

<div style="background: #fff3cd; padding: 15px; border-radius: 8px; border-left: 4px solid #ffc107;">

**⚠️ Important:** The weapon configurations serve as fallback values when `GetWeaponTimeBetweenShots` fails to retrieve weapon data from the game.

</div>

### Configuration Hierarchy

1. **Game Data** - `GetWeaponTimeBetweenShots()` (primary source)
2. **Config.Weapons** - Custom weapon configurations (fallback)
3. **Config.DefaultWeapon** - Default values (final fallback)

### Example Configuration

```lua
-- fallback if GetWeaponTimeBetweenShots fails
Config.Weapons = {
    [`WEAPON_PISTOL`] = {
        name = "WEAPON_PISTOL",
        fireRate = 400,
        accuracy = 0.95,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    }
}

-- fallback if GetWeaponTimeBetweenShots and Config.Weapons[weaponHash] fails
Config.DefaultWeapon = {
    fireRate = 500,
    accuracy = 0.9,
    muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
    recoil = {x = 0.0, y = 0.0, z = 0.0}
}
```

## Dependencies

<div style="background: #fff3cd; padding: 15px; border-radius: 8px; border-left: 4px solid #ffc107;">

- **[ox_lib](https://github.com/overextended/ox_lib)** - Required library
- **FiveM Server** - Game server framework

</div>

---

<div align="center">

**Created by Snowy** | Version: 1.0.0

</div>
