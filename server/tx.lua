AddEventHandler('txAdmin:events:serverShuttingDown', function(data)
    local msg = '**> Message : '..data.message..'**\n**> Requested by : '..data.author..'**'
    TriggerEvent('LogsSender', list.txadmin, '💻 Tx LOG', 'ShuttingDown', 'ShuttingDown', msg)
    ----TriggerEvent('backup')
end)
--Announcement
AddEventHandler('txAdmin:events:announcement', function(data)
    local msg = '**> Message : '..data.message..'**\n**> Author : '..data.author..'**'
    --TriggerEvent('txAdmin', 'AnnounceMent', msg)
    TriggerEvent('LogsSender', list.txadmin, '💻 Tx LOG', 'ShuttingDown', 'AnnounceMent', msg)
end)
--playerDirectMessage
AddEventHandler('txAdmin:events:playerDirectMessage', function(data)
    local msg = '**> Target : '..data.target..'**\n**> Name : '..GetPlayerName(data.target)..'**\n**> Message : '..data.message..'**\n**> Author : '..data.author..'**'
    --TriggerEvent('txAdmin', 'Direct Message', msg)
    TriggerEvent('LogsSender', list.txadmin, '💻 Tx LOG', 'ShuttingDown', 'Direct Message', msg)
end)
--heal
AddEventHandler('txAdmin:events:healedPlayer', function(data)
    local msg = nil
    if data.id == -1 then
        msg = '**> All Players in server has been healed**'
    else
        msg = '**> Target : '..data.id..'**\n**> Name : '..GetPlayerName(data.id)..'**\n**> Player has been healed**'
    end
    --TriggerEvent('txAdmin', 'Heal', msg)
    TriggerEvent('LogsSender', list.txadmin, '💻 Tx LOG', 'ShuttingDown', 'Heal', msg)
end)
--SheduleRestart
AddEventHandler('txAdmin:events:scheduledRestart', function(data)
    local msg = '**> SecondsRemaining : '..data.secondsRemaining..'**\n**> Message : '..data.translatedMessage..'**'
    --TriggerEvent('txAdmin', 'ScheduledRestart', msg)
    TriggerEvent('LogsSender', list.txadmin, '💻 Tx LOG', 'ShuttingDown', 'ScheduledRestart', msg)
    if data.secondsRemaining < 310 then
        if data.secondsRemaining > 290 then
        --TriggerEvent('backup')
        --print('hlo')
        end
    end
    --
end)
--skiprestart
AddEventHandler('txAdmin:events:skippedNextScheduledRestart', function(data)
    local tem = 'No'
    if data.temporary then
        tem = 'Yes'
    end
    local msg = '**> Info : Restart has been skipped**\n**> SecondsRemaining : '..data.secondsRemaining..'**\n**> Temporary : '..tem..'**'
    --TriggerEvent('txAdmin', 'ScheduledRestart', msg)
    TriggerEvent('LogsSender', list.txadmin, '💻 Tx LOG', 'ShuttingDown', 'ScheduledRestart Skip', msg)
end)
--Warn
AddEventHandler('txAdmin:events:playerWarned', function(data)
    local msg = '**> Target : '..data.target..'**\n**> Name : '..GetPlayerName(data.target)..'**\n**> Reason : '..data.reason..'**\n**> Action ID : '..data.actionId..'**\n**> Author : '..data.author..'**'
    --TriggerEvent('txAdmin', 'Warning', msg)
    TriggerEvent('LogsSender', list.txadmin, '💻 Tx LOG', 'ShuttingDown', 'Warning', msg)
end)
--kick
AddEventHandler('txAdmin:events:playerKicked', function(data)
    local msg = '**> Target : '..data.target..'**\n**> Name : '..GetPlayerName(data.target)..'**\n**> Reason : '..data.reason..'**\n**> Author : '..data.author..'**'
    --TriggerEvent('txAdmin', 'Kick', msg)
    TriggerEvent('LogsSender', list.txadmin, '💻 Tx LOG', 'ShuttingDown', 'Kick', msg)
end)
--ban
AddEventHandler('txAdmin:events:playerBanned', function(data)
    local msg = nil
    if data.expiration == false then
        msg = '**> Target : '..data.targetNetId..'**\n**> Name : '..data.targetName..'**\n**> Duration : Permenent**\n**> Reason : '..data.reason..'**\n**> Action ID : '..data.actionId..'**\n**> Author : '..data.author..'**'
    else
        msg = '**> Target : '..data.targetNetId..'**\n**> Name : '..data.targetName..'**\n**> Duration : '..data.durationInput..'**\n**> Reason : '..data.reason..'**\n**> Action ID : '..data.actionId..'**\n**> Author : '..data.author..'**'
    end
    --TriggerEvent('txAdmin', 'Ban', msg)
    TriggerEvent('LogsSender', list.txadmin, '💻 Tx LOG', 'ShuttingDown', 'Ban', msg)
end)
--banRevoke
AddEventHandler('txAdmin:events:actionRevoked', function(data)
    local msg = nil
    local type = nil
    if data.actionType == 'warn' then
        msg = '**> Name : '..data.playerName..'**\n**> Reason : '..data.actionReason..'**\n**> Author : '..data.actionAuthor..'**\n**> Action ID : '..data.actionId..'**\n**> RevokedBy : '..data.revokedBy..'**'
        --TriggerEvent('txAdmin', 'Warn Revoke', msg)
        type = 'Warn'
    elseif data.actionType == 'ban' then
        msg = '**> Name : '..data.playerName..'**\n**> Reason : '..data.actionReason..'**\n**> Author : '..data.actionAuthor..'**\n**> Action ID : '..data.actionId..'**\n**> RevokedBy : '..data.revokedBy..'**'
        --TriggerEvent('txAdmin', 'Ban Revoke', msg)
        type = 'Ban'
    end
    TriggerEvent('LogsSender', list.txadmin, '💻 Tx LOG', 'ShuttingDown', 'Action Revoke : '..type, msg)
end)
--whitelist
AddEventHandler('txAdmin:events:whitelistPreApproval', function(data)
    local type = nil
    local msg = nil
    
    if data.action == 'added' then
        msg = '**> Name : '..data.playerName..'**\n**> Identifier : '..data.identifier..'**\n**> AdminName : '..data.adminName..'**'
        --TriggerEvent('txAdmin', 'Whitelist Added', msg)
        type = 'Added'
    elseif data.action == 'removed' then
        msg = '**> Identifier : '..data.identifier..'**\n**> AdminName : '..data.adminName..'**'
        --TriggerEvent('txAdmin', 'Whitelist Removed', msg)
        type = 'Removed'
    end
    TriggerEvent('LogsSender', list.txadmin, '💻 Tx LOG', 'ShuttingDown', 'Whitwlist Action : '..type, msg)
end)