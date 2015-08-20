Map = inherit(Object)

function Map:constructor(gamemode, objects, int)
  self.m_Id = MapManager:getSingleton():addRef(self)
  self.m_Gamemode = gamemode
  self.m_LoadedObjects = objects
  self.m_CreatedObjects = {}
  self.m_Dimension = gamemode:getDimension()
  self.m_Interior = int or 0
  self.m_Loaded = false
  self.m_Thread = false
end

function Map:destructor()
  self:unload()
end

function Map:load(piority)
  if self:getThread() then return end
  if not piority then piority = MAP_LOADING_NORMAL end

  self.m_Thread = Thread:new(bind(Map.AsyncCreateObjects, self))
  if piority == MAP_LOADING_FAST then
    self:getThread():setPiority(THREAD_PIORITY_HIGHEST)
  elseif piority == MAP_LOADING_NORMAL then
    self:getThread():setPiority(THREAD_PIORITY_HIGH)
  end

  local startTime = getTickCount()
  outputDebug(("[MapManager] Starting loading Map Id: %d... (%d Objects)"):format(self:getId(), #self.m_LoadedObjects))
  self:getThread():start(piority, startTime)
end

function Map:unload()
  if self:getThread() then return end
  self.m_Thread = Thread:new(bind(Map.removeObjects, self))
  self:getThread():setPiority(THREAD_PIORITY_HIGHEST)
  self:getThread():start()
  --self:removeObjects()
end

function Map:AsyncCreateObjects(piority, startTime)
  local tmpCounter
  if piority == MAP_LOADING_FAST then
    tmpCounter = 0
  end

  for i, v in ipairs(self.m_LoadedObjects) do
    local obj = createObject(v.model, Vector3(v.posX, v.posY, v.posZ), Vector3(v.rotX, v.rotY, v.rotZ))
    obj:setDimension(self.m_Dimension)
    obj:setID(v.id)
    obj:setAlpha(v.alpha)
    obj:setDoubleSided(v.doublesided)
    obj:setScale(v.scale)
    obj:setCollisionsEnabled(v.collisions)
    table.insert(self.m_CreatedObjects, obj)

    if piority == MAP_LOADING_FAST then
      tmpCounter = tmpCounter + 1
      if tmpCounter == 500 then
        tmpCounter = 0
        Thread.pause()
      end
    elseif piority == MAP_LOADING_NORMAL then
      Thread.pause()
    end
  end

  outputDebug(("[MapManager] Finished loading Map Id: %d. (Took: %dms)"):format(self:getId(), getTickCount()-startTime))
  self.m_Thread = nil
end

function Map:removeObjects()
  for i, v in ipairs(self.m_CreatedObjects) do
    --outputDebug(("[MapManager] Removing Object for Map Id: %d (Id: %s)"):format(self:getId(), v:getID()))

    v:destroy()
    --Thread.pause()
  end
end

-- Short getters
function Map:getId() return self.m_Id end
function Map:getThread() return self.m_Thread end
