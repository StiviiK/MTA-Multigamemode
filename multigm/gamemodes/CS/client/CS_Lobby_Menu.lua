CS_Lobby_Menu = inherit(GUIForm)
inherit(Singleton, CS_Lobby_Menu)

local SelectGamemodeID = false

function CS_Lobby_Menu:constructor(CS_SELF)
  GUIForm.constructor(self, 0, 0, screenWidth, screenHeight)
  self.GamemodeImage = {}
  self.GamemodeRectangle = {}
  self.GamemodeLabel = {}
  self.GamemodeLabel2 = {}
  
  self.m_BackgroundUrl = "gamemodes/CS/res/images/cs_lobby_bg.jpg"
  self.m_Background = GUIImage:new(0, 0, self.m_Width, self.m_Height, self.m_BackgroundUrl, self)
  

  self.m_RoundedRect  = GUIRoundedRect:new(self.m_Width*0.03, self.m_Height*0.05, self.m_Width*0.6, self.m_Height*0.9, self.m_Background)
  self.m_RoundedRect2 = GUIRoundedRect:new(self.m_Width*0.65, self.m_Height*0.05, self.m_Width*0.32,    self.m_Height*0.9, self.m_Background)
  self:setBlendMode("overwrite")
  -- Max 3 in der Reihe 
  

  local GamemodeList = CS_GamemodeManager:getSingleton().Map
  local GamemodeLoadCount = 0
		for colum = 1, 3, 1 do
			  for row = 1, 3, 1 do
				GamemodeLoadCount = GamemodeLoadCount + 1 
				
				if GamemodeLoadCount <= #GamemodeList then
					self.GamemodeImagleUrl  = GamemodeList[GamemodeLoadCount]:get("GamemodeLobbyMenu_BG")
					self.GamemodeColor      = GamemodeList[GamemodeLoadCount]:get("GamemodeLobbyMenu_Color")
					self.GamemodeInfo       = GamemodeList[GamemodeLoadCount]:get("GamemodeLobbyMenu_Type") 
					self.GamemodePlayerInfo = "-1/10 Player"		
				else--if not gamemode
					self.GamemodeImagleUrl  = "gamemodes/CS/res/images/empty.png"
					self.GamemodeColor      = {255,0,0,100}
					self.GamemodeInfo       = "leer"
					self.GamemodePlayerInfo = ""
				end
				   self.GM_posX   = (self.m_Width*0.0625)+(self.m_Width*0.0625) * (row-1)*3
				   self.GM_posY   = 50+self.m_Height*0.11 + self.m_Height*0.11*(colum-1)*2
				   self.GM_width  = 250
				   self.GM_height = 150
				   self.GM_AnH    = self.m_Height*0.03
				  
				  
				  self.GamemodeImage[GamemodeLoadCount] = GUIImage:new(self.GM_posX, self.GM_posY, self.GM_width, self.GM_height, self.GamemodeImagleUrl,self )
				  self.GamemodeImage[GamemodeLoadCount].GamemodeID = GamemodeLoadCount	
				  
				  self.GamemodeImage[GamemodeLoadCount]["Info"] = GUIImage:new(self.GM_width-25, 0, 25, 25, "res/images/MessageBoxes/Info.png",self.GamemodeImage[GamemodeLoadCount] )
				  :setColor(tocolor(self.GamemodeColor[1],self.GamemodeColor[2],self.GamemodeColor[3],255))
				  self.GamemodeImage[GamemodeLoadCount]["Info"].GamemodeID = GamemodeLoadCount
				  
				  

				  self.GamemodeImage[GamemodeLoadCount].onLeftClick = function(element)--On Click Gamemode
						if GamemodeList[element.GamemodeID] then
							outputChatBox("Update Right Window")
							SelectGamemodeID = element.GamemodeID
							self:CreateRightWindow(CS_SELF,SelectGamemodeID)
						end
				  end
				  
				  
				 self.GamemodeImage[GamemodeLoadCount]["Info"].onHover = function(element)--On Hover Gamemode Info
				 outputChatBox("element.GamemodeID:"..element.GamemodeID)
						 if GamemodeList[element.GamemodeID] then
							outputDebugString("Gamemode Info Open")
							self:CreateInfoBar (element.GamemodeID)
						 end
					end
					
					
					
				self.GamemodeImage[GamemodeLoadCount]["Info"].onUnhover = function(element)--On Unhover Gamemode Info
						    outputDebugString("Gamemode Info Close")		
						    self:DeleteInfoBar ()
					end
				  
				  
				  self.GamemodeRectangle[GamemodeLoadCount] = GUIRectangle:new(0, self.GM_height-self.GM_AnH, self.GM_width, self.GM_AnH,tocolor(unpack(self.GamemodeColor)) , self.GamemodeImage[GamemodeLoadCount])
				  
				  self.GamemodeLabel[GamemodeLoadCount] = GUILabel:new(2, self.GM_height-self.GM_AnH, self.GM_width, self.GM_AnH, self.GamemodeInfo, self.GamemodeImage[GamemodeLoadCount])
				  :setAlignX("left")
				  
				  self.GamemodeLabel2[GamemodeLoadCount] = GUILabel:new(0, self.GM_height-self.GM_AnH, self.GM_width-2, self.GM_AnH, self.GamemodePlayerInfo, self.GamemodeImage[GamemodeLoadCount])
				  :setAlignX("right")
					
					
				
				end
			  end
		
self.CS_LobbyKeyBind = function(...) CS_SELF:CS_Lobby_MenuKeyBind(...) end		
bindKey("F3", "down",self.CS_LobbyKeyBind)
end 

function CS_Lobby_Menu:destructor()
outputChatBox("delete CS_Lobby_Menu")
GUIForm.destructor(self)
unbindKey("F3", "down",self.CS_LobbyKeyBind)
end

function CS:CS_Lobby_MenuKeyBind(key, keyState)

			CS_Lobby_Menu:getSingleton():toggle()

end



local RightWindow = false

function CS_Lobby_Menu:CreateRightWindow(CS_SELF,GamemodeID)
if RightWindow then delete(RightWindow) RightWindow = false end
RightWindow = GUIElement:new(0, 0, screenWidth, screenHeight, self)
	----Right Window---
	local GM_MAP_X,GM_MAP_Y,GM_MAP_W,GM_MAP_H = self.m_Width*0.68, self.m_Height*0.11, self.m_Width*0.25, self.m_Height*0.25
  self.GamemodeMapImage = GUIImage:new(GM_MAP_X,GM_MAP_Y,GM_MAP_W,GM_MAP_H, "res/images/backgrounds/rns/rns-bg.png", RightWindow)
  self.GamemodeMapRec   = GUIRectangle:new(self.m_Width*0.68, self.m_Height*0.11+GM_MAP_H-self.m_Height*0.04, self.m_Width*0.25, self.m_Height*0.04,tocolor(200,100,200,100) , RightWindow)
  self.GamemodeMapName  = GUILabel:new(self.m_Width*0.68, self.m_Height*0.11+GM_MAP_H-self.m_Height*0.04, self.m_Width*0.25, self.m_Height*0.04, "de_dust2", RightWindow)
	:setAlignX("center")	
	
	self.JoinButton = GUIButton:new(self.m_Width*0.68, self.m_Height*0.8, self.m_Width*0.25, self.m_Height*0.1, "Join Server", RightWindow)
	:setBackgroundColor(tocolor(200,100,200,100))
	:setBackgroundHoverColor(tocolor(250,150,250,100))
	:setHoverColor(tocolor(0,0,0))
	self.JoinButton.onLeftClick = function(element)
		if SelectGamemodeID then
			self:PutPlayerInToGM (tonumber(SelectGamemodeID))
		end
	end
	self.GamemodePlayerList = GUIGridList:new(self.m_Width*0.68, self.m_Height*0.4, self.m_Width*0.25, self.m_Height*0.35, RightWindow)
	self.GamemodePlayerList:setGridBackground(tocolor(25,25,25,100))
	
	self.GamemodePlayerList:addColumn("ID", 0.3)
	self.GamemodePlayerList:addColumn("Kills", 0.3)
    self.GamemodePlayerList:addColumn("Deaths", 0.3)
	for i = 1,10 do
	self.GamemodePlayerList:addItem("Piccolo", "10", "10")
	end
  --Karte,SpielerAnzahl,Gamemode,Spieler,punktestand

end

function CS_Lobby_Menu:CreateInfoBar (GM_ID)
self.InfoBox = {}
self.InfoBox.BG = GUIRectangle:new(0, 0, self.GM_width, self.GM_height, tocolor(0,0,0,150), self.GamemodeImage[GM_ID])
self.InfoBox.Text = GUILabel:new(0, 0, 0, 50, "Info", self.GamemodeImage[GM_ID])
-- :setAlignX("center")
:setAlignY("center")
-- :setColor(255,0,0,255)
end

function CS_Lobby_Menu:DeleteInfoBar ()
	if self.InfoBox and self.InfoBox.BG then
		delete(self.InfoBox.BG)
		delete(self.InfoBox.Text)
		self.InfoBox = false
	end
end

function CS_Lobby_Menu:PutPlayerInToGM (GM_ID)
triggerServerEvent("CS_Event_JoinGamemode", localPlayer, GM_ID)
delete(self)
end
