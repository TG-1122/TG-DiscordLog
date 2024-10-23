Config = {}

Config.HasFfa = true

InFFa = function()
    if Config.HasFfa then
        return exports.ffa:isInGame()
    else 
        return false
    end
end

Config.weapon = {
    Murdered = { 
        'WEAPON_UNARMED', 
        'WEAPON_CROWBAR', 
        'WEAPON_BAT', 
        'WEAPON_GOLFCLUB', 
        'WEAPON_HAMMER',
        'WEAPON_NIGHTSTICK'
    },
    Torched = { 
        'WEAPON_MOLOTOV' 
    },
    Knifed = { 
        'WEAPON_DAGGER', 
        'WEAPON_KNIFE', 
        'WEAPON_SWITCHBLADE', 
        'WEAPON_HATCHET', 
        'WEAPON_BOTTLE' 
    },
    Pistoled = { 
        'WEAPON_SNSPISTOL', 
        'WEAPON_HEAVYPISTOL', 
        'WEAPON_VINTAGEPISTOL', 
        'WEAPON_PISTOL',
        'WEAPON_APPISTOL', 
        'WEAPON_COMBATPISTOL' 
    },
    smg = { 
        'WEAPON_MICROSMG', 
        'WEAPON_SMG' 
    },
    rifle = { 
        'WEAPON_CARBINERIFLE', 
        'WEAPON_MUSKET', 
        'WEAPON_ADVANCEDRIFLE', 
        'WEAPON_ASSAULTRIFLE',
        'WEAPON_SPECIALCARBINE', 
        'WEAPON_COMPACTRIFLE', 
        'WEAPON_BULLPUPRIFLE',
        'WEAPON_RGXVANDAL'
    },
    MachineGunned = { 
        'WEAPON_MG', 
        'WEAPON_COMBATMG' 
    },
    shotgun = { 
        'WEAPON_BULLPUPSHOTGUN', 
        'WEAPON_ASSAULTSHOTGUN', 
        'WEAPON_DBSHOTGUN', 
        'WEAPON_PUMPSHOTGUN',
        'WEAPON_HEAVYSHOTGUN', 
        'WEAPON_SAWNOFFSHOTGUN' 
    },
    sniper =  { 
        'WEAPON_MARKSMANRIFLE', 
        'WEAPON_SNIPERRIFLE', 
        'WEAPON_HEAVYSNIPER', 
        'WEAPON_ASSAULTSNIPER',
        'WEAPON_REMOTESNIPER' 
    },
    Obliterated = { 
        'WEAPON_GRENADELAUNCHER', 
        'WEAPON_RPG', 
        'WEAPON_FLAREGUN', 
        'WEAPON_HOMINGLAUNCHER',
        'WEAPON_FIREWORK', 
        'VEHICLE_WEAPON_TANK' 
    },
    minigun = { 
        'WEAPON_MINIGUN' 
    },
    bomb = { 
        'WEAPON_GRENADE', 
        'WEAPON_PROXMINE', 
        'WEAPON_EXPLOSION', 
        'WEAPON_STICKYBOMB', 
        'WEAPON_PIPEBOMB' 
    },
    MowedOver = { 
        'VEHICLE_WEAPON_ROTORS' 
    },
    Flattened = { 
        'WEAPON_RUN_OVER_BY_CAR', 
        'WEAPON_RAMMED_BY_CAR' 
    }
}

Config.WeaponsNotLogged = {
    "WEAPON_SNOWBALL",
    "WEAPON_FIREEXTINGUISHER",
    "WEAPON_PETROLCAN"
}

Config.explosionName = {
    ['GRENADE'] = 'Grenade',
	['GRENADELAUNCHER'] = 'Grenade Launcher',
	['STICKYBOMB'] = 'Sticky Bomb',
	['MOLOTOV'] = 'Molotov',
	['ROCKET'] = 'Rocket',
	['TANKSHELL'] = 'Tank Shell',
	['HI_OCTANE'] = 'HI_OCTANE',
	['CAR'] = 'Vehicle: Car',
	['PLANE'] = 'vehicle: Plane',
	['PETROL_PUMP'] = 'Petrol Pump',
	['BIKE'] = 'Vehicle: Bike',
	['DIR_STEAM'] = 'DIR_STEAM',
	['DIR_FLAME'] = 'DIR_FLAME',
	['DIR_GAS_CANISTER'] = 'Gas Canister',
	['GAS_CANISTER'] = 'Gas Canister',
	['BOAT'] = 'Vehicle: Boat',
	['SHIP_DESTROY'] = 'Vehicle: Ship',
	['TRUCK'] = 'Vehicle: Truck',
	['BULLET'] = 'Exploding Bullet',
	['SMOKEGRENADELAUNCHER'] = 'Smoke Grenade (Launcher)',
	['SMOKEGRENADE'] = 'Smoke Grenade',
	['BZGAS'] = 'BZ Gas',
	['FLARE'] = 'Flare',
	['EXTINGUISHER'] = 'Fire Extinguiser',
	['PROGRAMMABLEAR'] = 'PROGRAMMABLEAR',
	['TRAIN'] = 'Vehicle: Train',
	['BARREL'] = 'Barrel',
	['PROPANE'] = 'Propane',
	['BLIMP'] = 'Blimp',
	['DIR_FLAME_EXPLODE'] = 'DIR_FLAME_EXPLODE',
	['TANKER'] = 'Vehicle: Tanker',
	['PLANE_ROCKET'] = 'Plane Rocket',
	['VEHICLE_BULLET'] = 'Vehicle Bullet',
	['GAS_TANK'] = 'Gas Tank',
	['BIRD_CRAP'] = 'BIRD_CRAP',
	['RAILGUN'] = 'Railgun',
	['BLIMP2'] = 'BLIMP2',
	['FIREWORK'] = 'Fireworks',
	['SNOWBALL'] = 'Snowball',
	['PROXMINE'] = 'Proximity Mine',
	['VALKYRIE_CANNON'] = 'Valkyrie Cannon',
	['AIR_DEFENCE'] = 'Air Defence',
	['PIPEBOMB'] = 'Pipe Bomb',
	['VEHICLEMINE'] = 'Vehicle Mine',
	['EXPLOSIVEAMMO'] = 'Explosive Ammo',
	['APCSHELL'] = 'APC Shell',
	['BOMB_CLUSTER'] = 'Bomb Cluster',
	['BOMB_GAS'] = 'Bomb Gas',
	['BOMB_INCENDIARY'] = 'Bomb Incendiary',
	['BOMB_STANDARD'] = 'Bomb',
	['TORPEDO'] = 'Torpedo',
	['TORPEDO_UNDERWATER'] = 'Torpedo Under Water',
	['BOMBUSHKA_CANNON'] = 'BOMBUSHKA_CANNON',
	['BOMB_CLUSTER_SECONDARY'] = 'BOMB_CLUSTER_SECONDARY',
	['HUNTER_BARRAGE'] = 'HUNTER_BARRAGE',
	['HUNTER_CANNON'] = 'HUNTER_CANNON',
	['ROGUE_CANNON'] = 'ROGUE_CANNON',
	['MINE_UNDERWATER'] = 'MINE_UNDERWATER',
	['ORBITAL_CANNON'] = 'ORBITAL_CANNON',
	['BOMB_STANDARD_WIDE'] = 'BOMB_STANDARD_WIDE',
	['EXPLOSIVEAMMO_SHOTGUN'] = 'EXPLOSIVEAMMO_SHOTGUN',
	['OPPRESSOR2_CANNON'] = 'OPPRESSOR2_CANNON',
	['MORTAR_KINETIC'] = 'MORTAR_KINETIC',
	['VEHICLEMINE_KINETIC'] = 'VEHICLEMINE_KINETIC',
	['VEHICLEMINE_EMP'] = 'VEHICLEMINE_EMP',
	['VEHICLEMINE_SPIKE'] = 'VEHICLEMINE_SPIKE',
	['VEHICLEMINE_SLICK'] = 'VEHICLEMINE_SLICK',
	['VEHICLEMINE_TAR'] = 'VEHICLEMINE_TAR',
	['SCRIPT_DRONE'] = 'SCRIPT_DRONE',
	['RAYGUN'] = 'RAYGUN',
	['BURIEDMINE'] = 'BURIEDMINE',
	['SCRIPT_MISSIL'] = 'SCRIPT_MISSIL'
}