-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  FILE:        client/classes/Gamemode/GamemodePedManager.lua
-- *  PURPOSE:     GamemodePedManager class
-- *
-- ****************************************************************************
GamemodePedManager = inherit(Singleton)
GamemodePedManager.Map = {}

function GamemodePedManager:constructor()
  -- Draw Ped Nametags
  addEventHandler("onClientRender", root, bind(self.Event_DrawNametags, self))
end

function GamemodePedManager:destructor()
  for i, v in pairs(GamemodePedManager.Map) do
    delete(v)
  end
end

function GamemodePedManager:addRef(ref)
  return table.push(GamemodePedManager.Map, ref)
end

function GamemodePedManager:removeRef(ref)
  GamemodePedManager.Map[ref:getId()] = nil
end

function GamemodePedManager.getFromId(Id)
  return GamemodePedManager.Map[Id]
end

function GamemodePedManager:Event_DrawNametags()
  if localPlayer:getGamemode() == GamemodeManager.getFromId(1) then
    if localPlayer:getDimension() == GamemodeManager.getFromId(1):getDimension() then
      for i, v in pairs(GamemodePedManager.Map) do
        local ped = v.m_Ped
        local lx, ly, lz = localPlayer:getBonePosition(8)
        local x, y, z = ped:getBonePosition(8)
        if getDistanceBetweenPoints3D(lx, ly, lz + 1, x, y, z + 1) <= 5 then
          if isLineOfSightClear(x, y, z, lx, ly, lz, true, true, false, true, true, false, false, nil) then
            local x1, y1 = getScreenFromWorldPosition(x, y, z + 0.5)
            if x1 and y1 then
              local gamemode = v:getGamemode()
              dxDrawText(("%s %s\n(%d / %d)"):format(FontAwesomeSymbols.Gamepad, gamemode:getName(), gamemode:getSyncInfo("CurrPlayers"), gamemode:getSyncInfo("MaxPlayers")), x1, y1, x1, y1, Color.White, 1, FontAwesome(30), "center")
            end
          end
        end
      end
    end
  end
end
