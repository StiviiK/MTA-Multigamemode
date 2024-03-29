local SweeperManager = inherit(Singleton)
SweeperManager.Map = {}
addRemoteEvents{"createClientSweeper", "destroyClientSweeper", "startSweeperFire", "stopSweeperFire", "changeSweeperWeapon", "fireSweeperRocket", "toggleSweeperLights"}

function SweeperManager:constructor()
  addEventHandler("createClientSweeper", root, bind(self.Event_CreateClientSweeper, self))
  addEventHandler("destroyClientSweeper", root, bind(self.Event_DestroyClientSweeper, self))
  addEventHandler("startSweeperFire", root, bind(self.Event_StartSweeperFire, self))
  addEventHandler("stopSweeperFire", root, bind(self.Event_StopSweeperFire, self))
  addEventHandler("changeSweeperWeapon", root, bind(self.Event_ChangeSweeperWeapon, self))
  addEventHandler("fireSweeperRocket", root, bind(self.Event_FireSweeperRocket, self))
  addEventHandler("toggleSweeperLights", root, bind(self.Event_ToggleSweeperLights, self))
end

function SweeperManager:destructor()
  for i, v in pairs(SweeperManager.Map) do
    delete(v)
  end
end

function SweeperManager:addRef(ref)
  SweeperManager.Map[ref:getId()] = ref
end

function SweeperManager:removeRef(ref)
  SweeperManager.Map[ref:getId()] = nil
end

function SweeperManager.getFromId(Id)
  return SweeperManager.Map[Id]
end

function SweeperManager.getFromVehicle(veh)
  for i, v in pairs(SweeperManager.Map) do
    if v:getVehicle() == veh then
      return v
    end
  end

  return false
end

-- EVENT ZONE
function SweeperManager:Event_CreateClientSweeper(...)
  self:addRef(SuperS.Sweeper:new(...))
end

function SweeperManager:Event_DestroyClientSweeper(Id)
  if not self.getFromId(Id) then return end
  delete(self.getFromId(Id))
end

function SweeperManager:Event_StartSweeperFire(Id, ...)
  if not self.getFromId(Id) then return end
  self.getFromId(Id):startFire(...)
end

function SweeperManager:Event_StopSweeperFire(Id, ...)
  if not self.getFromId(Id) then return end
  self.getFromId(Id):stopFire(...)
end

function SweeperManager:Event_ChangeSweeperWeapon(Id, ...)
  if not self.getFromId(Id) then return end
  self.getFromId(Id):changeWeapon(...)
end

function SweeperManager:Event_FireSweeperRocket(Id, ...)
  if not self.getFromId(Id) then return end
  self.getFromId(Id):fireRocket(...)
end

function SweeperManager:Event_ToggleSweeperLights(Id, ...)
  if not self.getFromId(Id) then return end
  self.getFromId(Id):toggleSweeperLights(...)
end

-- "Export" to SuperS
SuperS.SweeperManager = SweeperManager
