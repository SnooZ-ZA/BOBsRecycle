ESX        = nil

searching  = false

cachedBoxes = {}

closestBox = {
	'prop_dumpster_01a',
    'prop_dumpster_02a',
    'prop_dumpster_02b',
	'prop_dumpster_4a',
	'prop_recyclebin_05_a',
	'prop_recyclebin_04_b',
	'prop_recyclebin_01a',
	'prop_cs_bin_03',
	'prop_cs_bin_01_skinned',
	'prop_cs_bin_01',
	'prop_bin_08open',
	'prop_bin_08a'

}

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(5)

		TriggerEvent("esx:getSharedObject", function(library)
			ESX = library
		end)
    end

    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	ESX.PlayerData = response
end)

Citizen.CreateThread(function()
    Citizen.Wait(100)
    while true do
        
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for i = 1, #closestBox do
            local x = GetClosestObjectOfType(playerCoords, 1.0, GetHashKey(closestBox[i]), false, false, false)
            local entity = nil
            if DoesEntityExist(x) then
                sleep  = 5
                entity = x
                box   = GetEntityCoords(entity)
				drawText3D(box.x, box.y, box.z + 1.5, '⚙️')		
                while IsControlPressed(0, 38) do
                drawText3D(box.x, box.y, box.z + 1.4, 'Press [~g~H~s~] to search ~b~ for recyclables ~s~')
				break
				end	
                if IsControlJustReleased(0, 74) then
                    if not cachedBoxes[entity] then
								SetEntityHeading(playerPed,GetHeadingFromVector_2d(box.x-playerCoords.x,box.y-playerCoords.y))
								searching = true
								exports.rprogress:Custom({
								Async = true,
								x = 0.5,
								y = 0.5,
								From = 0,
								To = 100,
								Duration = 10000,
								Radius = 60,
								Stroke = 10,
								MaxAngle = 360,
								Rotation = 0,
								Easing = "easeLinear",
								Label = "SEARCHING",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								scenario = "PROP_HUMAN_BUM_SHOPPING_CART", -- https://pastebin.com/6mrYTdQv
								--animationDictionary = "missheistfbisetup1", -- https://alexguirre.github.io/animations-list/
								--animationName = "unlock_loop_janitor",
								},
								DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
								},
								})
								Citizen.Wait(10000)
								cachedBoxes[entity] = true
								TriggerServerEvent('esx_recycle:getItem')
								ClearPedTasks(PlayerPedId())
								searching = false	
                        
                    else
						ESX.ShowNotification("You have already searched here!")
                    end
                end
                break
            else
                sleep = 1000
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if searching then
            DisableControlAction(0, 73)
			DisableControlAction(0, 74)
        end
    end
end)