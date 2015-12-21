local Sweeper = inherit(Object)

function Sweeper:constructor(Id, owner, vehicle, weapon, sweeperTexture)
  self.m_Id = Id
  self.m_Owner = owner
  self.m_Vehicle = vehicle
  self.m_Vehicle.m_Sweeper = self
  self.m_SweeperLights = {}
  self.m_Weapon = SuperS.Sweeper.Weapon:new(self, weapon)
  self.m_Shader = SuperS.Shader:new("gamemodes/SuperS/res/shader/swap.fx")
  self.m_Shader:setTexture(sweeperTexture or "gamemodes/SuperS/res/images/Logos/default.png")
  self.m_Shader:applyShaderValue("swap")
  self.m_Shader:applyToWorldTexture("sweeper92decal128", self.m_Vehicle)

  -- Events
  addEventHandler("onClientVehicleDamage", self:getVehicle(), bind(self.onAttack, self))
end

function Sweeper:destructor()
  SuperS.SweeperManager:getSingleton():removeRef(self)
  if self.m_Weapon then
    delete(self.m_Weapon)
  end

  -- Stop Sweeper Lights
  self:disableSweeperLights()
end

function Sweeper:getId()
  return self.m_Id
end

function Sweeper:getOwner()
  return self.m_Owner
end

function Sweeper:getVehicle()
  return self.m_Vehicle
end

function Sweeper:startFire(...)
  self.m_Weapon:startFire(...)
end

function Sweeper:stopFire(...)
  self.m_Weapon:stopFire(...)
end

function Sweeper:onAttack(attacker)
  if not isElement(self:getVehicle()) then return end
  local driver = self:getVehicle():getController()
  if attacker ~= nil and driver == localPlayer then
    if attacker ~= driver then
      if attacker:getType() == "vehicle" then -- Convert attacker (if it is the vehicle) to a player
        attacker = attacker.m_Sweeper:getOwner()
      end
      if attacker:getType() == "weapon" then -- Convert attacker (if it is the weapon) to a player
        attacker = attacker.m_Sweeper:getOwner()
      end
      if attacker:getType() == "player" then
        triggerServerEvent("onSweeperAttack", root, self:getId(), attacker)
      end
    end
  end
end

function Sweeper:changeWeapon(weapon)
  if self.m_Weapon then
    delete(self.m_Weapon)
  end
  self.m_Weapon = SuperS.Sweeper.Weapon:new(self, weapon)
end

function Sweeper:fireRocket()
  local pos = self:getVehicle():getPosition()
  local rot = self:getVehicle():getRotation()
  pos.x, pos.y = pos.x+4*math.cos(math.rad(rot.z+90)), pos.y+4*math.sin(math.rad(rot.z+90))
  Projectile(self:getVehicle(), 19, pos, 1.0, nil)
end

function Sweeper:toggleSweeperLights()
  if isTimer(self.m_SweeperLightTimer) then
    self:disableSweeperLights()
  else
    self:enableSweeperLights()
  end
end

function Sweeper:enableSweeperLights()
  self.m_SweeperLights = {}
  self.m_SweeperLightStep = 1
  self.m_SweeperLightTimer = Timer(bind(self.animateSweeperLights, self), 250, -1)
end

function Sweeper:disableSweeperLights()
  if isTimer(self.m_SweeperLightTimer) then
    killTimer(self.m_SweeperLightTimer)
  end

  for i, v in pairs(self.m_SweeperLights) do
    if isElement(v) then
      destroyElement(v)
    end
  end
end

function Sweeper:animateSweeperLights()
  local dim = SuperS:getInstance():getDimension()
  if self.m_SweeperLightStep == 1 then
    self.m_SweeperLights[1] = Marker(0, 0, 0, "corona", 0.2, 255, 0, 0, 255)
    self.m_SweeperLights[1]:setDimension(dim)
    self.m_SweeperLights[2] = Marker(0, 0, 0, "corona", 0.2, 255, 0, 0, 255)
    self.m_SweeperLights[2]:setDimension(dim)
    attachElements(self.m_SweeperLights[1], self.m_Vehicle, 0.4, 0.45, 1.35)
    attachElements(self.m_SweeperLights[2], self.m_Vehicle, -0.4, 0.45, 1.35)

    self.m_SweeperLightStep = 2
  elseif self.m_SweeperLightStep == 2 then
    if isElement(self.m_SweeperLights[1]) then
      destroyElement(self.m_SweeperLights[1])
      destroyElement(self.m_SweeperLights[2])
    end

    self.m_SweeperLightStep = 3
  elseif self.m_SweeperLightStep == 3 then
    self.m_SweeperLights[3] = Marker(0, 0, 0, "corona", 0.2, 255, 255, 255, 255)
    self.m_SweeperLights[3]:setDimension(dim)
    attachElements(self.m_SweeperLights[3], self.m_Vehicle, 0, 0.45, 1.35)

    self.m_SweeperLightStep = 4
  elseif self.m_SweeperLightStep == 4 then
    if isElement(self.m_SweeperLights[3]) then
      destroyElement(self.m_SweeperLights[3])
    end

    self.m_SweeperLightStep = 1
  end
end

-- "Export" to SuperS
SuperS.Sweeper = Sweeper
