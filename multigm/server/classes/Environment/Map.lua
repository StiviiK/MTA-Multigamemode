Map = inherit(Object)

function Map:constructor(gamemode, objects, int)
  self.m_Id = MapManager:getSingleton():addRef(self)
  self.m_Gamemode = gamemode
  self.m_LoadedObjects = objects
  self.m_CreatedObjects = {}
  self.m_Interior = int or 0
  self.m_Thread = false
end

function Map:destructor()
  self:unload()
end

function Map:load(priority)
  if self:getThread() then return end
  if not priority then priority = MAP_LOADING_NORMAL end

  self.m_Thread = Thread:new(bind(Map.AsyncCreateObjects, self))
  if priority == MAP_LOADING_FAST then
    self:getThread():setPriority(THREAD_PRIORITY_HIGHEST)
  elseif priority == MAP_LOADING_NORMAL then
    self:getThread():setPriority(THREAD_PRIORITY_HIGH)
  end
  self:getThread():start(ptiority)
end

function Map:unload()
  if self:getThread() then return end
  self.m_Thread = Thread:new(bind(Map.removeObjects, self))
  self:getThread():setPriority(THREAD_PRIORITY_HIGHEST)
  self:getThread():start()
end

function Map:AsyncCreateObjects(piority)
  for i = 1, #self.m_LoadedObjects, 1 do
    local v = self.m_LoadedObjects[i]
    if v.doublesided == nil then v.doublesided = false end
    if v.scale == nil then v.scale = 1 end

    local obj = createObject(v.model, v.position, v.rotation)
    obj:setDimension(self.m_Gamemode:getDimension())
    obj:setID(v.id)
    obj:setAlpha(v.alpha)
    obj:setDoubleSided(v.doublesided)
    obj:setScale(v.scale)
    obj:setCollisionsEnabled(v.collisions)
    table.insert(self.m_CreatedObjects, obj)

    if piority == MAP_LOADING_FAST then
      if i % MAP_STOP_FAST == 0 then
        Thread.pause()
      end
    elseif piority == MAP_LOADING_NORMAL then
      if i % MAP_STOP_NORMAL == 0 then
        Thread.pause()
      end
    end
  end

  self.m_Thread = nil
end

function Map:removeObjects()
  for i = 1, #self.m_CreatedObjects, 1 do
    self.m_CreatedObjects[i]:destroy()
    if i % 500 == 0 then
      Thread.pause()
    end
  end

  self.m_Thread = nil
end

-- Short getters
function Map:getId() return self.m_Id end
function Map:getThread() return self.m_Thread end
