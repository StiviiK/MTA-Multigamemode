local Sweeper = inherit(Object)

function Sweeper:constructor(Id, owner, vehicle, sweeperTexture)
  self.m_Id = Id
  self.m_Owner = owner
  self.m_Vehicle = vehicle
  self.m_Weapon = SuperS.Sweeper.Weapon:new(self, 23)
  self.m_Shader = SuperS.Shader:new("gamemodes/SuperS/res/shader/swap.fx")
  self.m_Shader:setTexture(sweeperTexture or "gamemodes/SuperS/res/images/Logos/default.png")
  self.m_Shader:applyShaderValue("swap")
  self.m_Shader:applyToWorldTexture("sweeper92decal128", self:getVehicle())

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
  local driver = source:getController()
  if attacker ~= nil and driver == localPlayer then
    if attacker ~= driver then
      if attacker:getType() == "weapon" then -- Convert attacker (if it is the weapon) to a player
        attacker = attacker.m_Sweeper:getOwner():getId()
      elseif attacker:getType() == "player" then
        attacker = attacker:getId()
      end
      if type(attacker) == "number" then
        triggerServerEvent("onSweeperAttack", root, SuperS.SweeperManager.getFromVehicle(source):getId(), attacker)
      end
    end
  end
end

-- "Export" to SuperS
SuperS.Sweeper = Sweeper
