AntiCheat = inherit(Singleton)

function AntiCheat:constructor()
  -- Add remote Events
  addRemoteEvents{"AntiCheat:Event_RequestData"}
  addEventHandler("AntiCheat:Event_RequestData", root, bind(AntiCheat.checkLocalPlayer, self))
end

function AntiCheat:destructor()
end

-- AntiCheat Check Methods
function AntiCheat:checkLocalPlayer()
  local data = {
    Poistion = {unpackVector(localPlayer:getPosition())};
    Rotation = {unpackVector(localPlayer:getRotation())};
  }

  triggerServerEvent("AntiCheat:Event_CheckPlayer", localPlayer, data)
end
