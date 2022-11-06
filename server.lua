local versionac = ConfigACS.Version

LogBanToDiscord = function (playerId,reason)

    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    local steamid  = "Aucun"
    local license  = "Aucun"
    local discord  = "Aucun"
    local xbl      = "Aucun"
    local liveid   = "Aucun"
    local ip       = "Aucun"

    for k,v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl  = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = string.sub(v, 4)
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@"..discordid..">"
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end

    local discordInfo = {
        ["color"] = "16487167",
        ["type"] = "rich",
        ["title"] = "Ce joueurs a potentielement tricher ",
        ["description"] = "**Son Nom : **"..name.."\n **La Raison : **"..reason.."\n **Son ID (ingame) : **"..playerId.."\n **Son adresse IP : **"..ip.."\n **Son Steam Hex : **"..steamid.."\n **Sa License : **"..license.."\n **Et son Discord : **"..discord,
        ["footer"] = {
            ["text"] = 'Anti Cheat version (By Koaio#9999) : '..versionac
        }
    }

    PerformHttpRequest(ConfigACS.LogBanWebhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Anti Cheat de Dynasty !', embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

ACStarted = function ()
    local discordInfo = {
        ["color"] = "16487167",
        ["type"] = "rich",
        ["title"] = "Anti Cheat Dynasty !",
        ["footer"] = {
            ["text"] = 'Version: '..versionac
        }
    }

    PerformHttpRequest(ConfigACS.LogBanWebhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Dynasty', embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('koaioezdynastyy:detectionf748esf4esf4se85de7des7fesf5ede8sf')
AddEventHandler('koaioezdynastyy:detectionf748esf4esf4se85de7des7fesf5ede8sf', function(type, item)
    local _type = type or 'default'
    local _item = item or 'none'

    _type = string.lower(_type)
        if (_type == 'default') then
            LogBanToDiscord(source,"Unknown Readon")
            TriggerEvent("koaioezdynastyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Tu es ban",source)
        elseif (_type == 'godmode') then
            LogBanToDiscord(source,"Tried to put in godmod")
            TriggerEvent("koaioezdynastyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat de Dynasty | Code de ban AC: 66, discord : https://discord.gg/CSt8h8Nkpf",source)
        elseif (_type == 'resourcestart') then
            LogBanToDiscord(source,"Tried to start the resource (JOUEURS BAN !!) ",item)
            TriggerEvent("koaioezdynastyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat de Dynasty | Code de ban AC: 27, discord : https://discord.gg/CSt8h8Nkpf",source)
        elseif (_type == 'resourcestop') then
            LogBanToDiscord(source,"Tried to stop the resource (JOUEURS BAN !!)",item)
            TriggerEvent("koaioezdynastyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat de Dynasty | Code de ban AC: 43, discord : https://discord.gg/CSt8h8Nkpf",source)
        elseif (_type == 'esx') then
            LogBanToDiscord(source,"Injection Menu (JOUEURS BAN !!)")
            TriggerEvent("koaioezdynastyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "ESX",source)
        elseif (_type == 'spec') then
            LogBanToDiscord(source,"Tried to spectate a playe (JOUEURS BAN !!)r")
            TriggerEvent("koaioezdynastyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat de Dynasty | Code de ban AC: 15, discord : https://discord.gg/CSt8h8Nkpf",source)
        elseif (_type == 'resourcecounter') then
            LogBanToDiscord(source,"has a different resource number count (JOUEURS BAN !!)")
            TriggerEvent("koaioezdynastyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat de Dynasty | Code de ban AC: 77, discord : https://discord.gg/CSt8h8Nkpf",source)
        elseif (_type == 'antiblips') then
            LogBanToDiscord(source,"tried to enable players blips (JOUEURS NON BAN !!)")
            TriggerEvent("koaioezdynastyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat de Dynasty | Code de ban AC: 44, discord : https://discord.gg/CSt8h8Nkpf",source)
        elseif (_type == 'injection') then
            LogBanToDiscord(source,"tried to execute the command (JOUEURS BAN !!)"..item)
            TriggerEvent("koaioezdynastyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat de Dynasty | Code de ban AC: 82, discord : https://discord.gg/CSt8h8Nkpf",source)
        elseif (_type == 'blacklisted_weapon') then
            LogBanToDiscord(source,"Blacklisted Weapon : (JOUEURS BAN !!)"..item)
            TriggerEvent("koaioezdynastyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Arme Blacklist",source)
        elseif (_type == 'hash') then
            LogBanToDiscord(source,"Tried to spawn a blacklisted car (JOUEURS NON BAN !!) : "..item)
            TriggerServerEvent("koaioezdynastyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat de Dynasty | Code de ban AC: 52, discord : https://discord.gg/CSt8h8Nkpf",source)
        elseif (_type == 'explosion') then
            LogBanToDiscord(source,"Tried to spawn an explosion (JOUEURS NON BAN !!): "..item)
            TriggerServerEvent("koaioezdynastyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat de Dynasty | Code de ban AC: 38, discord : https://discord.gg/CSt8h8Nkpf",source)
        elseif (_type == 'event') then
            LogBanToDiscord(source,"Tried to trigger a blacklisted event (JOUEURS BAN !!) : "..item)
            TriggerEvent("koaioezdynastyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat de Dynasty | Code de ban AC: 22, discord : https://discord.gg/CSt8h8Nkpf",source)
        end
end)

if ConfigACC.ExplosionProtection then
    AddEventHandler("explosionEvent",function(sender, ev)
        for _, v in ipairs(ConfigACC.BlockedExplosions) do
            if ev.explosionType == v then
                CancelEvent()
                LogBanToDiscord(sender,"J'ai essayé d'exploser un joueur")
                TriggerEvent("koaioezdynastyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat de Dynasty | Code de ban AC: 38, discord : https://discord.gg/CSt8h8Nkpf",sender)
                return
            end
        end
    end)
end

if ConfigACC.GiveWeaponsProtection then
    AddEventHandler("giveWeaponEvent", function(sender, data)
        CancelEvent()
        print(sender.." give des armes")
        LogBanToDiscord(sender,"Tried to give weapon to a player")
        TriggerEvent("koaioezdynastyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat de Dynasty | Code de ban AC: 28, discord : https://discord.gg/CSt8h8Nkpf",sender)
    end)
end

if ConfigACC.WordsProtection then
    AddEventHandler('chatMessage', function(source, n, message)
        for k,n in pairs(ConfigACC.BlacklistedWords) do
        if string.match(message:lower(),n:lower()) then
            LogBanToDiscord(source,"Tried to say : "..n)
            TriggerEvent("koaioezdynastyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat de Dynasty | Code de ban AC: 22, discord : https://discord.gg/CSt8h8Nkpf",source)
        end
        end
    end)
end

if ConfigACC.TriggersProtection then
    for k,events in pairs(ConfigACC.BlacklistedEvents) do
        RegisterServerEvent(events)
        AddEventHandler(events, function()
            CancelEvent()
            LogBanToDiscord(source,"Tried to trigger his shit event : "..events)
            TriggerEvent("koaioezdynastyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat de Dynasty | Code de ban AC: 22, discord : https://discord.gg/CSt8h8Nkpf",source)
        end)
    end
end

RegisterServerEvent('aopkfgebjzhfpazf77')
AddEventHandler('aopkfgebjzhfpazf77', function(reason,servertarget)
        local license,identifier,liveid,xblid,discord,playerip,target
        local duree     = 0
        local reason    = reason

        if not reason then reason = "Dynasty Anti-Cheat" end

        if tostring(source) == "" then
                target = tonumber(servertarget)
        else
                target = source
        end

        if target and target > 0 then
                local ping = GetPlayerPing(target)

                if ping and ping > 0 then
                        if duree and duree < 365 then
                                local sourceplayername = "T"
                                local targetplayername = GetPlayerName(target)
                                        for k,v in ipairs(GetPlayerIdentifiers(target))do
                                                if string.sub(v, 1, string.len("license:")) == "license:" then
                                                        license = v
                                                elseif string.sub(v, 1, string.len("live:")) == "live:" then
                                                        liveid = v
                                                elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                                                        xblid  = v
                                                elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                                                        discord = v
                                                elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                                                        playerip = v
                                                end
                                        end
                                if duree > 0 then
                                        ban(target,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,0) --Timed ban here
                                        DropPlayer(target, "The anticheat ban you for" .. reason)
                                else
                                        ban(target,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,1) --Perm ban here
                                        DropPlayer(target, "The anticheat ban you for" .. reason)
                                end

                        else
                                print("BanSql Error : Auto-Cheat-Ban time invalid.")
                        end
                else
                        print("BanSql Error : Auto-Cheat-Ban target are not online.")
                end
        else
                print("BanSql Error : Auto-Cheat-Ban have recive invalid id.")
        end
end)



--=====================================================--
--============== AUTHENTIFICATION SYSTEM ==============--
--=====================================================--

AddEventHandler('onMySQLReady', function()
    Wait(5000)
    logo()
    auth()
end)

function logo()
	print([[^4 Anti-Cheat by Koaio#9999 ¦
							 
^0]])                                                
end

function auth()
    print("^4[Anti-Cheat] ^4 Tous est carré vous pouvez joués")
    ACStarted()
end

AddEventHandler('entityCreating', function(entity)
    if DoesEntityExist(entity) then
        for k,v in pairs(ConfigACC.BlacklistedModels) do
            if GetEntityModel(entity) == GetHashKey(v) then
                CancelEvent()
            end
        end
    end
end)

ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

local events = {
	''
}

RegisterServerEvent('scrambler-vac:triggeredClientEvent')
AddEventHandler('scrambler-vac:triggeredClientEvent', function(name, ...)
	local xPlayer = ESX.GetPlayerFromId(source)
	local args = { ... }

	if xPlayer and name then
		local eventName = "'" .. name .. "'"
		TriggerEvent('BanSql:ICheatServer', xPlayer.source)

		for k, v in ipairs(args) do
			if type(v) == 'string' then
				eventName = eventName .. ', '
			end
		end

		TriggerEvent('esx:customDiscordLog', "Joueur : " .. xPlayer.name .. " [" .. xPlayer.source .. "] (" .. xPlayer.identifier .. ") - Méthode : TriggerEvent(" .. eventName .. ")")
	end
end)

for i = 1, #events, 1 do
	RegisterServerEvent(events[i])
	AddEventHandler(events[i], function(...)
		local xPlayer = ESX.GetPlayerFromId(source)
		local args = { ... }

		if xPlayer and events[i] then
			local eventName = "'" .. events[i] .. "'"
			TriggerEvent('BanSql:ICheatServer', xPlayer.source)

			for k, v in ipairs(args) do
				if type(v) == 'string' then
					eventName = eventName .. ', '
				end
			end
	
			TriggerEvent('esx:customDiscordLog', "Joueur : " .. xPlayer.name .. " [" .. xPlayer.source .. "] (" .. xPlayer.identifier .. ") - Méthode : TriggerServerEvent(" .. eventName .. ")")
		end
	end)
end

AddEventHandler('explosionEvent', function(sender, data)
	if data.posX == 0.0 or data.posY == 0.0 or data.posZ == 0.0 or data.posZ == -1700.0 or (data.cameraShake == 0.0 and data.damageScale == 0.0 and data.isAudible == false and data.isInvisible == false) then
		CancelEvent()
		return
	end
end)

RegisterServerEvent('esx:myAcSuckYourAssholeHacker')
AddEventHandler('esx:myAcSuckYourAssholeHacker', function(report)
	local _source = source

	if not IsPlayerAceAllowed(_source, 'command.ac_bypass') then
        TriggerEvent('esx:customDiscordLog', "Joueur : " .. GetPlayerName(_source) .. " [" .. _source .. "] (" .. GetPlayerIdentifiers(_source)[1] .. ") - Méthode : " .. report)
        print('Entiter supprimer')
	end
end)

RegisterServerEvent('esx:handleVeh')
AddEventHandler('esx:handleVeh', function(handle)
end)

--[[ESX.AddGroupCommand('cleanup', "admin", function(source, args, user)
	TriggerClientEvent('esx:byebyeEntities', -1)
end)]]--

TriggerEvent('es:addGroupCommand', 'cleanup', 'admin', function(source, args, user)
	TriggerClientEvent('esx:byebyeEntities', -1)
end)

function cmdunban(source, args)
    if args[1] then
        local target = table.concat(args, " ")
        MySQL.Async.fetchAll('SELECT * FROM tismey_ban WHERE targetplayername like @playername', {
            ['@playername'] = ("%"..target.."%")
        }, function(data)
            if data[1] then
                if #data > 1 then
                else
                    MySQL.Async.execute('DELETE FROM tismey_ban WHERE targetplayername = @name', {
                        ['@name']  = data[1].targetplayername
                    }, function ()
                        loadBanListAC()
                        TriggerClientEvent('chat:addMessage', source, { args = { '^1Banlist ', data[1].targetplayername.." was unban from Tismey Anti-Cheat" } } )
                    end)
                end
            else
            end
        end)
    else
    end
end

function loadBanListAC()
    MySQL.Async.fetchAll(
            'SELECT * FROM tismey_ban',
            {},
            function (data)
              BanList = {}

              for i=1, #data, 1 do
                    table.insert(BanList, {
                            license    = data[i].license,
                            identifier = data[i].identifier,
                            liveid     = data[i].liveid,
                            xblid      = data[i].xblid,
                            discord    = data[i].discord,
                            playerip   = data[i].playerip,
                            reason     = data[i].reason,
                            expiration = data[i].expiration,
                            permanent  = data[i].permanent
                      })
              end
end)
end

RegisterCommand("unbanac", function(source, args, raw)
        cmdunban(source, args)
end)

RegisterServerEvent("DynastyEulenKick")
AddEventHandler("DynastyEulenKick", function(reson)
	if(IsPlayerAceAllowed(source, "Dynasty.bypass")) then
		if(not reson == "keys") then
			print("Dynasty: " .. GetPlayerName(source) .. " [" .. source .. "] should have been kicked, but he is allowed to bypass.")
		end
	else
		if(reson == "keys") then
			DropPlayer(source, "Dynasty : Tu a éssayer d\'injecter un Mod Menu. Si tu pense que c\'est un erreur pas d\'inquiétude.. Tu n\'est pas ban, reconncte-toi juste sur le serveur. [Eulen Menu].")
		end
	end
end)