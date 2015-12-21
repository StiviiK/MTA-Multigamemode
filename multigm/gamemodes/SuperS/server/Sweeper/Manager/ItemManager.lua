local ItemManager = inherit(Singleton)
ITEM_POSITIONS = {
  Vector3(-1993.81, 924.65, 45.3),
  Vector3(-1899.92, 924.91, 35.02),
  Vector3(-1884.5, 1052.85, 45.3),
  Vector3(-1898.96, 845.71, 35.02),
  Vector3(-2004.31, 845.34, 45.3),
  Vector3(-2004.16, 732.43, 45.52),
  Vector3(-1899.57, 731.37, 45.3),
  Vector3(-1794.11, 845.43, 24.73),
  Vector3(-1794.32, 924.88, 24.74),
  Vector3(-1794.38, 1102.34, 45.3),
  Vector3(-1884.08, 1103.38, 45.3),
  Vector3(-1884.29, 1175.68, 45.3),
  Vector3(-1796.37, 1186.37, 24.98),
  Vector3(-1714.04, 925.11, 24.74),
  Vector3(-1714.14, 845.89, 24.73),
  Vector3(-1714.07, 731.58, 24.73),
  Vector3(-1552.03, 731.42, 7.04),
  Vector3(-1546.31, 844.67, 7.03),
  Vector3(-1529.34, 923.84, 7.05),
  Vector3(-1610.83, 1187.3, 7.04),
  Vector3(-1708.48, 1308.45, 7.04),
  Vector3(-1965.22, 1176.57, 45.3),
  Vector3(-2143.15, 1176.64, 55.58),
  Vector3(-2260.45, 1176.21, 55.59),
  Vector3(-2044.82, 1295.94, 7.18),
  Vector3(-2142.93, 1093.51, 79.85),
  Vector3(-2260.94, 1093.48, 79.86),
  Vector3(-2261.13, 1020.09, 83.65),
  Vector3(-2260.61, 958.36, 66.53),
  Vector3(-2261.12, 918.56, 66.5),
  Vector3(-2260.88, 808.23, 49.3),
  Vector3(-2261.03, 731.32, 49.3),
  Vector3(-2143.28, 731.19, 69.41),
  Vector3(-2143.29, 808.37, 69.41),
  Vector3(-2088.3, 731.54, 69.41),
  Vector3(-2003.98, 808.22, 45.58),
  Vector3(-2143.17, 918.26, 79.85),
  Vector3(-2143.05, 1020.03, 79.85),
  Vector3(-2004.78, 1055.26, 55.57),
  Vector3(-1966.98, 1076.25, 55.57),
  Vector3(-1714.11, 1103.52, 45.3),
  Vector3(-1714.22, 1186.41, 24.98),
}

function ItemManager:constructor()
  self.m_Items = {}
  self.m_PickupHandler = bind(self.Event_OnPickupHit, self)
  self.m_ItemChangeTimer = setTimer(function ()
    for i, v in pairs(self.m_Items) do
      self:changePickup(i, ItemManager.getRandomType())
    end
  end, 60*1000, -1)

  -- Spawn the pickups
  self:spawnItems()
end

function ItemManager:destructor()
  if isTimer(self.m_ItemChangeTimer) then
    killTimer(self.m_ItemChangeTimer)
  end

  for i, v in pairs(self.m_Items) do
    self:destroyPickup(i)
  end
end

function ItemManager.getRandomType()
  if chance(50) then
    return SUPERS_ITEM_TYPE_BOOST
  elseif chance(50) then
    return SUPERS_ITEM_TYPE_JUMP
  elseif chance(50) then
    return SUPERS_ITEM_TYPE_REPAIR
  elseif chance(25) then
    return SUPERS_ITEM_TYPE_ROCKET
  elseif chance(25) then
    return SUPERS_ITEM_TYPE_WEAPON
  elseif chance(25) then
    return SUPERS_ITEM_TYPE_MAGICCHEST
  end

  return SUPERS_ITEM_TYPE_NOTHING
end

function ItemManager:spawnItems()
  for i, v in pairs(ITEM_POSITIONS) do
    self:createPickup(i, v, ItemManager.getRandomType())
  end
end

function ItemManager:createPickup(index, pos, ItemType)
  self.m_Items[index] = {}
  local model = 1337
  local weaponId = 0

  if ItemType == SUPERS_ITEM_TYPE_BOOST then -- 25% (25%)
    model = 2977
  elseif ItemType == SUPERS_ITEM_TYPE_JUMP then -- 25% (50%)
    model = 2977
  elseif ItemType == SUPERS_ITEM_TYPE_REPAIR then -- 25% (75%)
    model = 2977
  elseif ItemType == SUPERS_ITEM_TYPE_ROCKET then -- 10% (85%)
    model = 359
  elseif ItemType == SUPERS_ITEM_TYPE_WEAPON then -- 7.5% (92.5%)
    local weapon = table.random(WEAPONS)
    model = weapon.Model
    weaponId = weapon.Id
  elseif ItemType == SUPERS_ITEM_TYPE_MAGICCHEST then -- 7.5% (100%)
    model = 980
  elseif ItemType == SUPERS_ITEM_TYPE_NOTHING then -- create no item
    model = 1337
  end

  self.m_Items[index].Item = SuperS.Sweeper.Item:new(ItemType, weaponId)
  self.m_Items[index].Pickup = createPickup(pos, 3, model, 99999999)
  self.m_Items[index].Pickup:setDimension(SuperS:getInstance():getDimension())
  self.m_Items[index].Pickup.index = index
  self.m_Items[index].Position = pos

  -- Add EventHandler
  addEventHandler("onPickupHit", self.m_Items[index].Pickup, self.m_PickupHandler)
end

function ItemManager:destroyPickup(index)
  if not self.m_Items[index] then return end
  local Item = self.m_Items[index]
  if isElement(Item.Pickup) then
    destroyElement(Item.Pickup)
  end
  if Item.Item then
    delete(Item.Item)
  end

  self.m_Items[index] = nil
end

function ItemManager:changePickup(index, ItemType)
  if not self.m_Items[index] then return end
  if not isElement(self.m_Items[index].Pickup) then return end
  local item = self.m_Items[index]
  local model = 1337
  local weaponId = 0

  if ItemType == SUPERS_ITEM_TYPE_BOOST then -- 25% (25%)
    model = 2977
  elseif ItemType == SUPERS_ITEM_TYPE_JUMP then -- 25% (50%)
    model = 2977
  elseif ItemType == SUPERS_ITEM_TYPE_REPAIR then -- 25% (75%)
    model = 2977
  elseif ItemType == SUPERS_ITEM_TYPE_ROCKET then -- 10% (85%)
    model = 359
  elseif ItemType == SUPERS_ITEM_TYPE_WEAPON then -- 7.5% (92.5%)
    local weapon = table.random(WEAPONS)
    model = weapon.Model
    weaponId = weapon.Id
  elseif ItemType == SUPERS_ITEM_TYPE_MAGICCHEST then -- 7.5% (100%)
    model = 980
  elseif ItemType == SUPERS_ITEM_TYPE_NOTHING then -- create no item
    model = 1337
  end

  self.m_Items[index].Item:setType(ItemType, weaponId)
  self.m_Items[index].Pickup:setType(3, model)
end

function ItemManager:Event_OnPickupHit(hitElement)
  if hitElement:getType() == "player" and type(hitElement.m_SweeperId) == "number" then
    local index = source.index
    local sweeper = SuperS.SweeperManager.getFromId(hitElement.m_SweeperId)
    if sweeper and self.m_Items[index] then
      local pickup = self.m_Items[index]
      sweeper:addItem(pickup.Item)

      -- Debug
      outputDebug(("[SuperS] %s picked up an Item: %s (%s)"):format(hitElement:getName(), pickup.Item.m_Type, resolveError(pickup.Item.m_Type)))
      outputConsole(("[SuperS] You picked up an Item: %s (%s)"):format(pickup.Item.m_Type, resolveError(pickup.Item.m_Type)), hitElement)
      outputChatBox(("[SuperS] You picked up an Item: %s"):format(pickup.Item.m_Type, resolveError(pickup.Item.m_Type)), hitElement)

      -- Set respawn delay
      setTimer(function ()
        self:createPickup(index, pickup.Position, ItemManager.getRandomType())
      end, 60*1000, 1)

      -- Destroy the pickup
      self:destroyPickup(index)
    end
  end
end


-- "Export" to SuperS
SuperS.Sweeper.ItemManager = ItemManager
