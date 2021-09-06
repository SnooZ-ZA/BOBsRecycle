ESX                           = nil

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)

        Citizen.Wait(5)
    end
end)


local blips = {
      {title="Recycle Centre", colour=4, id=467, x = 2051.34, y = 3173.68, z = 44.57}  
}
 
      
Citizen.CreateThread(function()
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.8)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)
  
local recycleloc = {
    {x = 2051.34, y = 3173.68, z = 44.57}
}
local recycleSellloc = {
    {x = 2061.80, y = 3177.00, z = 44.67}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(recycleloc) do
            DrawMarker(27, recycleloc[k].x, recycleloc[k].y, recycleloc[k].z, 0, 0, 0, 0, 0, 0, 1.600, 1.600, 0.3001, 0, 153, 255, 255, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(recycleSellloc) do
            DrawMarker(27, recycleSellloc[k].x, recycleSellloc[k].y, recycleSellloc[k].z, 0, 0, 0, 0, 0, 0, 1.600, 1.600, 0.3001, 0, 153, 255, 255, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(recycleloc) do
		
            local plyrecCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local recdist = Vdist(plyrecCoords.x, plyrecCoords.y, plyrecCoords.z, recycleloc[k].x, recycleloc[k].y, recycleloc[k].z)
			
            if recdist <= 1.5 then
				drawText3D(recycleloc[k].x, recycleloc[k].y, recycleloc[k].z + 1.0, '[E] ~b~Package Recyclables Here~s~')
				
				if IsControlJustPressed(0, 38) then
					OpenSellMenu()
				end			
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(recycleSellloc) do
		
            local plyrecCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local recSelldist = Vdist(plyrecCoords.x, plyrecCoords.y, plyrecCoords.z, recycleSellloc[k].x, recycleSellloc[k].y, recycleSellloc[k].z)
			
            if recSelldist <= 1.5 then
				drawText3D(recycleSellloc[k].x, recycleSellloc[k].y, recycleSellloc[k].z + 1.0, '[E] ~b~Place Box Here~s~')
				
				if IsControlJustPressed(0, 38) then
					TriggerEvent("esx-Recycle:box")
				end			
            end
        end
    end
end)

function OpenSellMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'pawn_sell_menu',
        {
            title    = 'Sell Recyclables Here!',
			align    = 'top-left',
            elements = {
                {label = 'Package 25 Paper', value = 'paper'},
				{label = 'Package 20 Plastic', value = 'plastic'},
				{label = 'Package 15 Glass', value = 'glass'}
				
            }
        },
        function(data, menu)
            if data.current.value == 'paper' then
				TriggerServerEvent("esx-Recycle:packagePaper")
				ESX.UI.Menu.CloseAll()
			elseif data.current.value == 'plastic' then
				TriggerServerEvent("esx-Recycle:packagePlastic")
				ESX.UI.Menu.CloseAll()
			elseif data.current.value == 'glass' then
				TriggerServerEvent("esx-Recycle:packageGlass")
				ESX.UI.Menu.CloseAll()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

RegisterNetEvent("esx-Recycle:packagePl")
AddEventHandler("esx-Recycle:packagePl",function()
		Citizen.Wait(10)
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
								Label = "Packaging",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
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
					ClearPedTasks(PlayerPedId())
					Citizen.Wait(300)
					RequestAnimDict("anim@heists@box_carry@")
					while not HasAnimDictLoaded("anim@heists@box_carry@") do
					Citizen.Wait(1)
					end
					TaskPlayAnim(GetPlayerPed(-1),"anim@heists@box_carry@","idle",1.0, -1.0, -1, 49, 0, 0, 0, 0)
					Citizen.Wait(300)
						attachModel = GetHashKey('hei_prop_heist_box')
						boneNumber = 28422
						SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263) 
						local bone = GetPedBoneIndex(GetPlayerPed(-1), boneNumber)
						RequestModel(attachModel)
							while not HasModelLoaded(attachModel) do
								Citizen.Wait(100)
							end
							attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
							AttachEntityToEntity(attachedProp, GetPlayerPed(-1), bone, 0.0, 0.0, 0.0, 135.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
							ESX.ShowNotification("Take the box to the storage!")
end)


RegisterNetEvent("esx-Recycle:box")
AddEventHandler("esx-Recycle:box",function()
	if DoesEntityExist(attachedProp) then
		Citizen.Wait(10)
					exports.rprogress:Custom({
								Async = true,
								x = 0.5,
								y = 0.5,
								From = 0,
								To = 100,
								Duration = 3000,
								Radius = 60,
								Stroke = 10,
								MaxAngle = 360,
								Rotation = 0,
								Easing = "easeLinear",
								Label = "Placing Box",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
								--animationDictionary = "missheistfbisetup1", -- https://alexguirre.github.io/animations-list/
								--animationName = "unlock_loop_janitor",
								},
								DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
								},
								})
					Citizen.Wait(3000)
					ClearPedTasks(PlayerPedId())
					RemoveAnimDict("anim@heists@box_carry@")
					DeleteEntity(attachedProp)
					TriggerServerEvent("esx-Recycle:sell")
		else
		ESX.ShowNotification("Go Package First!")
		end
end)
