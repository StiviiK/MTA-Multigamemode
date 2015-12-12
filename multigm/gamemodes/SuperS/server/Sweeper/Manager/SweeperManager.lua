local SweeperManager = inherit(Singleton)
SweeperManager.Map = {}
addRemoteEvents{"onSweeperAttack"}

function SweeperManager:constructor()
  -- Events
  addEventHandler("onSweeperAttack", root, bind(self.Event_OnSweeperAttack, self))
end

function SweeperManager:destructor()
  for i, v in pairs(SweeperManager.Map) do
    delete(v)
  end
end

function SweeperManager:addRef(ref)
  return table.push(SweeperManager.Map, ref)
end

function SweeperManager:removeRef(ref)
  SweeperManager.Map[ref:getId()] = nil
end

function SweeperManager.getFromId(Id)
  return SweeperManager.Map[Id]
end

function SweeperManager:createClient(ref)
  triggerClientEvent(root, "createClientSweeper", root, ref:getId(), ref.m_Owner, ref:getVehicle())
end

function SweeperManager:destroyClient(ref)
  triggerClientEvent(root, "destroyClientSweeper", root, ref:getId())
end

function SweeperManager:isSweeper(veh)
  for i, v in pairs(SweeperManager.Map) do
    if v:getVehicle() == veh then
      return true
    end
  end

  return false
end

function SweeperManager:getRandomSpawnPoint()
  return table.random(SuperS.m_Instance:get("SpawnPoints"))
  --return SuperS.m_Instance:get("SpawnPoints")[4]
end

-- Event Zone
function SweeperManager:Event_OnSweeperAttack(SweeperId, AttackerId)
  if not self.getFromId(SweeperId) then return end
  self.getFromId(SweeperId):onAttack(AttackerId)
end

-- "Export" to SuperS
SuperS.SweeperManager = SweeperManager
