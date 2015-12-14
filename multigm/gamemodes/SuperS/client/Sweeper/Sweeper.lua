local Sweeper = inherit(Object)

function Sweeper:constructor(Id, owner, vehicle, weapon, sweeperTexture)
  self.m_Id = Id
  self.m_Owner = owner
  self.m_Vehicle = vehicle
  self.m_Vehicle.m_Sweeper = self
  self.m_Weapon = SuperS.Sweeper.Weapon:new(self, weapon)
  self.m_Shader = SuperS.Shader:new("gamemodes/SuperS/res/shader/swap.fx")
  self.m_Shader:setTexture(sweeperTexture or "gamemodes/SuperS/res/images/Logos/default.png")
  self.m_Shader:applyShaderValue("swap")
  self.m_Shader:applyToWorldTexture("sweeper92decal128", self.m_Vehicle)

  -- Apply spawn-protection
  for i, v in pairs(Element.getAllByType("vehicle")) do
    v:setCollidableWith(self.m_Vehicle, false)
  end
  self.m_Vehicle:setDamageProof(true)
  self.m_Vehicle:setAlpha(150)

  setTimer(function ()
    for i, v in pairs(Element.getAllByType("vehicle")) do
      v:setCollidableWith(self.m_Vehicle, true)
    end
    self.m_Vehicle:setDamageProof(false)
    self.m_Vehicle:setAlpha(255)
  end, 3000, 1)

  -- Events
  addEventHandler("onClientVehicleDamage", self:getVehicle(), bind(self.onAttack, self))
end

function Sweeper:destructor()
  SuperS.SweeperManager:getSingleton():removeRef(self)
  if self.m_Weapon then
    delete(self.m_Weapon)
  end
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

-- "Export" to SuperS
SuperS.Sweeper = Sweeper
