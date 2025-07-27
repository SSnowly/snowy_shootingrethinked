fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Snowy'
name 'Shooting Rethinked'
description 'Realistic Weapon-Based Shooting System'
version '1.0.0'

client_scripts {
    'client/main.lua',
}

files {
    'client/math_utils.lua',
    'client/weapon_data.lua'
}


shared_scripts {
    'shared/config.lua',
    '@ox_lib/init.lua'
} 