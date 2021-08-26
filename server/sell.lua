local ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)

RegisterServerEvent("esx-Recycle:packagePlastic")
AddEventHandler("esx-Recycle:packagePlastic", function()
    local player = ESX.GetPlayerFromId(source)

    local currentPlastic = player.getInventoryItem("plastic")["count"]
    
    if currentPlastic >= 20 then
        player.removeInventoryItem("plastic", 20)
		TriggerClientEvent("esx-Recycle:packagePl", source)      
    else
        TriggerClientEvent("esx:showNotification", source, "You don't have enough Plastic to Package.")
    end
end)

RegisterServerEvent("esx-Recycle:packageGlass")
AddEventHandler("esx-Recycle:packageGlass", function()
    local player = ESX.GetPlayerFromId(source)

    local currentGlass = player.getInventoryItem("glass")["count"]
    
    if currentGlass >= 15 then
        player.removeInventoryItem("glass", 15)
		TriggerClientEvent("esx-Recycle:packagePl", source)     
    else
        TriggerClientEvent("esx:showNotification", source, "You don't have enough Glass to Package.")
    end
end)

RegisterServerEvent("esx-Recycle:packagePaper")
AddEventHandler("esx-Recycle:packagePaper", function()
    local player = ESX.GetPlayerFromId(source)

    local currentGlass = player.getInventoryItem("paper")["count"]
    
    if currentGlass >= 25 then
        player.removeInventoryItem("paper", 25)
		TriggerClientEvent("esx-Recycle:packagePl", source)      
    else
        TriggerClientEvent("esx:showNotification", source, "You don't have enough Paper to Package.")
    end
end)

RegisterServerEvent("esx-Recycle:sell")
AddEventHandler("esx-Recycle:sell", function()
    local player = ESX.GetPlayerFromId(source)
        player.addMoney(1000)
        TriggerClientEvent("esx:showNotification", source, "You got Paid $1000 for Cleaning up the city.")
end)
