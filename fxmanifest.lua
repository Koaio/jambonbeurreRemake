fx_version 'bodacious'
game 'gta5'


server_scripts {
    '@mysql-async/lib/MySQL.lua',
    "bans.lua",
    'pasta.lua',
    "configs/config_sv.lua",
    "server.lua"
}

client_scripts {
    "client.lua",
    "pasta.lua",
    "ext.lua"
}

shared_scripts {
    "configs/config_cl.lua",
}

files({
	'relationships.dat'
})

client_script 'Ext.lua'