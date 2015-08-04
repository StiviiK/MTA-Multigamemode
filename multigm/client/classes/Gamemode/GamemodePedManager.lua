GamemodePedManager = inherit(Singleton)
GamemodePedManager.Map = {}

function GamemodePedManager:constructor()
  self.m_renderThis = bind(GamemodePedManager.drawThis, self)
  addEventHandler("onClientRender", root, self.m_renderThis)
end

function GamemodePedManager:destructor()
  for i, v in pairs(GamemodePedManager.Map) do
    delete(v)
  end

  removeEventHandler("onClientRender", root, self.m_renderThis)
end

function GamemodePedManager:addRef(ref)
  local Id = #GamemodePedManager.Map + 1
  GamemodePedManager.Map[Id] = ref

  return Id
end

function GamemodePedManager:removeRef(ref)
  GamemodePedManager.Map[ref:getId()] = nil
end

function GamemodePedManager.getFromId(Id)
  return GamemodePedManager.Map[Id]
end

function GamemodePedManager:drawThis()
  for i, v in pairs(GamemodePedManager.Map) do
    v.m_Ped:setHealth(1000)

    local pX, pY, pZ = v.m_Ped:getBonePosition(8)
    if isLineOfSightClear(getCamera():getPosition(), pX, pY, pZ + 0.5) then
      local sX, sY = getScreenFromWorldPosition(pX, pY, pZ + 0.5)
    end
  end
end
