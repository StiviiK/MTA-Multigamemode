--{ ["Name"] = "", ["Url"] = ""},
local RadioList = {
				[0] = {["Name"] = "Radio Off"},---nicht entfernen

				   { ["Name"] = "Dublins KISS", ["Url"] = "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk4.internet-radio.com:15476/listen.pls&t=.m3u"},
				   { ["Name"] = "ChartHits.FM", ["Url"] = "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://95.141.24.3:80/listen.pls&t=.m3u"},
				   { ["Name"] = "Radio Jovem Pan FM", ["Url"] = "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://sh1.upx.com.br:9952/listen.pls?sid=1&t=.m3u"},
				   { ["Name"] = "1FM", ["Url"] = "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk2.internet-radio.com:8008/listen.pls&t=.m3u"}
}


local CarRadio = {}


function CarRadio:constructor (veh)
self.veh = veh
self.RadioChannelUrl = false
self.RadioChannel = 0
self:ShutStandarRadioOff ()
self.RadioVolume = 0.5
self.onRadioChannelChange = function(  key, keyState ) 
									if key == "mouse_wheel_up" then
										self:SwitchRadioChannel(1)
									else
										self:SwitchRadioChannel(-1)
									end

							end

self.RadioRender = function() self:render() end
end

 
function CarRadio:PlayRadioChannel ()
if isElement(self.RadioSound) then self:StopPlay () end
self.RadioSound = Sound.create(self.RadioChannelUrl)
self.RadioSound:setVolume(self.RadioVolume)
end

function CarRadio:StopPlay ()
	if isElement(self.RadioSound) then 
		self.RadioSound:stop()
	end
end

function CarRadio:StartPlay ()
	if self.RadioChannelUrl then
		self:PlayRadioChannel(self.RadioChannelUrl)
	end
end

function CarRadio:SwitchRadioChannel(state)

	if self.RadioChannel + state < 0 then
		self:ChangeRadioChannel (#RadioList)
	elseif self.RadioChannel + state == 0 then
		self:ChangeRadioChannel (0)
		
	elseif self.RadioChannel + state > #RadioList then
		self:ChangeRadioChannel (0)
	else
		self:ChangeRadioChannel (self.RadioChannel + state)
	end
end


function CarRadio:BindRadioChannelChange ()
bindKey ( "mouse_wheel_up"  , "both", self.onRadioChannelChange )
bindKey ( "mouse_wheel_down", "both", self.onRadioChannelChange )
end

function CarRadio:UnBindRadioChannelChange ()
unbindKey ( "mouse_wheel_up", "both", self.onRadioChannelChange )
unbindKey ( "mouse_wheel_down", "both", self.onRadioChannelChange )

end

function CarRadio:ChangeRadioChannel (Channel)
self.RadioChannel = tonumber(Channel)

	if self.RadioChannel == 0 then
		if isElement(self.RadioSound) then self:StopPlay () end
	else
		self.RadioChannelUrl = RadioList[self.RadioChannel]["Url"]
		self:PlayRadioChannel ()
	end

outputChatBox("Channel:"..self.RadioChannel)
end

function CarRadio:ShutStandarRadioOff ()
setRadioChannel (0)
addEventHandler("onClientPlayerRadioSwitch", getLocalPlayer(),function() cancelEvent() end)
end

function CarRadio:delete ()
self:destructor()
end

addEventHandler("onClientVehicleEnter", getRootElement(),
    function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
		
		if source.Radio then
			source.Radio:StartPlay ()
			source.Radio:BindRadioChannelChange ()
		else
           source.Radio = new(CarRadio,veh)
		   source.Radio:BindRadioChannelChange ()
		end
		
		 source.Radio:StartRender()
 
        end
    end
)

addEventHandler("onClientVehicleStartExit", getRootElement(),
    function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
		 source.Radio:StopRender()
        source.Radio:StopPlay ()
		source.Radio:UnBindRadioChannelChange ()
        end
    end
)










--------------Radio_Visual---------------


function CarRadio:render()
if self.RadioChannel == 0 then
	dxDrawText ( tostring(RadioList[self.RadioChannel]["Name"]), screenX/2, 0, screenX/2, 100, tocolor ( 255, 0, 0, 255 ), 2, "pricedown","center","center" )
else
	dxDrawText ( tostring(RadioList[self.RadioChannel]["Name"]), screenX/2, 0, screenX/2, 100, tocolor ( 0, 255, 0, 255 ), 2, "pricedown","center","center" )
end
end

function CarRadio:StartRender()
addEventHandler("onClientRender", root   , self.RadioRender)
end

function CarRadio:StopRender()
removeEventHandler("onClientRender", root, self.RadioRender)
end
