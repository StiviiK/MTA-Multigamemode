lp = getLocalPlayer()

function outputMyPosition()
local x,y,z = getElementPosition(lp)
local rx,ry,rz = getElementRotation(lp)
outputChatBox("--Position: "..x..","..y..","..z)
outputChatBox("--Rotation: "..rx..","..ry..","..rz)
end
addCommandHandler("omp",outputMyPosition)

function outputMyMatrix()
outputChatBox(("--Matrix: %s , %s , %s , %s , %s , %s "):format(getCameraMatrix ()))
end
addCommandHandler("omm",outputMyMatrix)

-----------------------------------------------




function CopsnRobbers:constructor()
--Handler--
  addRemoteEvents{"onCNRStartDownload","CreateFractionSelectMenu","ShowRadar","HideRadar","CreatePlayerBlip","DestroyPlayerBlip","CreateMoneyDeliveryCheckpoint","addEventOnPlayerClickPed","removeEventOnPlayerClickPed"}
  addEventHandler("onCNRStartDownload", root, bind(CopsnRobbers.onDownloadStart, self))
  addEventHandler("CreateFractionSelectMenu", root, bind(CopsnRobbers.CreateFractionSelectMenu, self))
  addEventHandler("ShowRadar", root, bind(CopsnRobbers.ShowRadar, self))
  addEventHandler("HideRadar", root, bind(CopsnRobbers.HideRadar, self))

  addEventHandler("CreatePlayerBlip" , root, bind(CopsnRobbers.CreatePlayerBlip, self))
  addEventHandler("DestroyPlayerBlip", root, bind(CopsnRobbers.DestroyPlayerBlip, self))

  addEventHandler("addEventOnPlayerClickPed"    , root, bind(CopsnRobbers.addEventOnPlayerClickPed, self))
  addEventHandler("removeEventOnPlayerClickPed" , root, bind(CopsnRobbers.removeEventOnPlayerClickPed, self))
  
  addEventHandler("CreateMoneyDeliveryCheckpoint" , root, bind(CopsnRobbers.CreateMoneyDeliveryCheckpoint, self))
 ----------

   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))


-----------CNR_DEBUG---------------
 -- DebugOutPut( "CopsnRobbers:constructor" )
-----------------------------------


end

function CopsnRobbers:destructor()
-----------CNR_DEBUG---------------
 -- DebugOutPut( "CopsnRobbers:destructor" )
-----------------------------------
end

function CopsnRobbers:onPlayerJoin()
--Handler--
		self.TazerDamageEventHandler = function(...) self:TazerDamage(...) end
		addRemoteEvents{"onClientPlayerDamage"}
		addEventHandler("onClientPlayerDamage", source, self.TazerDamageEventHandler)
-----------

self:CreateAllPlayerBlip (source)
MiniMap:new():hide()

self:CreateWeaponSelectionEvent ()
self:ShopGUI_Event ()

	---------------------------CNR_DEBUG------------------------------------
				if CNR_DEBUG then

					for i = 1,10 do
					outputChatBox("\n",tocolor(0,255,0))

					end
					outputChatBox("### CNR_DEBUG Enabled ###",tocolor(0,255,0))
					outputDebugString("------------------------------------------------------------------------------------------------------------------------------")
				end
	-----------------------------------------------------------------------

	-----------CNR_DEBUG---------------
 -- DebugOutPut( "CopsnRobbers:onPlayerJoin" )
-----------------------------------

  -- Change HelpBar Text
  HelpBar:getSingleton():setText(HelpTexts.Gamemodes.CnR)
end


function CopsnRobbers:onPlayerSelectTeam(Team,Skin,SelectID)
	MiniMap:getSingleton():show()
end


function CopsnRobbers:ShowRadar()
	MiniMap:getSingleton():show()
end

function CopsnRobbers:HideRadar()
	MiniMap:getSingleton():hide()
end





function CopsnRobbers:onPlayerLeft()
--Handler--
   removeEventHandler("onClientPlayerDamage", source, self.TazerDamageEventHandler)
-----------

--Destroy--
self:DestroyPlayerBlip(source)
self:DestroyAllPlayerBlip()
self:DestroyMoneyDeliveryCheckpoint(source)
-----------


-----------CNR_DEBUG---------------
-- DebugOutPut( "CopsnRobbers:onPlayerLeft" )
-----------------------------------

 HudComponentVisible(false)
 -- Delete Fraction Selection Menu

	if self.FractionSelectionMenu and not CNR_DEBUG then
	self.FractionSelectionMenu:delete ()
	end
 -- Restore custom Arrow
	Engine.restoreCOL(1318)
	Engine.restoreModel(1318)
 -- Hide Radar
	self:DestroyWeaponSelection ()
	MiniMap:getSingleton():hide()
	self.ShopGUI_destructor()
--Robbery
	self:DestroyMoneyDeliveryCheckpoint(source)
end

function CopsnRobbers:onDownloadStart()
-----------CNR_DEBUG---------------
 -- DebugOutPut( "CopsnRobbers:onDownloadStart" )
-----------------------------------

  Provider:getSingleton():requestFile(CNR_DOWNLOAD_FILE, bind(CopsnRobbers.onDownloadFinish, self))
end

function CopsnRobbers:onDownloadFinish()
-----------CNR_DEBUG---------------
 -- DebugOutPut( "CopsnRobbers:onDownloadFinish" )
-----------------------------------
  triggerServerEvent("onCNRDownloadFinished", localPlayer)

  -- Load custom Arrow
  -- EngineCOL("gamemodes/CnR/res/col/EntranceMarker.col"):replace(1318)
  -- EngineTXD("gamemodes/CnR/res/txd/EntranceMarker.txd"):import(1318)
  -- EngineDFF("gamemodes/CnR/res/dff/EntranceMarker.dff", 0):replace(1318)
  HudComponentVisible(true)
end


function HudComponentVisible(State)
setPlayerHudComponentVisible (  "all", State )
setPlayerHudComponentVisible (  "radar", false )
setPlayerHudComponentVisible (  "radio", false )
setPlayerHudComponentVisible (  "area_name", false )
setPlayerHudComponentVisible (  "vehicle_name", false )
end
