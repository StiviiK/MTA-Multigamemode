local Border = inherit(Object)

function Border:constructor(...)
  self.m_ColRectangle = ColShape.Rectangle(...)
  self.m_ColRectangle:setDimension(SuperS:getInstance():getDimension())

  -- Event Zone
  addEventHandler("onColShapeLeave", self.m_ColRectangle, bind(self.Event_OnColShapeLeave, self))
end

function Border:destructor()
  if isElement(self.m_ColRectangle) then
    destroyElement(self.m_ColRectangle)
  end
end

function Border:Event_OnColShapeLeave(hitelement, matchingDimension)
  if hitelement:getType() == "player" and matchingDimension then
    local sweeper = hitelement:isInVehicle() and hitelement:getOccupiedVehicle() or false
    if not sweeper then return end

    if SuperS.SweeperManager:getSingleton():isSweeper(sweeper) then
      local velocity = sweeper:getVelocity()
      --if hitelement:getRank() >= RANK.Administrator then
      --  sweeper:setVelocity(-(velocity.x*10), -(velocity.y*10), 0.3)
      --  sweeper:setTurnVelocity(0, 0, 0.06)
      --else
        sweeper:setVelocity(-(velocity.x*0.9), -(velocity.y*0.9), 0.3)
        sweeper:setTurnVelocity(0, 0, 0.06)
      --end
    end
  end
end

-- "Export" to SuperS
SuperS.Border = Border
