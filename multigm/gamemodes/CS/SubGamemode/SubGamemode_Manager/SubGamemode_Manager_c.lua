SubGamemodeManager = inherit(Singleton)
SubGamemodeManager.Map = {}

function SubGamemodeManager:constructor(MainGamemode)
  addRemoteEvents{"onPlayerSubGamemodeJoin", "onPlayerSubGamemodeLeft", "onSubGamemodeDestruct", "UpdateSubGamemodeSync", "RespawnSubGamemodePed", "DeleteSubGamemodePed"}
  addEventHandler("onPlayerSubGamemodeJoin", root, bind(SubGamemodeManager.Event_OnPlayerSubGamemodeJoin, self))
  addEventHandler("onPlayerSubGamemodeLeft", root, bind(SubGamemodeManager.Event_OnPlayerSubGamemodeLeft, self))
  addEventHandler("onSubGamemodeDestruct", root, bind(SubGamemodeManager.Event_OnSubGamemodeDestruct, self))
  addEventHandler("UpdateSubGamemodeSync", root, bind(SubGamemodeManager.Event_UpdateSubGamemodeSync, self))
  -- addEventHandler("RespawnSubGamemodePed", root, bind(SubGamemodeManager.Event_RespawnSubGamemodePed, self))
  -- addEventHandler("DeleteSubGamemodePed", root, bind(SubGamemodeManager.Event_DeleteSubGamemodePed, self))

  local SubGamemodes = {
    self:addRef(CS_Deathmath:new(Color.Orange):setId(1));
  }
  for k, v in ipairs(SubGamemodes) do
    if v.onSubGamemodesLoaded then
      v:onSubGamemodesLoaded(#SubGamemodes)
    end
  end
end

function SubGamemodeManager:destructor()
  for i, v in pairs(SubGamemodeManager.Map) do
    delete(v)
  end
end

function SubGamemodeManager.getFromId(Id)
  return SubGamemodeManager.Map[Id]
end

function SubGamemodeManager:addRef(ref)
  SubGamemodeManager.Map[ref:getId()] = ref
  return ref
end

function SubGamemodeManager:removeRef(ref)
  SubGamemodeManager.Map[ref:getId()] = nil
end

function SubGamemodeManager:Event_OnPlayerSubGamemodeJoin(Id)

  local SubGamemode = self.getFromId(Id)
  if SubGamemode then
    SubGamemode:onPlayerJoin(source)
  end
end

function SubGamemodeManager:Event_OnPlayerSubGamemodeLeft(Id)
  local SubGamemode = self.getFromId(Id)
  if SubGamemode then
    SubGamemode:onPlayerLeft(source)
  end
end

function SubGamemodeManager:Event_OnSubGamemodeDestruct(Id)
  local SubGamemode = self.getFromId(Id)
  if SubGamemode then
    delete(SubGamemode)
  end
end

function SubGamemodeManager:Event_UpdateSubGamemodeSync(SyncInfo)
  for Id, data in pairs(SyncInfo) do
    local SubGamemode = self.getFromId(Id)
    if SubGamemode then
      for k, v in pairs(data or {}) do
        SubGamemode.m_SyncInfo[k] = v

        local f = SubGamemode.m_SyncChangeHandler[k]
        if f then f(v) end
      end
    end
  end
end

function SubGamemodeManager:Event_RespawnSubGamemodePed(Id)
  -- if SubGamemodePedManager.getFromId(Id) then
    -- local instance = SubGamemodePedManager.getFromId(Id)
    -- local m, p, r, d, i, g, c = instance:getModel(), instance:getPosition(), instance:getRotation(), instance:getDimension(), instance:getInterior(), instance:getSubGamemode(), instance:getCustomColor()

    -- delete(instance)
    -- self.getFromId(1).m_SubGamemodePeds[Id] = nil

    -- instance = SubGamemodePed:new(m, p, r, d, i, g, c)
    -- self.getFromId(1).m_SubGamemodePeds[instance:getId()] = instance
  -- end
end

function SubGamemodeManager:Event_DeleteSubGamemodePed(Id)
  -- if SubGamemodePedManager.getFromId(Id) then
    -- delete(SubGamemodePedManager.getFromId(Id))
  -- end
end
