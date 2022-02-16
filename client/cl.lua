if Config.UseOldEsx then
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

local pdata = ESX.GetPlayerData()

CreateThread(function()
    while true do
        local sleep = 750
        local ped = PlayerPedId()
        local pedc = GetEntityCoords(ped)

        for _,v in pairs(Config.Shops) do
            local dist = #(pedc - v.coords)

            if dist < Config.Distance then
                sleep = 0
                txt3d(Locales[Config.Locale]['open_menu'], v.coords)
                if IsControlJustPressed(0, 38) then
                    if Config.UseLicense then
                        ESX.TriggerServerCallback('esx_license:checkLicense', function(checkLicense)
                            if checkLicense then
                                if Config.UseProgressBar then
                                    exports['progressBars']:startUI(3000, Locales[Config.Locale]['wait_stock'])
                                    Wait(3000)
                                    local elements = {}

                                    for i=1, #v.weapons do

                                        if ESX.GetWeaponLabel(v.weapons[i].name) ~= nil then
                                            if v.weapons[i].stock == 0 then
                                                table.insert(elements, {
                                                    label = ESX.GetWeaponLabel(v.weapons[i].name).. ' - <span style="color:lime;">$' ..ESX.Math.GroupDigits(v.weapons[i].price).. '</span> - ' ..Locales[Config.Locale]['stock_fully'].. ' <span style="color:red;">' ..Locales[Config.Locale]['menu_not_stock'].. '</span>',
                                                    name = v.weapons[i].name,
                                                    price = v.weapons[i].price,
                                                    stock = v.weapons[i].stock,
                                                    id = v.weapons[i].id
                                                })
                                            else
                                                table.insert(elements, {
                                                    label = ESX.GetWeaponLabel(v.weapons[i].name).. ' - <span style="color:lime;">$' ..ESX.Math.GroupDigits(v.weapons[i].price).. '</span> - ' ..Locales[Config.Locale]['stock_fully'].. ' <span style="color:yellow;">[' ..v.weapons[i].stock.. ']</span>',
                                                    name = v.weapons[i].name,
                                                    price = v.weapons[i].price,
                                                    stock = v.weapons[i].stock,
                                                    id = v.weapons[i].id
                                                })
                                            end
                                        else
                                            print('[^1ERROR^0]: An error has occurred, take a good look at your cfg.lua')
                                        end
                                    end    

                                    if Debug.Enabled then
                                        print(json.encode(elements))
                                    end

                                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weaponshop', {
                                        title = Locales[Config.Locale]['weaponshop_title'],
                                        align = Config.MenuAlign,
                                        elements = elements
                                    }, function(data, menu)
                                        local b = data.current

                                        menu.close()

                                        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weaponshop_selector', {
                                            title = Locales[Config.Locale]['weaponshop_payin'],
                                            align = Config.MenuAlign,
                                            elements = {
                                                {label = Locales[Config.Locale]['pay_money'], value = 'money'},
                                                {label = Locales[Config.Locale]['pay_bank'], value = 'bank'}
                                            }
                                        }, function(data2, menu2)
                                            if data2.current.value == 'money' then
                                                TriggerServerEvent('esx_weaponshop:comprarArmas', 'money', b.name, b.price, b.stock, b.id)
                                                print('printeo')
                                            end

                                            if data2.current.value == 'bank' then
                                                TriggerServerEvent('esx_weaponshop:comprarArmas', 'bank', b.name, b.price, b.stock, b.id)
                                            end

                                            menu2.close()
                                        end, function(data2, menu2)
                                            menu2.close()
                                        end)
                                    end, function(data, menu)
                                        menu.close()
                                    end)
                                else
                                    ESX.ShowNotification(Locales[Config.Locale]['wait_stock'])
                                    Wait(3000)
                                    local elements = {}

                                    for i=1, #v.weapons do

                                        if ESX.GetWeaponLabel(v.weapons[i].name) ~= nil then
                                            if v.weapons[i].stock == 0 then
                                                table.insert(elements, {
                                                    label = ESX.GetWeaponLabel(v.weapons[i].name).. ' - <span style="color:lime;">$' ..ESX.Math.GroupDigits(v.weapons[i].price).. '</span> - ' ..Locales[Config.Locale]['stock_fully'].. ' <span style="color:red;">' ..Locales[Config.Locale]['menu_not_stock'].. '</span>',
                                                    name = v.weapons[i].name,
                                                    price = v.weapons[i].price,
                                                    stock = v.weapons[i].stock,
                                                    id = v.weapons[i].id
                                                })
                                            else
                                                table.insert(elements, {
                                                    label = ESX.GetWeaponLabel(v.weapons[i].name).. ' - <span style="color:lime;">$' ..ESX.Math.GroupDigits(v.weapons[i].price).. '</span> - ' ..Locales[Config.Locale]['stock_fully'].. ' <span style="color:yellow;">[' ..v.weapons[i].stock.. ']</span>',
                                                    name = v.weapons[i].name,
                                                    price = v.weapons[i].price,
                                                    stock = v.weapons[i].stock,
                                                    id = v.weapons[i].id
                                                })
                                            end
                                        else
                                            print('[^1ERROR^0]: An error has occurred, take a good look at your cfg.lua')
                                        end
                                    end    

                                    if Debug.Enabled then
                                        print(json.encode(elements))
                                    end

                                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weaponshop', {
                                        title = Locales[Config.Locale]['weaponshop_title'],
                                        align = Config.MenuAlign,
                                        elements = elements
                                    }, function(data, menu)
                                        local b = data.current

                                        menu.close()

                                        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weaponshop_selector', {
                                            title = Locales[Config.Locale]['weaponshop_payin'],
                                            align = Config.MenuAlign,
                                            elements = {
                                                {label = Locales[Config.Locale]['pay_money'], value = 'money'},
                                                {label = Locales[Config.Locale]['pay_bank'], value = 'bank'}
                                            }
                                        }, function(data2, menu2)
                                            if data2.current.value == 'money' then
                                                TriggerServerEvent('esx_weaponshop:comprarArmas', 'money', b.name, b.price, b.stock, b.id)
                                                print('printeo')
                                            end

                                            if data2.current.value == 'bank' then
                                                TriggerServerEvent('esx_weaponshop:comprarArmas', 'bank', b.name, b.price, b.stock, b.id)
                                            end

                                            menu2.close()
                                        end, function(data2, menu2)
                                            menu2.close()
                                        end)
                                    end, function(data, menu)
                                        menu.close()
                                    end)
                                end
                            else
                                ESX.ShowNotification(Locales[Config.Locale]['not_license'])
                            end
                        end)
                    else
                        if Config.UseProgressBar then
                            exports['progressBars']:startUI(3000, Locales[Config.Locale]['wait_stock'])
                            Wait(3000)
                            local elements = {}

                            for i=1, #v.weapons do
                                print('I: ' ..i)
                                if ESX.GetWeaponLabel(v.weapons[i].name) ~= nil then
                                    if v.weapons[i].stock == 0 then
                                        table.insert(elements, {
                                            label = ESX.GetWeaponLabel(v.weapons[i].name).. ' - <span style="color:lime;">$' ..ESX.Math.GroupDigits(v.weapons[i].price).. '</span> - ' ..Locales[Config.Locale]['stock_fully'].. ' <span style="color:red;">' ..Locales[Config.Locale]['menu_not_stock'].. '</span>',
                                            name = v.weapons[i].name,
                                            price = v.weapons[i].price,
                                            stock = v.weapons[i].stock,
                                            id = v.weapons[i].id
                                        })
                                    else
                                        table.insert(elements, {
                                            label = ESX.GetWeaponLabel(v.weapons[i].name).. ' - <span style="color:lime;">$' ..ESX.Math.GroupDigits(v.weapons[i].price).. '</span> - ' ..Locales[Config.Locale]['stock_fully'].. ' <span style="color:yellow;">[' ..v.weapons[i].stock.. ']</span>',
                                            name = v.weapons[i].name,
                                            price = v.weapons[i].price,
                                            stock = v.weapons[i].stock,
                                            id = v.weapons[i].id
                                        })
                                    end
                                else
                                    print('[^1ERROR^0]: An error has occurred, take a good look at your cfg.lua')
                                end
                            end    

                            if Debug.Enabled then
                                print(json.encode(elements))
                            end

                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weaponshop', {
                                title = Locales[Config.Locale]['weaponshop_title'],
                                align = Config.MenuAlign,
                                elements = elements
                            }, function(data, menu)
                                local b = data.current

                                menu.close()

                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weaponshop_selector', {
                                    title = Locales[Config.Locale]['weaponshop_payin'],
                                    align = Config.MenuAlign,
                                    elements = {
                                        {label = Locales[Config.Locale]['pay_money'], value = 'money'},
                                        {label = Locales[Config.Locale]['pay_bank'], value = 'bank'}
                                    }
                                }, function(data2, menu2)
                                    if data2.current.value == 'money' then
                                        TriggerServerEvent('esx_weaponshop:comprarArmas', 'money', b.name, b.price, b.stock, b.id)
                                        print('printeo')
                                    end

                                    if data2.current.value == 'bank' then
                                        TriggerServerEvent('esx_weaponshop:comprarArmas', 'bank', b.name, b.price, b.stock, b.id)
                                    end

                                    menu2.close()
                                end, function(data2, menu2)
                                    menu2.close()
                                end)
                            end, function(data, menu)
                                menu.close()
                            end)
                        else
                            ESX.ShowNotification(Locales[Config.Locale]['wait_stock'])
                            Wait(3000)
                            local elements = {}

                            for i=1, #v.weapons do
                                print('I: ' ..i)
                                if ESX.GetWeaponLabel(v.weapons[i].name) ~= nil then
                                    if v.weapons[i].stock == 0 then
                                        table.insert(elements, {
                                            label = ESX.GetWeaponLabel(v.weapons[i].name).. ' - <span style="color:lime;">$' ..ESX.Math.GroupDigits(v.weapons[i].price).. '</span> - ' ..Locales[Config.Locale]['stock_fully'].. ' <span style="color:red;">' ..Locales[Config.Locale]['menu_not_stock'].. '</span>',
                                            name = v.weapons[i].name,
                                            price = v.weapons[i].price,
                                            stock = v.weapons[i].stock,
                                            id = v.weapons[i].id
                                        })
                                    else
                                        table.insert(elements, {
                                            label = ESX.GetWeaponLabel(v.weapons[i].name).. ' - <span style="color:lime;">$' ..ESX.Math.GroupDigits(v.weapons[i].price).. '</span> - ' ..Locales[Config.Locale]['stock_fully'].. ' <span style="color:yellow;">[' ..v.weapons[i].stock.. ']</span>',
                                            name = v.weapons[i].name,
                                            price = v.weapons[i].price,
                                            stock = v.weapons[i].stock,
                                            id = v.weapons[i].id
                                        })
                                    end
                                else
                                    print('[^1ERROR^0]: An error has occurred, take a good look at your cfg.lua')
                                end
                            end    

                            if Debug.Enabled then
                                print(json.encode(elements))
                            end

                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weaponshop', {
                                title = Locales[Config.Locale]['weaponshop_title'],
                                align = Config.MenuAlign,
                                elements = elements
                            }, function(data, menu)
                                local b = data.current

                                menu.close()

                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weaponshop_selector', {
                                    title = Locales[Config.Locale]['weaponshop_payin'],
                                    align = Config.MenuAlign,
                                    elements = {
                                        {label = Locales[Config.Locale]['pay_money'], value = 'money'},
                                        {label = Locales[Config.Locale]['pay_bank'], value = 'bank'}
                                    }
                                }, function(data2, menu2)
                                    if data2.current.value == 'money' then
                                        TriggerServerEvent('esx_weaponshop:comprarArmas', 'money', b.name, b.price, b.stock, b.id)
                                        print('printeo')
                                    end

                                    if data2.current.value == 'bank' then
                                        TriggerServerEvent('esx_weaponshop:comprarArmas', 'bank', b.name, b.price, b.stock, b.id)
                                    end

                                    menu2.close()
                                end, function(data2, menu2)
                                    menu2.close()
                                end)
                            end, function(data, menu)
                                menu.close()
                            end)
                        end
                    end
                end
            end

            if pdata.job.name == Config.JobName then
                local distance = #(pedc - v.stockcoords)
                if distance < Config.Distance then
                    sleep = 0
                    txt3d(Locales[Config.Locale]['open_menu'], v.stockcoords)
                    if IsControlJustPressed(0, 38) then
                        if Config.UseProgressBar then
                            exports['progressBars']:startUI(3000, Locales[Config.Locale]['wait_stock'])
                            Wait(3000)
                            local elements = {}

                            for i=1, #v.weapons do
                                if ESX.GetWeaponLabel(v.weapons[i].name) ~= nil then
                                    if v.weapons[i].stock == 0 then
                                        table.insert(elements, {
                                            label = ESX.GetWeaponLabel(v.weapons[i].name).. ' | ' ..Locales[Config.Locale]['stock_fully'].. ' <span style="color:red;">[' ..v.weapons[i].stock.. ']</span>',
                                            name = v.weapons[i].name,
                                            stock = v.weapons[i].stock,
                                            id = v.weapons[i].id
                                        })
                                    else
                                        table.insert(elements, {
                                            label = ESX.GetWeaponLabel(v.weapons[i].name).. ' | ' ..Locales[Config.Locale]['stock_fully'].. ' <span style="color:lime;">[' ..v.weapons[i].stock.. ']</span>',
                                            name = v.weapons[i].name,
                                            stock = v.weapons[i].stock,
                                            id = v.weapons[i].id
                                        })
                                    end
                                else
                                    print('[^1ERROR^0]: An error has occurred, take a good look at your cfg.lua')
                                end
                            end

                            if Debug.Enabled then
                                print(json.encode(elements))
                            end

                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stockmenu', {
                                title = Locales[Config.Locale]['stock_title'],
                                align = Config.MenuAlign,
                                elements = elements
                            }, function(data, menu)
                                local v = data.current

                                TriggerServerEvent('fs_weaponshop:sv:addStock', v.id, v.name, v.stock)
                                menu.close()

                            end, function(data, menu)
                                menu.close()
                            end)
                        else
                            ESX.ShowNotification(Locales[Config.Locale]['wait_stock'])
                            Wait(3000)
                            local elements = {}

                            for i=1, #v.weapons do
                                if ESX.GetWeaponLabel(v.weapons[i].name) ~= nil then
                                    if v.weapons[i].stock == 0 then
                                        table.insert(elements, {
                                            label = ESX.GetWeaponLabel(v.weapons[i].name).. ' | ' ..Locales[Config.Locale]['stock_fully'].. ' <span style="color:red;">[' ..v.weapons[i].stock.. ']</span>',
                                            name = v.weapons[i].name,
                                            stock = v.weapons[i].stock,
                                            id = v.weapons[i].id
                                        })
                                    else
                                        table.insert(elements, {
                                            label = ESX.GetWeaponLabel(v.weapons[i].name).. ' | ' ..Locales[Config.Locale]['stock_fully'].. ' <span style="color:lime;">[' ..v.weapons[i].stock.. ']</span>',
                                            name = v.weapons[i].name,
                                            stock = v.weapons[i].stock,
                                            id = v.weapons[i].id
                                        })
                                    end
                                else
                                    print('[^1ERROR^0]: An error has occurred, take a good look at your cfg.lua')
                                end
                            end

                            if Debug.Enabled then
                                print(json.encode(elements))
                            end

                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stockmenu', {
                                title = Locales[Config.Locale]['stock_title'],
                                align = Config.MenuAlign,
                                elements = elements
                            }, function(data, menu)
                                local v = data.current

                                TriggerServerEvent('fs_weaponshop:sv:addStock', v.id, v.name, v.stock)
                                menu.close()

                            end, function(data, menu)
                                menu.close()
                            end)
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    for _,v in pairs(Config.Shops) do
        blip = AddBlipForCoord(v.coords)
        SetBlipScale(blip, Blips.Scale)
        SetBlipSprite(blip, Blips.Sprite)
        SetBlipColour(blip, Blips.Color)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Ammu-nation')
        EndTextCommandSetBlipName(blip)
    end
end)

function OpenStockMenu()
    local elements = {}

    for _,v in pairs(Config.Shops) do
        for i=1, #v.weapons do
            if ESX.GetWeaponLabel(v.weapons[i].name) ~= nil then
                if v.weapons[i].stock == 0 then
                    table.insert(elements, {
                        label = ESX.GetWeaponLabel(v.weapons[i].name).. ' | ' ..Locales[Config.Locale]['stock_fully'].. ' <span style="color:red;">[' ..v.weapons[i].stock.. ']</span>',
                        name = v.weapons[i].name,
                        stock = v.weapons[i].stock,
                        id = v.weapons[i].id
                    })
                else
                    table.insert(elements, {
                        label = ESX.GetWeaponLabel(v.weapons[i].name).. ' | ' ..Locales[Config.Locale]['stock_fully'].. ' <span style="color:lime;">[' ..v.weapons[i].stock.. ']</span>',
                        name = v.weapons[i].name,
                        stock = v.weapons[i].stock,
                        id = v.weapons[i].id
                    })
                end
            else
                print('[^1ERROR^0]: An error has occurred, take a good look at your cfg.lua')
            end
        end    
    end

    if Debug.Enabled then
        print(json.encode(elements))
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stockmenu', {
        title = Locales[Config.Locale]['stock_title'],
        align = Config.MenuAlign,
        elements = elements
    }, function(data, menu)
        local v = data.current

        TriggerServerEvent('fs_weaponshop:sv:addStock', v.id, v.name, v.stock)
        menu.close()

    end, function(data, menu)
        menu.close()
    end)
end

function txt3d(msg, coords)
    SetFloatingHelpTextWorldPosition(1, coords.x, coords.y, coords.z)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(2, false, true, -1)
end

RegisterNetEvent('esx_weaponshop:refreshStock')
AddEventHandler('esx_weaponshop:refreshStock', function(id, stock)
    for _,v in pairs(Config.Shops) do
        for i=1, #v.weapons do
            v.weapons[id].stock = stock + -1
        end
    end
end)

RegisterNetEvent('esx_weaponshop:addStock')
AddEventHandler('esx_weaponshop:addStock', function(id, stock)
    for _,v in pairs(Config.Shops) do
        for i=1, #v.weapons do
            v.weapons[id].stock = stock + 1
        end
    end
end)