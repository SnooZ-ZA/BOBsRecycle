drawText3D = function(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
  
	local scale = 0.30
   
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 650
        --DrawRect(_x, _y + 0.0120, 0.030 + factor , 0.030, 66, 66, 66, 100)
	end
end

showPercent = function(time)
	percent = true
	TimeLeft = 0
	repeat
	TimeLeft = TimeLeft + 1
	Citizen.Wait(time)
	until(TimeLeft == 100)
	percent = false
end

openBox = function(entity)
	searching = true
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_SHOPPING_CART", 0, true)
	showPercent(100)
    cachedBoxes[entity] = true
    TriggerServerEvent('esx_recycle:getItem')
	ClearPedTasks(PlayerPedId())
	searching = false
end

sendNotification = function(message, messageType, messageTimeout)
	TriggerEvent("pNotify:SendNotification", {
		text = message,
		type = messageType,
		queue = "bazookan",
		timeout = messageTimeout,
		layout = "bottomCenter"
	})
end