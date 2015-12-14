local Sweeper = inherit(Object)

function Sweeper:constructor(player, sweeperTexture)
  if player.m_SweeperId then
    delete(SuperS.SweeperManager:getSingleton().getFromId(player.m_SweeperId))
  end

  self.m_Id = SuperS.SweeperManager:getSingleton():addRef(self)
  self.m_Owner = player
  self.m_Vehicle = Vehicle(574, SuperS.SweeperManager:getSingleton():getRandomSpawnPoint())
  self.m_Vehicle:setDimension(SuperS:getInstance():getDimension())
  self.m_LastAttacker = false
  self.m_Weapon = 23
  self.m_Image = sweeperTexture or "gamemodes/SuperS/res/images/Logos/default.png"
  self.m_Items = Stack:new()

  player.m_SweeperId = self:getId()
  player:warpIntoVehicle(self.m_Vehicle)

  -- Add fire bindings
  self.m_FireFunc = bind(self.startFire, self)
  self.m_StopFunc = bind(self.stopFire, self)
  self.m_ItemFunc = bind(self.useItem, self)
  bindKey(self.m_Owner, "mouse1", "down", self.m_FireFunc)
  bindKey(self.m_Owner, "mouse1", "up", self.m_StopFunc)
  bindKey(self.m_Owner, "mouse2", "up", self.m_ItemFunc)

  -- Create Sweeper client instance
  SuperS.SweeperManager:getSingleton():createClient(self)

  -- Event Zone
  addEventHandler("onVehicleExplode", self:getVehicle(), function () delete(self) end)
  addEventHandler("onVehicleStartExit", self:getVehicle(), function() cancelEvent() end)
end

function Sweeper:destructor()
  if self.m_LastAttacker then
    if self.m_LastAttacker ~= self.m_Owner then
      if self.m_LastAttacker:getGamemode() == SuperS:getInstance() then
        -- Reward for the LastAttacker
        outputChatBox(self.m_LastAttacker:getName().." destroyed "..self.m_Owner:getName().."'s Sweeper!")
      end
    end
  end
  if self.m_Owner then
    -- Respawn the owner
  end

  SuperS.SweeperManager:getSingleton():destroyClient(self)
  SuperS.SweeperManager:getSingleton():removeRef(self)

  self.m_Owner.m_SweeperId = nil

  -- Remove fire bindings
  unbindKey(self.m_Owner, "mouse1", "down", self.m_FireFunc)
  unbindKey(self.m_Owner, "mouse1", "up", self.m_StopFunc)

  if isElement(self.m_Vehicle) then
    destroyElement(self.m_Vehicle)
  end
end

function Sweeper:getId()
  return self.m_Id
end

function Sweeper:getVehicle()
  return self.m_Vehicle
end

function Sweeper:getOwner()
  return self.m_Owner
end

function Sweeper:changeWeapon(weapon)
  self.m_Weapon = weapon
  triggerClientEvent(root, "changeSweeperWeapon", root, self:getId(), self:getWeapon())
end

function Sweeper:getWeapon()
  return self.m_Weapon
end

function Sweeper:startFire()
  triggerClientEvent(root, "startSweeperFire", root, self:getId())
end

function Sweeper:stopFire()
  triggerClientEvent(root, "stopSweeperFire", root, self:getId())
end

function Sweeper:onAttack(Attacker)
  self.m_LastAttacker = Attacker
  outputChatBox(Attacker:getName().." attacked "..self.m_Owner:getName().."'s Sweeper")
end

function Sweeper:getImage()
  return self.m_Image
end

function Sweeper:addItem(item)
  self.m_Items:push(item)
end

function Sweeper:useItem()
  local item = self.m_Items:pop()
  if item then
    item:use(self)
    delete(item)
  end
end

-- "Export" to SuperS
SuperS.Sweeper = Sweeper
