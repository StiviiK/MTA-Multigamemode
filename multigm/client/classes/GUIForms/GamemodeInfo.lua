-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  FILE:        client/classes/GUIForms/GamemodeInfo.lua
-- *  PURPOSE:     Gamemode Information Window
-- *
-- ****************************************************************************

GamemodeInfo = inherit(GUIForm)

function GamemodeInfo:constructor(Id)
  GUIForm.constructor(self, screenWidth/2 - screenWidth*0.35/2, screenHeight/2 - screenHeight*0.45/2, screenWidth*0.35, screenHeight*0.45)

  self.m_Gamemode = GamemodeManager.getFromId(Id) and GamemodeManager.getFromId(Id) or false
  if not self.m_Gamemode then delete(self) return end
  self.m_HeaderPath = self.m_Gamemode and self.m_Gamemode:getSetting("HeaderPath") or "files/images/HeaderDefaultGamemode.png"
  if not fileExists(self.m_HeaderPath) then self.m_HeaderPath = "files/images/HeaderDefaultGamemode.png" end

  self.m_Window = GUIWindow:new(0, 0, self.m_Width, self.m_Height, self.m_Gamemode:getName(), true, true, self)
  GUIImage:new(self.m_Width*0.005, self.m_Height*0.1, self.m_Width*0.9925, self.m_Height*0.3, self.m_HeaderPath, self.m_Window)

  self.m_JoinButton = GUIButton:new(self.m_Width*0.025, self.m_Height*0.9, self.m_Width*0.45, self.m_Height*0.08, _"Gamemode beitreten", self.m_Window):setBackgroundColor(Color.Green)
  self.m_JoinButton.onLeftClick = function () triggerServerEvent("Event_JoinGamemode", localPlayer, Id) delete(self) end
  self.m_AbortButton = GUIButton:new(self.m_Width - self.m_Width*0.45 - self.m_Width*0.025, self.m_Height*0.9, self.m_Width*0.45, self.m_Height*0.08, _"Abbrechen", self.m_Window):setBackgroundColor(Color.Red)
  self.m_AbortButton.onLeftClick = function () delete(self) end
end
