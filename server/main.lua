ESX = nil

TriggerEvent("esx:getSharedObject", function(response)
    ESX = response
end)

RegisterServerEvent('esx_recycle:getItem')
AddEventHandler('esx_recycle:getItem', function()

    local luck = math.random(1, 3)

    if luck == 1 then

        local items = { -- add whatever items you want here
            'plastic'
        }

        local player = ESX.GetPlayerFromId(source)
        local randomItems = items[math.random(#items)]
        local quantity = math.random(3,10)
        local itemfound = ESX.GetItemLabel(randomItems)

        player.addInventoryItem(randomItems, quantity)
        --sendNotification(source, 'You found ' .. quantity .. ' x ' .. itemfound, 'success', 2500)
		TriggerClientEvent('esx:showNotification', source, 'You found '.. quantity .. itemfound)

    elseif luck == 2 then

        local items = { -- add whatever items you want here
            'glass'
        }

        local player = ESX.GetPlayerFromId(source)
        local randomItems = items[math.random(#items)]
        local quantity = math.random(3,10)
        local itemfound = ESX.GetItemLabel(randomItems)

        player.addInventoryItem(randomItems, quantity)
        --sendNotification(source, 'You found ' .. quantity .. ' x ' .. itemfound, 'success', 2500)
		TriggerClientEvent('esx:showNotification', source, 'You found '.. quantity .. itemfound)
    else
        local items = { -- add whatever items you want here
            'paper'
        }

        local player = ESX.GetPlayerFromId(source)
        local randomItems = items[math.random(#items)]
        local quantity = math.random(3,10)
        local itemfound = ESX.GetItemLabel(randomItems)

        player.addInventoryItem(randomItems, quantity)
        --sendNotification(source, 'You found ' .. quantity .. ' x ' .. itemfound, 'success', 2500)
		TriggerClientEvent('esx:showNotification', source, 'You found '.. quantity .. itemfound)
    end
end)