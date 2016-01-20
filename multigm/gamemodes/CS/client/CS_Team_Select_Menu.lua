CS_Team_Select_Menu = inherit(GUIForm)
inherit(Singleton, CS_Team_Select_Menu)

function CS_Team_Select_Menu:constructor(CS_SELF)
self.IMG_TeamSelect_CT = "gamemodes/CS/res/images/TeamSelect_CT.jpg"
self.IMG_TeamSelect_T  = "gamemodes/CS/res/images/TeamSelect_T.jpg"
  GUIForm.constructor(self, 0, 0, screenWidth, screenHeight)
  self.m_RoundedRect  = GUIRoundedRect:new(self.m_Width*0.03, self.m_Height*0.05, self.m_Width*0.94, self.m_Height*0.9, self)
  :setColor(tocolor(0, 0, 0, 180))
  outputChatBox("create CS_Team_Select_Menu",tocolor(255, 10, 255, 180))
  GUIRectangle:new(self.m_Width*0.5-1, 0, 2, self.m_Height, tocolor(255, 0, 0, 200), self)
  local TeamSelectSize = {0.3,0.55}
  local AZ = 0.35--Abstand zwischen
  local TeamH = 0.25 --höche
  
--CT
  self.TeamSelect_CT = GUIImage:new(self.m_Width*0.5-self.m_Width*AZ, self.m_Height*TeamH, self.m_Width*TeamSelectSize[1], self.m_Height*TeamSelectSize[2], self.IMG_TeamSelect_CT, self)
  self:Umrandung(self.TeamSelect_CT.m_PosX,self.TeamSelect_CT.m_PosY,self.TeamSelect_CT.m_Width,self.TeamSelect_CT.m_Height,5)
  GUILabel:new(self.TeamSelect_CT.m_PosX,self.TeamSelect_CT.m_PosY*0.8, self.TeamSelect_CT.m_Width, 50, "Counter-Terrorists", self)
  :setAlignX("center")
  
  self.TeamSelect_CT.onLeftClick = function(element)
				self:SelectTeam("CT")
				-- delete(self)
  end
  
--T
  self.TeamSelect_T  = GUIImage:new(self.m_Width*0.5+self.m_Width*AZ-self.m_Width*TeamSelectSize[1], self.m_Height*TeamH, self.m_Width*TeamSelectSize[1], self.m_Height*TeamSelectSize[2], self.IMG_TeamSelect_T, self)
  self:Umrandung(self.TeamSelect_T.m_PosX,self.TeamSelect_T.m_PosY,self.TeamSelect_T.m_Width,self.TeamSelect_T.m_Height,5)
  GUILabel:new(self.TeamSelect_T.m_PosX,self.TeamSelect_T.m_PosY*0.8, self.TeamSelect_T.m_Width, 50, "Terrorist", self)
  :setAlignX("center")	
  
  self.TeamSelect_T.onLeftClick = function(element)
				self:SelectTeam("T")
				-- delete(self)
  end
  
  
end 

function CS_Team_Select_Menu:SelectTeam(Team)
--TEST einfügen Max Player
outputChatBox("Abfrage einfügen")
triggerServerEvent("CS_Event_SetPlayerTeam", localPlayer,localPlayer, Team)
delete(self)
end



function CS_Team_Select_Menu:Umrandung(x,y,w,h,size)
local x,y,w,h,size =tonumber(x),tonumber(y),tonumber(w),tonumber(h),tonumber(size)
local Color = tocolor(50, 50, 50, 255)
GUIRectangle:new(x         ,y       , w      , size   , Color, self)--Oben
GUIRectangle:new(x         ,y+h     , w      , size   , Color, self)--Unter
GUIRectangle:new(x         ,y+size  , size   , h-size , Color, self)--Links
GUIRectangle:new(x+w-size  ,y+size  , size   , h-size , Color, self)--Rechts
end

function CS_Team_Select_Menu:destructor()
outputChatBox("delete CS_Team_Select_Menu",tocolor(255,255,0))
GUIForm.destructor(self)
end
