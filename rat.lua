Citizen.CreateThread(function()
    if ConfigACC.BanSystem == true then
    function AddBan(licenseid, targetName, permanent)
        MySQL.Async.execute('INSERT INTO ratelimit_ban (licenseid, targetName, permanent) VALUES (@licenseid, @targetName, @permanent)', {
            ['@licenseid'] = licenseid,
            ['@targetName'] = targetName,
            ['@permanent'] = permanent
        }, function()
        end)
    end
 
    function IsBanned(licenseid, cb)
        MySQL.Async.fetchAll('SELECT * FROM ratelimit_ban WHERE licenseid = @licenseid', {
            ['@licenseid'] = licenseid
        }, function(result)
            if #result > 0 then
                cb(true, result[1])
            else
                cb(false, result[1])
            end
        end)
    end
    AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
        local _source = source
        local licenseid, playerip = 'N/A', 'N/A'
        licenseid = GetPlayerIdentifier(_source)
 
        if not licenseid then
            setKickReason("NOTHING")
            CancelEvent()
        end
 
        deferrals.defer()
        Citizen.Wait(0)
        deferrals.update(('Vérification de %s en cours...'):format(playerName))
        Citizen.Wait(0)
 
        IsBanned(licenseid, function(isBanned, banData)
            if isBanned then
                deferrals.done(ConfigACC.BanMessage)
            else
                deferrals.done()
            end
        end)
    end)
end
end)
 
Citizen.CreateThread(function()
    if ConfigACC.WebhookLink == nil then
        print("[WARNING] Webhook Discord est pas ConfigACC !")
        return
    end
 
    --CODE FOR RATE
    local Trig = {}
    AddEventHandler('ratelimit', function(ids, res)
    local _source = source
	local w = "unknown"
	local x = "unknown"
	local y = "unknown"
	local z = "unknown"
	local A = "unknown"
	local B = "unknown"
	local C = "unknown"
	for m, n in ipairs(GetPlayerIdentifiers(ids)) do
		if n:match("steam") then
			w = n
		elseif n:match("discord") then
			x = n:gsub("discord:", "")
		elseif n:match("license") then
			y = n
		elseif n:match("live") then
			z = n
		elseif n:match("xbl") then
			B = n
		elseif n:match("ip") then
			C = n:gsub("ip:", "")
		end
	end;
	local D = GetPlayerName(ids)
	logwebhookcolor = 1769216;
    if Trig[ids] ~= nil then
        if Trig[ids] ~= 'off' then
            if Trig[ids] == ConfigACC.RateLimit then 
                if ConfigACC.BanSystem == true then
                    --ban function
                    AddBan(GetPlayerIdentifier(ids), GetPlayerName(ids), 1)
                    DropPlayer(ids, ConfigACC.BanMessage)
                    PerformHttpRequest(ConfigACC.WebhookLink, function(E, F, G)
                    end, "POST", json.encode({
                        embeds = {
                            {
                                author = {
                                    name = "Rate Limit",
                                    icon_url = "https://assets.stickpng.com/images/5a81af7d9123fa7bcc9b0793.png"
                                },
                                title = "BANNED !",
                                description = "**Player:** "..D.."\n**ServerID:** "..ids.."\n**Violation:** ".."Spam Trigger".."\n**Details:** ".."Trigger Used : ".. res .."\n**SteamID:** "..w.."\n**Discord:** <@"..x..">".."\n**License:** "..y.."\n**Live:** "..z.."\n**Xbox:** "..B.."\n**IP:** "..C,
								color = 16711680
                            }
                        }
                    }), {
                        ["Content-Type"] = "application/json"
                    })        
                    Trig[ids] = 'off'
                else
                    DropPlayer(ids, ConfigACC.KickMessage)
                    PerformHttpRequest(ConfigACC.WebhookLink, function(E, F, G)
                    end, "POST", json.encode({
                        embeds = {
                            {
                                author = {
                                    name = "Rate Limit",
                                    icon_url = "https://assets.stickpng.com/images/5a81af7d9123fa7bcc9b0793.png"
                                },
                                title = "KICKED !",
                                description = "**Player:** "..D.."\n**ServerID:** "..ids.."\n**Violation:** ".."Spam Trigger".."\n**Details:** ".."Trigger Used : ".. res .."\n**SteamID:** "..w.."\n**Discord:** <@"..x..">".."\n**License:** "..y.."\n**Live:** "..z.."\n**Xbox:** "..B.."\n**IP:** "..C,
								color = 16760576
                            }
                        }
                    }), {
                        ["Content-Type"] = "application/json"
                    })        
                    Trig[ids] = 'off'    
                end
            else
                Trig[ids] = Trig[ids] + 1
            end
            else
                if BanSystem == true then
                    --ban function
                    AddBan(GetPlayerIdentifier(ids), GetPlayerName(ids), 1)
                    DropPlayer(ids, ConfigACC.BanMessage)
                else
                    DropPlayer(ids, ConfigACC.KickMessage)
                end
            end
        else
            Trig[ids] = 1
        end
    end)
 
    --FUNCTION START COUTING
    CountTrig()
end)
 
 
function CountTrig()
    Trig = {}
    SetTimeout(ConfigACC.ResetRateLimit, CountTrig)
end