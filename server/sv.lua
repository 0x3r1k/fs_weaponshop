if Config.UseOldEsx then
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

RegisterServerEvent('esx_weaponshop:comprarArmas')
AddEventHandler('esx_weaponshop:comprarArmas', function(type, name, price, stock, id)
    local xPlayer <const> = ESX.GetPlayerFromId(source)
    local xPlayers <const> = ESX.GetPlayers()

    if xPlayer.hasWeapon(name) then
        xPlayer.showNotification(Locales[Config.Locale]['weapon_full'])
    else
        if stock == 0 then
            xPlayer.showNotification(Locales[Config.Locale]['not_stock'])
        else
            if type == 'money' then
                if xPlayer.getAccount('money').money >= price then
                    xPlayer.removeAccountMoney('money', price)

                    if Config.UseOX then
                        xPlayer.addInventoryItem(name, 1)   
                    else
                        xPlayer.addWeapon(name, math.random(12, 30))   
                    end

                    xPlayer.showNotification(Locales[Config.Locale]['purchase_success'])
    
                    for i=1, #xPlayers do
                        TriggerClientEvent('esx_weaponshop:refreshStock', xPlayers[i], id, stock)
                    end
                else
                    xPlayer.showNotification(Locales[Config.Locale]['not_money'])
                end
            elseif type == 'bank' then
                if xPlayer.getAccount('bank').money >= price then
                    xPlayer.removeAccountMoney('bank', price)

                    if Config.UseOX then
                        xPlayer.addInventoryItem(name, 1)   
                    else
                        xPlayer.addWeapon(name, math.random(12, 30))   
                    end

                    xPlayer.showNotification(Locales[Config.Locale]['purchase_success'])
    
                    for i=1, #xPlayers do
                        TriggerClientEvent('esx_weaponshop:refreshStock', xPlayers[i], id, stock)
                    end
                else
                    xPlayer.showNotification(Locales[Config.Locale]['not_money'])
                end
            end
        end
    end
end)

RegisterServerEvent('fs_weaponshop:sv:addStock')
AddEventHandler('fs_weaponshop:sv:addStock', function(id, name, stock)
    local xPlayer <const> = ESX.GetPlayerFromId(source)
    local xPlayers <const> = ESX.GetPlayers()

    if not xPlayer.getLoadout(name) then
        xPlayer.showNotification(Locales[Config.Locale]['not_weapon'])
    else
        if stock == Config.MaxStock then
            xPlayer.showNotification(Locales[Config.Locale]['stockfull'])
        else
            for i=1, #xPlayers do
                TriggerClientEvent('esx_weaponshop:addStock', xPlayers[i], id, stock)
            end

            if Config.UseOX then
                xPlayer.removeInventoryItem(name, 1)
            else
                xPlayer.removeWeapon(name)
            end
        end
    end
end)