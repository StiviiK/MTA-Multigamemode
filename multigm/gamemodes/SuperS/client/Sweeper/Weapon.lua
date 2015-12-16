local Weapon = inherit(Object)

function Weapon:constructor(sInstance, Id)
  self.m_Sweeper = sInstance
  self.m_WeaponId = Id
  self.m_OffSet = WEAPONS[self.m_WeaponId] -- Scheiß auf den namen :P
  self.m_Name = WEAPONS[self.m_WeaponId].Name
  self.m_Weapon = createWeapon(self.m_WeaponId, 0, 0, 0)
  self.m_Weapon:setProperty("fire_rotation", Vector3(self.m_OffSet.fx, self.m_OffSet.fy, self.m_OffSet.fz))
  self.m_Weapon:setDimension(SuperS:getInstance():getDimension())
  self.m_Weapon.m_Sweeper = self.m_Sweeper

  -- Attach to the Sweeper
  self:applyToSweeper()
end

function Weapon:destructor()
  if self.m_Weapon:getState() == WEAPON_STATE_FIRING then -- Check this to avoid bugs
    self:stopFire()
  end

  if self.m_Weapon then
    destroyElement(self.m_Weapon)
  end
end

function Weapon:startFire()
  if self.m_Weapon:getState() == WEAPON_STATE_RELOADING and getVehicleController(self.m_Sweeper:getVehicle()) == localPlayer then
    outputChatBox("Your Weapon have to reload!")
  else
    self.m_Weapon:setState(WEAPON_STATE_FIRING)
  end
end

function Weapon:stopFire()
  self.m_Weapon:setState(WEAPON_STATE_READY)
end

function Weapon:applyToSweeper()
  attachElements(self.m_Weapon, self.m_Sweeper:getVehicle(), self.m_OffSet.x, self.m_OffSet.y, self.m_OffSet.z, self.m_OffSet.rx, self.m_OffSet.ry, self.m_OffSet.rz)
end

-- "Export" to SuperS.Sweeper
SuperS.Sweeper.Weapon = Weapon
