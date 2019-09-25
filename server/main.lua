ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'banker', _('phone_receive'), false, false)
TriggerEvent('esx_society:registerSociety', 'banker', _U('phone_label'), 'society_banker', 'society_banker', 'society_banker', {type = 'public'})

RegisterServerEvent('esx_bankerjob:customerDeposit')
AddEventHandler('esx_bankerjob:customerDeposit', function (target, amount)
	local xPlayer = ESX.GetPlayerFromId(target)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_banker', function (account)
		if amount > 0 and account.money >= amount then
			account.removeMoney(amount)

			TriggerEvent('esx_addonaccount:getAccount', 'bank_savings', xPlayer.identifier, function (account)
				account.addMoney(amount)
			end)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
		end
	end)
end)

RegisterServerEvent('esx_bankerjob:customerWithdraw')
AddEventHandler('esx_bankerjob:customerWithdraw', function (target, amount)
	local xPlayer = ESX.GetPlayerFromId(target)

	TriggerEvent('esx_addonaccount:getAccount', 'bank_savings', xPlayer.identifier, function (account)
		if amount > 0 and account.money >= amount then
			account.removeMoney(amount)

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_banker', function (account)
				account.addMoney(amount)
			end)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
		end
	end)
end)

ESX.RegisterServerCallback('esx_bankerjob:getCustomers', function (source, cb)
	local xPlayers  = ESX.GetPlayers()
	local customers = {}

	for i=1, #xPlayers do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		TriggerEvent('esx_addonaccount:getAccount', 'bank_savings', xPlayer.identifier, function(account)
			table.insert(customers, {
				source      = xPlayer.source,
				name        = xPlayer.name,
				bankSavings = result[i].money
			})
		end)
	end

	cb(customers)
end)

function CalculateBankSavings(d, h, m)
	local asyncTasks = {}

	MySQL.Async.fetchAll('SELECT * FROM addon_account_data WHERE account_name = @account_name', {
		['@account_name'] = 'bank_savings'
	}, function(result)
		local bankInterests = 1.5

		for i=1, #result, 1 do
			local xPlayer = ESX.GetPlayerFromIdentifier(result[i].owner)

			if xPlayer then
				TriggerEvent('esx_addonaccount:getAccount', 'bank_savings', xPlayer.identifier, function(account)
					local interests = math.floor(account.money * 0.0021)
					bankInterests   = bankInterests * interests

					table.insert(asyncTasks, function(cb)
						account.addMoney(interests)
					end)
				end)
			else
				local interests = math.floor(result[i].money * 0.0021)
				local newMoney  = result[i].money + interests
				local owner = result[i].owner
				bankInterests = bankInterests * interests

				local scope = function(newMoney, owner)
					table.insert(asyncTasks, function(cb)
						MySQL.Async.execute('UPDATE addon_account_data SET money = @money WHERE owner = @owner AND account_name = @account_name', {
							['@money']        = newMoney,
							['@owner']        = owner,
							['@account_name'] = 'bank_savings',
						}, function(rowsChanged)
							cb()
						end)
					end)
				end

				scope(newMoney, result[i].owner)
			end
		end

		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_banker', function(account)
			account.addMoney(bankInterests)
		end)

		Async.parallelLimit(asyncTasks, 5, function(results)
			print('[TD Banque] Calcul des comptes épargnes clients')
		end)
	end)
end

TriggerEvent('cron:runAt', 0, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 1, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 1, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 2, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 2, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 3, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 3, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 4, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 4, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 5, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 5, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 6, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 6, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 7, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 7, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 8, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 8, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 9, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 9, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 10, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 10, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 11, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 11, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 12, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 12, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 13, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 13, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 14, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 14, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 15, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 15, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 16, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 16, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 17, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 17, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 18, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 18, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 19, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 19, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 20, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 20, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 21, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 21, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 22, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 22, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 23, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 23, 30, CalculateBankSavings)
TriggerEvent('cron:runAt', 24, 0, CalculateBankSavings)
TriggerEvent('cron:runAt', 24, 30, CalculateBankSavings)