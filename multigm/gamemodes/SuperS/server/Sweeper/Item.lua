local Item = inherit(Object)

function Item:constructor(type, ...)
  self.m_Type = type
  self.m_Args = {...}
end

function Item:destructor()
end

function Item:use(sweeperInstance)
  if self.m_Type == SUPERS_ITEM_TYPE_BOOST then
    return setElementSpeed(sweeperInstance:getVehicle(), "km/h", getElementSpeed(sweeperInstance:getVehicle(), "km/h") + 100 )
  elseif self.m_Type == SUPERS_ITEM_TYPE_JUMP then
    local vx,vy,vz = getElementVelocity(sweeperInstance:getVehicle())
    return setElementVelocity(sweeperInstance:getVehicle(), vx, vy, vz + 0.3)
  elseif self.m_Type == SUPERS_ITEM_TYPE_REPAIR then
    return sweeperInstance:getVehicle():setHealth(1000)
  elseif self.m_Type == SUPERS_ITEM_TYPE_ROCKET then
    triggerClientEvent(root, "fireSweeperRocket", root, sweeperInstance:getId())
  elseif self.m_Type == SUPERS_ITEM_TYPE_WEAPON then
    sweeperInstance:changeWeapon(self.m_Args[1])
  end
end


-- "Export" to SuperS
SuperS.Sweeper.Item = Item
