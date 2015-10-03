
local RadioList = {{ ["Name"] = "Kein Plan 1", ["Url"] = "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://us1.internet-radio.com:8180/listen.pls&t=.m3u"},
				   { ["Name"] = "Kein Plan 2", ["Url"] = "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://us1.internet-radio.com:11094/listen.pls&t=.m3u"},
				   { ["Name"] = "Kein Plan 3", ["Url"] = "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://us1.internet-radio.com:8105/listen.pls&t=.m3u"},
				   { ["Name"] = "Kein Plan 4", ["Url"] = "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk4.internet-radio.com:15476/listen.pls&t=.m3u"},
				   { ["Name"] = "Kein Plan 5", ["Url"] = "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk2.internet-radio.com:30092/listen.pls&t=.m3u"},
				   { ["Name"] = "Kein Plan 6", ["Url"] = "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk1.internet-radio.com:8052/live.m3u&t=.m3u"},
				   { ["Name"] = "Kein Plan 7", ["Url"] = "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://stream.uzic.ch:9010/listen.pls&t=.m3u"},
				   { ["Name"] = "Kein Plan 8",["Url"] = "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://toxxor.de:8000/listen.pls&t=.m3u"},
				   { ["Name"] = "Kein Plan 9", ["Url"] = "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://sl128.hnux.com/listen.pls&t=.m3u"}
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

end

 
function CarRadio:PlayRadioChannel ()
if isElement(self.RadioSound) then self:StopPlay () end
self.RadioSound = Sound.create(self.RadioChannelUrl)
self.RadioSound:setVolume(self.RadioVolume)
end

function CarRadio:StopPlay ()
self.RadioSound:stop()
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
		   
        end
    end
)

addEventHandler("onClientVehicleStartExit", getRootElement(),
    function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
		
        source.Radio:StopPlay ()
		source.Radio:UnBindRadioChannelChange ()
        end
    end
)










--------------Radio_Visual---------------

