fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Maaluss of TG'
version '1.1.0'
description 'Discord Fivem Bot for a server'


shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
	'client/*.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
	'server/*.lua',
    'java/index.js'
}

escrow_ignore {
    'config.lua',
    'server/*.lua',
    'client/*.lua',
}

