local Weapon = inherit(Object)
WEAPONS = {
  [22] = {Name="colt 45", x=0, y=1.7, z=0, rx=0, ry=10, rz=90, fx=0, fy=-10, fz=0},
  [23] = {Name="silenced", x=0, y=1.7, z=0, rx=0, ry=10, rz=90, fx=0, fy=-10, fz=0},
  [24] = {Name="deagle", x=0, y=1.6, z=0, rx=0, ry=5, rz=95, fx=0, fy=-4, fz=-5},
  [28] = {Name="uzi", x=0, y=1.6, z=0, rx=0, ry=5, rz=93, fx=0, fy=-5, fz=-3},
  [29] = {Name="mp5", x=0, y=1.5, z=0, rx=0, ry=10, rz=90, fx=0, fy=-10, fz=0},
  [30] = {Name="ak-47", x=0, y=1.6, z=0, rx=0, ry=5, rz=93, fx=0, fy=-5, fz=-3},
  [31] = {Name="m4", x=0, y=1.6, z=0, rx=0, ry=5, rz=93, fx=0, fy=-5, fz=-3},
  [32] = {Name="tec-9", x=0, y=1.6, z=0, rx=0, ry=5, rz=93, fx=0, fy=-5, fz=-3},
  [38] = {Name="minigun", x=0, y=1.4, z=0, rx=-3, ry=30, rz=93, fx=0, fy=-30, fz=-3},
}

function Weapon:constructor(sInstance, Id)
  self.m_Sweeper = sInstance
  self.m_WeaponId = Id
  self.m_OffSet = WEAPONS[self.m_WeaponId] -- Scheiß auf den namen :P
  self.m_Name = WEAPONS[self.m_WeaponId].Name
  self.m_Weapon = createWeapon(self.m_WeaponId, 0, 0, 0)
  self.m_Weapon:setProperty("fire_rotation", Vector3(self.m_OffSet.fx, self.m_OffSet.fy, self.m_OffSet.fz))
  self.m_Weapon:setDimension(SuperS.getInstance():getDimension())
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
  if self.m_Weapon:getState() == WEAPON_STATE_RELOADING --[[and getVehicleController(self.m_Sweeper:getVehicle() [Maybe so? TODO: Fix later) == localPlayer]] then

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
