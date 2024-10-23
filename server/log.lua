list = {}

ESX = exports['es_extended']:getSharedObject()

local script = nil
local Players = {}

CreateThread(function()
    local data = LoadResourceFile(GetCurrentResourceName(), './java/logs.json')
    local db = json.decode(data)
    list = db
    script = GetCurrentResourceName()
end)
lib.callback.register('tg-bot:callback:isenable', function(src)
    return list.enable
end)

function GetPlayerPostal(src)
    local raw = LoadResourceFile(GetCurrentResourceName(), "./java/postals.json")

    local postals = json.decode(raw)
    local nearest = nil

    local player = src
    local ped = GetPlayerPed(player)
    local playerCoords = GetEntityCoords(ped)

    local x, y = table.unpack(playerCoords)

	local ndm = -1
	local ni = -1
	for i, p in ipairs(postals) do
		local dm = (x - p.x) ^ 2 + (y - p.y) ^ 2
		if ndm == -1 or dm < ndm then
			ni = i
			ndm = dm
		end
	end

	if ni ~= -1 then
		local nd = math.sqrt(ndm)
		nearest = {i = ni, d = nd}
	end
	_nearest = postals[nearest.i].code
	return _nearest
end

function GetIdens(player)
    local identifiers = GetPlayerIdentifiers(player)

    local license 
    local license2
    local ip
    local discordId

    for _, identifier in ipairs(identifiers) do
        if identifier:match("license") then
            license  = identifier:gsub("license:", "")
        elseif identifier:match("license2") then
            license2 = identifier:gsub("license2:", "")
        elseif identifier:match("ip") then
            ip = identifier:gsub("ip:", "")
        elseif identifier:match("discord") then
            discordId = identifier:gsub("discord:", "")
        end
    end

    local data = {
        license  = license,
        license2 = license2,
        ip = ip,
        discordId = discordId
    }
    return data
end

function GetHealth(src)
    local ped = GetPlayerPed(src)
  
    local health = GetEntityHealth(ped)
  
      return health
end

function GetArmour(src)
    local ped = GetPlayerPed(src)
    local health = GetPedArmour(ped)
    return health
end

function GetName(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        return xPlayer.name
    else
        return GetPlayerName(src)
    end
    return false
end

function GetLicense(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        return xPlayer.getIdentifier()
    else
        local identifiers = GetPlayerIdentifiers(player)

        local license 
    
    
        for _, identifier in ipairs(identifiers) do
            if identifier:match("license") then
                license  = identifier:gsub("license:", "")
                return license
            end
        end
    end
    return false
end

GetAction = function(cause)
    for k,v in pairs(Config.weapon) do
        for j,l in pairs(v) do
            if GetHashKey(l) == cause then
                return k..'['..l..']'
            end
        end
    end
    return 'Fall'
end

GetPlayerServerId = function(src)
    local xPlayers = ESX.GetExtendedPlayers()
    for i= 1, #xPlayers do
        local xPlayer = xPlayers[i]
        if GetPlayerPed(xPlayer.source) == src then
            return xPlayer.source
        end
    end
end

AddEventHandler('esx:playerLoaded', function(player, xPlayer, isNew)
    if list.enable then
        local src = xPlayer.source
        local idens = GetIdens(src)
        local postal = GetPlayerPostal(src)
        local msg = '**Character : '..GetName(src)..'**\n> 🔢 Server ID : '..src..'\n> 📫 Postal : '..postal..'\n> 💌 Health : '..GetHealth(src)..'\n> 💪 Armour : '..GetArmour(src)..'\n> 🪪 License : '..GetLicense(src)..'\n> Ⓜ️ Discord : <@'..idens.discordId..'>\n> 📌 IP : '..idens.ip
        local title = GetPlayerName(src)..' is Joined to the server'
        if #Players >= 0 then
            Players[#Players+1] = src
            TriggerEvent('LogsSender', list.join, '📥 JOIN LOG', 'green', title, msg)
        else
            for k,v in pairs(Players) do
                if src ~= v then
                    Players[#Players+1] = src
                    TriggerEvent('LogsSender', list.join, '📥 JOIN LOG', 'green', title, msg)
                end
            end
        end
    end
end)

AddEventHandler('playerDropped', function(reason)
    if list.enable then
        local src = source
        if reason then
            local idens = GetIdens(src)
            local license = idens.license
            local postal = GetPlayerPostal(src)
            local msg = '> 🔢 Server ID : '..src..'\n> 📫 Postal : '..postal..'\n> 💌 Health : '..GetHealth(src)..'\n> 💪 Armour : '..GetArmour(src)..'\n> 🪪 License : '..license..'\n> Ⓜ️ Discord : <@'..idens.discordId..'>\n> 📌 IP : '..idens.ip
            local title = GetPlayerName(src)..' is Left to the server'
            TriggerEvent('LogsSender', list.leave, '📤 LEAVE LOG', 'Red', title, msg)
        end
    end
end)

RegisterNetEvent('tg-bots:server:onPlayerDeath', function(data)
    if list.enable then
        local msg = nil
        local title = nil
        local idens = GetIdens(src)
        local cause = data.deathCause
        local ysr = data.killerServerId
        local action = GetAction(cause)
        if ysr then
            local ydens = GetIdens(ysr)
            msg = '**Victim Character : '..GetName(src)..'**\n> 🔢 Server ID : '..src..'\n> 📫 Postal : '..GetPlayerPostal(src)..'\n> 💌 Health : '..GetHealth(src)..'\n> 💪 Armour : '..GetArmour(src)..'\n> 🪪 License : '..GetLicense(src)..'\n> Ⓜ️ Discord : <@'..idens.discordId..'>\n> 📌 IP : '..idens.ip..'\n\n**Attacker Character : '..GetName(ysr)..'**\n> 🔢 Server ID : '..ysr..'\n> 📫 Postal : '..GetPlayerPostal(ysr)..'\n> 💌 Health : '..GetHealth(ysr)..'\n> 💪 Armour : '..GetArmour(ysr)..'\n> 🪪 License : '..GetLicense(src)..'\n> Ⓜ️ Discord : <@'..ydens.discordId..'>\n> 📌 IP : '..ydens.ip..'\n\nDistance btw players : '..data.distance
            title = GetPlayerName(src)..' has been killed by '..GetPlayerName(ysr)..'\nReason : '..action
        else
            msg = '**Character : '..GetName(src)..'**\n> 🔢 Server ID : '..src..'\n> 📫 Postal : '..postal..'\n> 💌 Health : '..GetHealth(src)..'\n> 💪 Armour : '..GetArmour(src)..'\n> 🪪 License : '..GetLicense(src)..'\n> Ⓜ️ Discord : <@'..idens.discordId..'>\n> 📌 IP : '..idens.ip
            title = GetPlayerName(src)..' has been killed\nReason : '..action
        end
        TriggerEvent('LogsSender', list.dead, '💀 Death LOG', 'green', title, msg)
    end
end)

AddEventHandler('onResourceStart', function(name)
    if script ~= name then
        Wait(10000)
        local title = '**'..name..' Resource has been started**'
        TriggerEvent('LogsSender', list.resource, '📁 Resource LOG', 'green', title, nil)
    end
end)

AddEventHandler('onResourceStop', function(name)
    if script ~= name then
        local title = '**'..name..' Resource has been stopped**'
        TriggerEvent('LogsSender', list.resource, '📁 Resource LOG', 'green', title, nil)
    end
end)

local explosionTypes = {'GRENADE', 'GRENADELAUNCHER', 'STICKYBOMB', 'MOLOTOV', 'ROCKET', 'TANKSHELL', 'HI_OCTANE', 'CAR', 'PLANE', 'PETROL_PUMP', 'BIKE', 'DIR_STEAM', 'DIR_FLAME', 'DIR_GAS_CANISTER', 'BOAT', 'SHIP_DESTROY', 'TRUCK', 'BULLET', 'SMOKEGRENADELAUNCHER', 'SMOKEGRENADE', 'BZGAS', 'FLARE', 'GAS_CANISTER', 'EXTINGUISHER', 'PROGRAMMABLEAR', 'TRAIN', 'BARREL', 'PROPANE', 'BLIMP', 'DIR_FLAME_EXPLODE', 'TANKER', 'PLANE_ROCKET', 'VEHICLE_BULLET', 'GAS_TANK', 'BIRD_CRAP', 'RAILGUN', 'BLIMP2', 'FIREWORK', 'SNOWBALL', 'PROXMINE', 'VALKYRIE_CANNON', 'AIR_DEFENCE', 'PIPEBOMB', 'VEHICLEMINE', 'EXPLOSIVEAMMO', 'APCSHELL', 'BOMB_CLUSTER', 'BOMB_GAS', 'BOMB_INCENDIARY', 'BOMB_STANDARD', 'TORPEDO', 'TORPEDO_UNDERWATER', 'BOMBUSHKA_CANNON', 'BOMB_CLUSTER_SECONDARY', 'HUNTER_BARRAGE', 'HUNTER_CANNON', 'ROGUE_CANNON', 'MINE_UNDERWATER', 'ORBITAL_CANNON', 'BOMB_STANDARD_WIDE', 'EXPLOSIVEAMMO_SHOTGUN', 'OPPRESSOR2_CANNON', 'MORTAR_KINETIC', 'VEHICLEMINE_KINETIC', 'VEHICLEMINE_EMP', 'VEHICLEMINE_SPIKE', 'VEHICLEMINE_SLICK', 'VEHICLEMINE_TAR', 'SCRIPT_DRONE', 'RAYGUN', 'BURIEDMINE', 'SCRIPT_MISSIL'}

function GetExplotion(num)
    for k,v in pairs(Config.explosionName) do
        if k == num then
            return v
        end
    end
    return false
end

AddEventHandler('explosionEvent', function(source, ev)
    local src = source
    local expnumber = explosionTypes[ev.explosionType + 1]
    --local xPlayer = ESX.GetPlayerFromId(source)
    local explotion = GetExplotion(expnumber)
    local idens = GetIdens(source)
    --if xPlayer then
        local msg = '**Character : '..GetName(src)..'**\n> 🔢 Server ID : '..src..'\n> 📫 Postal : '..GetPlayerPostal(src)..'\n> 💌 Health : '..GetHealth(src)..'\n> 💪 Armour : '..GetArmour(src)..'\n> 🪪 License : '..GetLicense(src)..'\n> Ⓜ️ Discord : <@'..idens.discordId..'>\n> 📌 IP : '..idens.ip
        local title = '**'..GetPlayerName(source)..' has been created a explotion**\n**Type : '..explotion..'**'
        TriggerEvent('LogsSender', list.explo, '💣 Explotion LOG', 'green', title, msg)
    --end
end)

RegisterNetEvent('tg-bot:server:playerDamage', function(damage)
    local src = source
    local ped = GetPlayerPed(src)
    local cause = GetPedSourceofDamage(ped)
    local type = GetEntityType(cause)
    local idens = GetIdens(src)
    local msg = nil
    local title = nil
    if type == 0 then
        msg = '**Character : '..GetName(src)..'**\n> 🔢 Server ID : '..src..'\n> 📫 Postal : '..GetPlayerPostal(src)..'\n> 💌 Health : '..GetHealth(src)..'\n> 💪 Armour : '..GetArmour(src)..'\n> 🪪 License : '..GetLicense(src)..'\n> Ⓜ️ Discord : <@'..idens.discordId..'>\n> 📌 IP : '..idens.ip
        title = '**'..GetPlayerName(src)..' has been damaged by themself and lost '..damage..'**'
    elseif type == 1 then
        if IsPedAPlayer(cause) then
            local ysr = GetPlayerServerId(cause)
            local ydens = GetIdens(ysr)
            msg = '**Victim Character : '..GetName(src)..'**\n> 🔢 Server ID : '..src..'\n> 📫 Postal : '..GetPlayerPostal(src)..'\n> 💌 Health : '..GetHealth(src)..'\n> 💪 Armour : '..GetArmour(src)..'\n> 🪪 License : '..GetLicense(src)..'\n> Ⓜ️ Discord : <@'..idens.discordId..'>\n> 📌 IP : '..idens.ip..'\n\n**Attackers Character : '..GetName(ysr)..'**\n> 🔢 Server ID : '..ysr..'\n> 📫 Postal : '..GetPlayerPostal(ysr)..'\n> 💌 Health : '..GetHealth(ysr)..'\n> 💪 Armour : '..GetArmour(ysr)..'\n> 🪪 License : '..GetLicense(ysr)..'\n> Ⓜ️ Discord : <@'..ydens.discordId..'>\n> 📌 IP : '..ydens.ip
            if GetVehiclePedIsIn(cause, false) ~= 0 then
                title = '**'..GetPlayerName(source)..' has been damged by '..GetPlayerName(ysr)..' (vehicle) and lost '..damage..'**'
            else 
                title = '**'..GetPlayerName(source)..' has been damged by '..GetPlayerName(ysr)..' and lost '..damage..'**'
            end
        end
    elseif type == 2 then
        local driver = GetPedInVehicleSeat(cause, -1)
        msg = '**Character : '..GetName(src)..'**\n> 🔢 Server ID : '..src..'\n> 📫 Postal : '..GetPlayerPostal(src)..'\n> 💌 Health : '..GetHealth(src)..'\n> 💪 Armour : '..GetArmour(src)..'\n> 🪪 License : '..GetLicense(src)..'\n> Ⓜ️ Discord : <@'..idens.discordId..'>\n> 📌 IP : '..idens.ip
        if IsPedAPlayer(cause) then
            title = '**'..GetPlayerName(src)..' has been damaged by '..GetPlayerName(GetPlayerServerId(cause))..'and lost '..damage..'**'
        else
            title = '**'..GetPlayerName(source)..' has been damged by a vehicle and lost '..damage..'**'
        end
    elseif type == 3 then
        msg = '**Character : '..GetName(src)..'**\n> 🔢 Server ID : '..src..'\n> 📫 Postal : '..GetPlayerPostal(src)..'\n> 💌 Health : '..GetHealth(src)..'\n> 💪 Armour : '..GetArmour(src)..'\n> 🪪 License : '..GetLicense(src)..'\n> Ⓜ️ Discord : <@'..idens.discordId..'>\n> 📌 IP : '..idens.ip
        title = '**'..GetPlayerName(src)..' has been damged by object and lost '..damage..'**'
    end
    TriggerEvent('LogsSender', list.damage, '💀 Damage LOG', 'green', title, msg)
end)

RegisterNetEvent('tg-bots:server:shootlog', function(weapon, count)
    local src = source
    local idens = GetIdens(source)
    local cm = count or 0
    --if xPlayer then
        local msg = '**Character : '..GetName(src)..'**\n> 🔢 Server ID : '..src..'\n> 📫 Postal : '..GetPlayerPostal(src)..'\n> 💌 Health : '..GetHealth(src)..'\n> 💪 Armour : '..GetArmour(src)..'\n> 🪪 License : '..GetLicense(src)..'\n> Ⓜ️ Discord : <@'..idens.discordId..'>\n> 📌 IP : '..idens.ip
        local title = '**'..GetPlayerName(src)..' is shooted '..cm..' count of bullet from '..weapon..'**'
        TriggerEvent('LogsSender', list.shoot, '🎯 Shoot LOG', 'green', title, msg)
    --end
end)