local enable = false
CreateThread(function()
    enable = lib.callback.await('tg-bot:callback:isenable', 100)
end)
AddEventHandler('esx:onPlayerDeath', function(data)
    if not InFFa() then
    TriggerServerEvent('tg-bots:server:onPlayerDeath', data)
    end
end)

CreateThread(function()
    Wait(1000)
    local health = nil
    while true do
        Wait(0)
        if enable then
            if not health then health = GetEntityHealth(PlayerPedId()) end
            if health < GetEntityHealth(PlayerPedId()) then health = GetEntityHealth(PlayerPedId) end
            if health > GetEntityHealth(PlayerPedId()) then
                local nHealth = GetEntityHealth(PlayerPedId())
                TriggerServerEvent('tg-bot:server:playerDamage', math.floor((health - nHealth) / 2))
                health = nHealth
                Wait(1000)
            else
                Wait(1000)
            end
        end
    end
end)

GetWeapon = function(src)
    for k,v in pairs(Config.weapon) do
        for j,l in pairs(v) do
            if GetHashKey(l) == src then
                return l
            end
        end
    end
    return false
end

CreateThread(function()
    Wait(1000)
    local weapon = nil
    local time = 0
    local count = 0
    while true do
        Wait(0)
        if enable then
            local ped = PlayerPedId()
            if IsPedShooting(ped) then
                weapon = GetSelectedPedWeapon(ped)
                count = count + 1
                time = 1000
            elseif not IsPedShooting(ped) and count ~= 0 and time ~= 0 then
                if time ~= 0 then
                    time = time - 1
                end
                if weapon ~= GetSelectedPedWeapon(ped) then
                    time = 0 
                end
                if count ~= 0 and time == 0 then
                    if not GetWeapon(weapon) then
                        TriggerServerEvent('tg-bots:server:shootlog', 'unknown', 0)
                        return 
                    end
                    local is = true
                    for k,v in pairs(Config.WeaponsNotLogged) do
                        if weapon == GetHashKey(v) then
                            is = false
                        end
                    end
                    if is then
                        TriggerServerEvent('tg-bots:server:shootlog', GetWeapon(weapon), count)
                    end
                end
            end
        end
    end
end)