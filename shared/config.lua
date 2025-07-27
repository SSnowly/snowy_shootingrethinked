Config = {}


Config.EnableRealisticShooting = true
Config.MaxShootingDistance = 100.0

-- fallback if GetWeaponTimeBetweenShots fails
---@type table<number, table>
Config.Weapons = {
    [`WEAPON_PISTOL`] = {
        name = "WEAPON_PISTOL",
        fireRate = 400,
        accuracy = 0.95,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_COMBATPISTOL`] = {
        name = "WEAPON_COMBATPISTOL",
        fireRate = 350,
        accuracy = 0.92,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_CARBINERIFLE`] = {
        name = "WEAPON_CARBINERIFLE",
        fireRate = 100,
        accuracy = 0.88,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_ASSAULTRIFLE`] = {
        name = "WEAPON_ASSAULTRIFLE",
        fireRate = 80,
        accuracy = 0.85,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_PUMPSHOTGUN`] = {
        name = "WEAPON_PUMPSHOTGUN",
        fireRate = 800,
        accuracy = 0.75,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_SMG`] = {
        name = "WEAPON_SMG",
        fireRate = 120,
        accuracy = 0.82,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_MICROSMG`] = {
        name = "WEAPON_MICROSMG",
        fireRate = 100,
        accuracy = 0.78,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_COMBATMG`] = {
        name = "WEAPON_COMBATMG",
        fireRate = 60,
        accuracy = 0.80,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_SNIPERRIFLE`] = {
        name = "WEAPON_SNIPERRIFLE",
        fireRate = 1500,
        accuracy = 0.98,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_HEAVYSNIPER`] = {
        name = "WEAPON_HEAVYSNIPER",
        fireRate = 2000,
        accuracy = 0.99,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_HEAVYPISTOL`] = {
        name = "WEAPON_HEAVYPISTOL",
        fireRate = 450,
        accuracy = 0.90,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_REVOLVER`] = {
        name = "WEAPON_REVOLVER",
        fireRate = 600,
        accuracy = 0.88,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_DOUBLEACTION`] = {
        name = "WEAPON_DOUBLEACTION",
        fireRate = 550,
        accuracy = 0.87,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_PISTOL50`] = {
        name = "WEAPON_PISTOL50",
        fireRate = 500,
        accuracy = 0.85,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_APPISTOL`] = {
        name = "WEAPON_APPISTOL",
        fireRate = 200,
        accuracy = 0.75,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_DEAGLE`] = {
        name = "WEAPON_DEAGLE",
        fireRate = 600,
        accuracy = 0.88,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_BULLPUPRIFLE`] = {
        name = "WEAPON_BULLPUPRIFLE",
        fireRate = 90,
        accuracy = 0.86,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_SPECIALCARBINE`] = {
        name = "WEAPON_SPECIALCARBINE",
        fireRate = 85,
        accuracy = 0.87,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_ADVANCEDRIFLE`] = {
        name = "WEAPON_ADVANCEDRIFLE",
        fireRate = 75,
        accuracy = 0.89,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_BULLPUPSHOTGUN`] = {
        name = "WEAPON_BULLPUPSHOTGUN",
        fireRate = 700,
        accuracy = 0.78,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_ASSAULTSHOTGUN`] = {
        name = "WEAPON_ASSAULTSHOTGUN",
        fireRate = 300,
        accuracy = 0.72,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_HEAVYSHOTGUN`] = {
        name = "WEAPON_HEAVYSHOTGUN",
        fireRate = 400,
        accuracy = 0.70,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_MARKSMANRIFLE`] = {
        name = "WEAPON_MARKSMANRIFLE",
        fireRate = 1200,
        accuracy = 0.95,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_PUMPSHOTGUN_MK2`] = {
        name = "WEAPON_PUMPSHOTGUN_MK2",
        fireRate = 750,
        accuracy = 0.78,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_SMG_MK2`] = {
        name = "WEAPON_SMG_MK2",
        fireRate = 110,
        accuracy = 0.85,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_CARBINERIFLE_MK2`] = {
        name = "WEAPON_CARBINERIFLE_MK2",
        fireRate = 95,
        accuracy = 0.90,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_ASSAULTRIFLE_MK2`] = {
        name = "WEAPON_ASSAULTRIFLE_MK2",
        fireRate = 75,
        accuracy = 0.87,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_PISTOL_MK2`] = {
        name = "WEAPON_PISTOL_MK2",
        fireRate = 380,
        accuracy = 0.96,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_SNSPISTOL`] = {
        name = "WEAPON_SNSPISTOL",
        fireRate = 350,
        accuracy = 0.88,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_VINTAGEPISTOL`] = {
        name = "WEAPON_VINTAGEPISTOL",
        fireRate = 500,
        accuracy = 0.89,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_FLAREGUN`] = {
        name = "WEAPON_FLAREGUN",
        fireRate = 1000,
        accuracy = 0.85,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
    [`WEAPON_MARKSMANPISTOL`] = {
        name = "WEAPON_MARKSMANPISTOL",
        fireRate = 800,
        accuracy = 0.92,
        muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
        recoil = {x = 0.0, y = 0.0, z = 0.0}
    },
}


-- fallback if GetWeaponTimeBetweenShots and Config.Weapons[weaponHash] fails
Config.DefaultWeapon = {
    fireRate = 500,
    accuracy = 0.9,
    muzzleOffset = {x = 0.0, y = 0.0, z = 0.0},
    recoil = {x = 0.0, y = 0.0, z = 0.0}
}