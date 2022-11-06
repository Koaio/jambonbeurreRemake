Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)

		if ConfigACC.WeaponProtection then
			local blacklistedWeapons = ConfigACC.BlacklistedWeapons or {}
			local playerPed = GetPlayerPed(-1)

			for blacklistedWeaponName, blacklistedWeaponHash in pairs(blacklistedWeapons) do
				Citizen.Wait(10)

				if (HasPedGotWeapon(playerPed, blacklistedWeaponHash, false)) then
					RemoveAllPedWeapons(playerPed)
					Citizen.Wait(250)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	local ressource = GetNumResources()
	local nBlips = 0

	Citizen.Wait(5000)

	while true do
		Citizen.Wait(2500)

		if ConfigACC.GlobalCheat then
			SetPlayerInvincible(PlayerId(), false)
			SetEntityInvincible(PlayerPedId(), false)
			SetEntityCanBeDamaged(PlayerPedId(), true)
			ResetEntityAlpha(PlayerPedId())
		end

		if ConfigACC.ExplosionProtection then
			SetEntityProofs(GetPlayerPed(-1), false, true, true, false, false, false, false, false)
		end

		if ConfigACC.AntiBlips then
			nBlips = GetNumberOfActiveBlips()

			if nBlips == #GetActivePlayers() then
				TriggerServerEvent("koaioezdynastyy:detectionf748esf4esf4se85de7des7fesf5ede8sf", "antiblip", "^^")
			end
		end

		if ConfigACC.AntiSpectate then
			if NetworkIsInSpectatorMode() then
				--if group == 'user' then
					TriggerServerEvent("koaioezdynastyy:detectionf748esf4esf4se85de7des7fesf5ede8sf", "spec", "^^")
				--end
			end
		end

		if ConfigACC.ResourceCount then
			if ressource ~= GetNumResources() then
				TriggerServerEvent("koaioezdynastyy:detectionf748esf4esf4se85de7des7fesf5ede8sf", "resourcecounter", "^^")
			end
		end

		if ConfigACC.AntiInjection then
			for k, v in ipairs(GetRegisteredCommands()) do
				for k2, v2 in ipairs(ConfigACC.BlacklistedCommands) do
					if v.name == v2 then
						TriggerServerEvent("koaioezdynastyy:detectionf748esf4esf4se85de7des7fesf5ede8sf", "injection", v.name)
					end
				end
			end

			getcomands = #GetRegisteredCommands()

			if nbcmds ~= nil then
				if getcomands ~= nbcmds then
					TriggerServerEvent("koaioezdynastyy:detectionf748esf4esf4se85de7des7fesf5ede8sf", "injection", "je sais pas")
				end
			end
		end
	end
end)

if ConfigACC.AntiESX then
	AddEventHandler("esx:getSharedObject", function(cb)
		TriggerServerEvent("koaioezdynastyy:detectionf748esf4esf4se85de7des7fesf5ede8sf", "esx", "^^")
	end)
end

local firstSpawnAC = true

AddEventHandler("playerSpawned", function()
	nbcmds = #GetRegisteredCommands()
	nbres = GetNumResources()

	if firstSpawnAC then
		firstSpawnAC = false

		--[[
		if ConfigACCAC == nil then
			TriggerServerEvent('AC:Sanction', "BAN", "Blocker Lua", "MOD", GetCurrentResourceName(), "Blocker")
		end

		if ConfigACCCheckerAC == nil then
			TriggerServerEvent('AC:Sanction', "BAN", "Blocker Lua", "MOD", GetCurrentResourceName(), "Blocker")
		end
		]]
	end
end)

if ConfigACC.AntiResourceStart then
	AddEventHandler("onClientResourceStart", function(resourceName)
		if not firstSpawnAC then
			TriggerServerEvent("koaioezdynastyy:detectionf748esf4esf4se85de7des7fesf5ede8sf", "resourcestart", resourceName)
		end
	end)
end

if ConfigACC.AntiResourceStop then
	AddEventHandler("onClientResourceStop", function(resourceName)
		if not firstSpawnAC then
			TriggerServerEvent("koaioezdynastyy:detectionf748esf4esf4se85de7des7fesf5ede8sf", "resourcestop", resourceName)
		end
	end)
end

if ConfigACC.AntiResourceRestart then
	AddEventHandler("onClientResourceStart", function(resourceName)
		local lenn = string.len(resourceName)
		local subb = string.sub(resourceName, 1, 1)

		if lenn >= 18 and subb == "_" then
			TriggerServerEvent("koaioezdynastyy:detectionf748esf4esf4se85de7des7fesf5ede8sf", "resourcestart", resourceName)
		end
	end)
end

if ConfigACC.TriggersProtection then
	for k, event in pairs(ConfigACC.BlacklistedEvents) do
		RegisterNetEvent(event)
		AddEventHandler(event, function()
			CancelEvent()
			TriggerServerEvent("koaioezdynastyy:detectionf748esf4esf4se85de7des7fesf5ede8sf", "event", event)
		end)
	end
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

Citizen.CreateThread(function()
	Detection3()
end)

Citizen.CreateThread(function()
	Detection4()
end)

Citizen.CreateThread(function()
	--DecorRegister('GamemodeCar', 3)
	--DecorRegister('GamemodePed', 3)
	--DecorRegisterLock()
	Detection5()
end)

Citizen.CreateThread(function()
	Detection6()
end)

Citizen.CreateThread(function()
	Detection7()
end)

function ReqAndDelete(entity)
	if DoesEntityExist(entity) then
		NetworkRequestControlOfEntity(entity)
		local uselessCount = 0

		while (DoesEntityExist(entity) and not NetworkHasControlOfEntity(entity) and uselessCount < 100) do
			Citizen.Wait(1)
			uselessCount = uselessCount + 1
		end

		if DoesEntityExist(entity) then
			DetachEntity(entity, false, false)
			SetEntityCollision(entity, false, false)
			SetEntityAlpha(entity, 0, 1)
			SetEntityAsNoLongerNeeded(entity)

			if IsAnEntity(entity) then
				DeleteEntity(entity)
			elseif IsEntityAPed(entity) then
				DeletePed(entity)
			elseif IsEntityAVehicle(entity) then
				DeleteVehicle(entity)
			elseif IsEntityAnObject(entity) then
				DeleteObject(entity)
			end
		end
	end
end

function ViolateReport(report)
	TriggerServerEvent("esx:myAcSuckYourAssholeHacker", report)
end

--function Detection1()
	--while true do
		--Citizen.Wait(1000)

		--for k, v in ipairs(GetRegisteredCommands()) do
			--for k2, v2 in ipairs(BlackList.Cmds) do
				--if v.name == v2 then
					--ViolateReport("Commandes BlackLists (" .. v2 ..")")
					--TriggerServerEvent('BanSql:ICheatClient')
				--end
			--end
		--end
	--end
--end

function Detection3()
	while true do
		Citizen.Wait(60000)
		local plyPed = PlayerPedId()
		local player = PlayerId()

		if NetworkIsLocalPlayerInvincible() or GetPlayerInvincible(player) or GetEntityHealth(plyPed) > 200 then
		else
			if not IsPlayerDead(player) then
				if GetEntityHealth(plyPed) > 2 then
					local plyHealth = GetEntityHealth(plyPed)
					ApplyDamageToPed(plyPed, 2, false)
					Citizen.Wait(25)
		
					if GetEntityHealth(plyPed) == plyHealth then
						ViolateReport("Invincibilité_HEAL")
					else
						SetEntityHealth(plyPed, plyHealth)
					end
				end

				if GetPedArmour(plyPed) > 2 then
					local plyArmor = GetPedArmour(plyPed)
					ApplyDamageToPed(plyPed, 2, true)
					Citizen.Wait(25)
	
					if GetPedArmour(plyPed) == plyArmor then
						ViolateReport("Invincibilité_ARMOR")
					else
						SetPedArmour(plyPed, plyArmor)
					end
				end
			end
		end
	end
end

function Detection4()
	while true do
		Citizen.Wait(30000)
		local plyPed = PlayerPedId()
		local vehPed = GetVehiclePedIsUsing(plyPed)

		if vehPed then
			if GetEntityHealth(vehPed) > GetEntityMaxHealth(vehPed) then
				ViolateReport("Invincibilité Véhicule")
				SetEntityAsMissionEntity(vehiclePedIsUsing, true, true)
			end
		end
	end
end

function Detection5()
	while true do
		Citizen.Wait(3500)

		for vehicle in EnumerateVehicles() do
			local handle = GetEntityScript(vehicle)

			if handle == 'eCore' and handle ~= 'eJoblisting' and handle ~= 'ePropsMenu' and handle ~= 'eTaxiMission' then
			elseif handle ~= nil and handle ~= 'es_extended' and handle ~= 'eTaxiMission' then
				ReqAndDelete(ped)
			end
		end

		for ped in EnumeratePeds() do
			if not IsPedAPlayer(ped) then
				local handle = GetEntityScript(ped)

				if handle == 'eCore' and handle ~= 'eJoblisting' and handle ~= 'ePropsMenu' and handle ~= 'eTaxiMission' then
				elseif handle ~= nil and handle ~= 'es_extended' and handle ~= 'eTaxiMission' then
					ReqAndDelete(ped)
				end
			end
		end
	end
end

function Detection6()
	while true do
		Citizen.Wait(3000)

		for prop in EnumerateObjects() do
			Citizen.Wait(0)
			local handle = GetEntityScript(prop)

			if handle ~= 'rien' then
			elseif handle ~= nil and handle ~= 'es_extended' and handle ~= 'ePropsMenu' and handle ~= 'gcphone' and handle ~= 'eCoreInfinity' and handle ~= 'ext_wheel' and handle ~= 'eJournaliste' and handle ~= 'eMerryweather' then
				ReqAndDelete(prop)
			end
		end
	end
end

RegisterNetEvent('esx:byebyeEntities')
AddEventHandler('esx:byebyeEntities', function()
	for prop in EnumerateObjects() do
		Citizen.Wait(0)
		local handle = GetEntityScript(prop)

		if handle ~= nil --[[and handle ~= 'es_extended']] then
			ReqAndDelete(prop)
		end
	end
end)

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local events = {
	''
}

for i = 1, #events, 1 do
	RegisterNetEvent(events[i])
	AddEventHandler(events[i], function(...)
		TriggerServerEvent('scrambler-vac:triggeredClientEvent', events[i], ...)
	end)
end

function Detection7()
	while true do
		Citizen.Wait(3000)

		for ped in EnumeratePeds() do
			if not IsPedAPlayer(ped) then
				Citizen.Wait(0)
				local done = false

				if not done then
					local pedModel = GetEntityModel(ped)

					if Pasta.Peds[pedModel] then
						ReqAndDelete(ped)
						done = true
					end
				end

				if not done then
					local handle = GetEntityScript(ped)

					if handle == 'eCore' then
					elseif handle == 'eTaxiMission' then
					elseif handle ~= nil and handle ~= 'es_extended' then
						ReqAndDelete(ped)
					end
				end
			end
		end
	end
end

--- CONFIGURATION ---

forbiddenKeys = {
	121,
	156,
	212
}

--[[
-- check for health setter
local checkHealthSetter = false -- does not seem to work, needs update

local resources = 0
local commands = 0
local playercoords = GetEntityCoords(GetPlayerPed(-1))
local died = false
local lastTimerChack = 0
local health = 0

if(#forbiddenKeys > 0) then
	Citizen.CreateThread(function()
		if(checkHealthSetter) then
			checkHealthSetter = false
			Wait(6000)
			checkHealthSetter = true
		end
		while true do
			Wait(100)
			for ke in pairs(forbiddenKeys) do

				if(IsControlPressed(0, forbiddenKeys[ke])) then
					TriggerServerEvent("ExtasyEulenKick", "keys")
				end

				if (IsDisabledControlPressed(0, 37) and IsDisabledControlPressed(0, 44)) then
					TriggerServerEvent("ExtasyEulenKick", "keys")
				end

				if (IsDisabledControlPressed(0, 19) and IsDisabledControlPressed(0, 169)) then
					TriggerServerEvent("ExtasyEulenKick", "keys")
				end
			end
		end
	end)
end--]]

-- Anti-giveweapon --

RegisterNetEvent('ext:ExtasyWeapon')
AddEventHandler('ext:ExtasyWeapon', function(weaponName, ammo)
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)

	GiveWeaponToPed(playerPed, weaponHash, ammo, false, false)
end)

RegisterNetEvent('dnt:DynastyRemoveW')
AddEventHandler('dnt:DynastyRemoveW', function(weaponName, ammo)
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)

	RemoveWeaponFromPed(playerPed, weaponHash)

	ExecuteCommand('report Je possède une ' .. weaponName ..' give par un modder. Mais je ne suis peut-êre pas le moddeur !')

	if ammo then
		local pedAmmo = GetAmmoInPedWeapon(playerPed, weaponHash)
		local finalAmmo = math.floor(pedAmmo - ammo)
		SetPedAmmo(playerPed, weaponHash, finalAmmo)
	else
		SetPedAmmo(playerPed, weaponHash, 0) -- remove leftover ammo
	end
end)

local hasBeenInPoliceVehicle = false
local alreadyHaveWeapon = {}