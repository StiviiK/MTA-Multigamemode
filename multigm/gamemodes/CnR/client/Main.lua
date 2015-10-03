lp = getLocalPlayer()

function outputMyPosition()
local x,y,z = getElementPosition(lp)
local rx,ry,rz = getElementRotation(lp)
outputChatBox("--Position: "..x..","..y..","..z)
outputChatBox("--Rotation: "..rx..","..ry..","..rz)
end
addCommandHandler("omp",outputMyPosition)

-----------------------------------------------




function CopsnRobbers:constructor()
  --outputDebug("Lobby:constructor")
  addRemoteEvents{"onCNRStartDownload"}
  addEventHandler("onCNRStartDownload", root, bind(CopsnRobbers.onDownloadStart, self))

   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))

  -- Load custom Arrow
  EngineCOL("gamemodes/CnR/files/col/EntranceMarker.col"):replace(1318)
  EngineDFF("gamemodes/CnR/files/dff/EntranceMarker.dff", 0):replace(1318)
  EngineTXD("gamemodes/CnR/files/txd/EntranceMarker.txd"):import(1318)
end

function CopsnRobbers:destructor()
  -- Restore custom Arrow
  Engine.restoreCOL(1318)
  Engine.restoreModel(1318)
end

function CopsnRobbers:onGamemodesLoaded(numLoadedGamemodes)
  -- Create Gamemode Ped (in Lobby)
  GamemodePed:new(0, Vector3(1713.793, -1655.604, 20.222), Vector3(0, 0, -90), 12, GamemodeManager.getFromId(1):getSetting("Spawn").Interior, self)
end

function CopsnRobbers:onPlayerJoin()
self:CreatePlayerBlip()
FractionSelectionMenu:new()
HudComponentVisible(true)
end

function CopsnRobbers:CreatePlayerBlip()
if lp == source then return end
 source.MapBlip = createBlip( 0, 0, 0 )
 source.MapBlip:setDimension(CNR_DIM)
end

function CopsnRobbers:onPlayerLeft()
 source.MapBlip:destroy()
 HudComponentVisible(false)
end

function CopsnRobbers:onDownloadStart()
  Provider:getSingleton():requestFile(CNR_DOWNLOAD_FILE, bind(CopsnRobbers.onDownloadFinish, self))
end

function CopsnRobbers:onDownloadFinish()
  triggerServerEvent("onCNRDownloadFinished", localPlayer)
end


function HudComponentVisible(State)
setPlayerHudComponentVisible (  "all", State )
end
