--------------------------------------------------------------
--------------------------Health_HUD------------------------------
--------------------------------------------------------------

Health_HUD = inherit(GUIForm)
inherit(Singleton, Health_HUD)

function Health_HUD:constructor()
GUIForm.constructor(self, 0, 0, screenWidth, screenHeight,false)
self.Background_Url = "gamemodes/CS/res/images/Health_HUD.png"
local AbStand = self.m_Width*0.01
local B_W,B_H = self.m_Width*0.3, self.m_Height*0.08
local X,Y = AbStand,screenY-B_H-AbStand

self.Background = GUIImage:new(AbStand,screenY-B_H-AbStand, B_W,B_H, self.Background_Url,self )	


self.Health_Label  = GUILabel:new(B_W*0.12,B_H*0.15, 0,B_H*0.7,"100%", self.Background)
	:setAlignX("left")
	:setAlignY("center")	


self.Armor_Label  = GUILabel:new(B_W*0.5,B_H*0.15, 0,B_H*0.7,"100%", self.Background)
	:setAlignX("left")
	:setAlignY("center")
	
self.UpdateFunction = function(...) self:UpdateHealth_HUD(...) end
addEventHandler("onClientPlayerDamage",getLocalPlayer(),self.UpdateFunction)		
end

function Health_HUD:UpdateHealth_HUD (attacker, attackerweapon ,bodypart, loss)
outputChatBox("tttttttttt")
local Health = tostring(math.ceil(getElementHealth(lp))).."%"
local Armor  = tostring(math.ceil(getPlayerArmor(lp))).."%"
self.Health_Label:setText(Health)
self.Armor_Label:setText(Armor)
end

function Health_HUD:Remove()
delete(self)
removeEventHandler("onClientPlayerDamage",getLocalPlayer(),self.UpdateFunction)	
end

--------------------------------------------------------------
--------------------------Weapon_HUD------------------------------
--------------------------------------------------------------

Weapon_HUD = inherit(GUIForm)
inherit(Singleton, Weapon_HUD)

function Weapon_HUD:constructor()
GUIForm.constructor(self, 0, 0, screenWidth, screenHeight,false)
self.Background_Url = "gamemodes/CS/res/images/Weapon_HUD.png"
local B_W,B_H = self.m_Width*0.2, self.m_Height*0.08
local AbStand = self.m_Width*0.01
local X,Y = screenX-B_W-AbStand,screenY-B_H-AbStand
self.Background = GUIImage:new(screenX-B_W-AbStand,screenY-B_H-AbStand, B_W,B_H, self.Background_Url,self )			 --AbStand,-AbStand+ screenHeight-B_H

self.Ammo     = GUILabel:new(B_W*0.2,0,		 0,B_H,"30", self.Background)
	:setAlignX("left")
	:setAlignY("center")
	
self.Magazin  = GUILabel:new(B_W*0.4,B_H*0.2,		 0,B_H*0.7,"/90", self.Background)
	:setAlignX("left")
	:setAlignY("center")
end

function Weapon_HUD:Remove()
delete(self)
end


--------------------------------------------------------------
--------------------------Timer_HUD------------------------------
--------------------------------------------------------------
Timer_HUD = inherit(GUIForm)
inherit(Singleton, Timer_HUD)

function Timer_HUD:constructor(GM)
self.Self_GM = GM
GUIForm.constructor(self, 0, 0, screenWidth, screenHeight,false)
self.Background_Url = "gamemodes/CS/res/images/Time_HUD.png"
local B_W,B_H = self.m_Width*0.06, self.m_Height*0.08
local AbStand = self.m_Width*0.01
local X,Y = screenX/2-B_W/2,AbStand
self.Background = GUIImage:new(screenX/2-B_W/2,AbStand, B_W,B_H, self.Background_Url,self )			 --AbStand,-AbStand+ screenHeight-B_H

self.Time  = GUILabel:new(X,Y, B_W,B_H/2,"00:00", self)
	:setAlignX("center")
	:setAlignY("center")
	
self.Score_CT  = GUILabel:new(	X*0.998,		B_H*0.66,	 B_W/2,B_H/2,"14", self)
	:setAlignX("center")
	:setAlignY("center")
	 -- :setColor(255,0,0,255)
self.Score_T  = GUILabel:new(	(X+B_W/2)*0.998	,B_H*0.66,		 B_W/2,B_H/2,"15", self)
	:setAlignX("center")
	:setAlignY("center")
	 -- :setColor(255,255,0,255)
	 self:StartUpdateTimer()
end

function Timer_HUD:StartUpdateTimer()
self.TimeUpdatePulse = TimedPulse:new(500)

self.TimerFunction = function(...) self:UpdateTimer(...) end
self.TimeUpdatePulse:registerHandler(self.TimerFunction)
end

function Timer_HUD:UpdateTimer()

local GameTime = self.Self_GM:getSyncInfo("GameTime")

local s = 0
	 if GameTime then
		  s = TimeHud_Rechner(GameTime)
	 else
		  s = 0
	 end
if s < 0 then s = 0 end

self.Time:setText(string.format("%.2d:%.2d", s/60%60, s%60))

end

function TimeHud_Rechner(TimeTable)
TimeNow = getRealTime()
local CountDownTime =     TimeTable.Countdown

local minutes_Start =     TimeTable.Time.minute
local second_Start  =     TimeTable.Time.second

local minutes_Now   =     TimeNow.minute
local second_Now    =     TimeNow.second

local m = minutes_Now - minutes_Start
local s = second_Now  - second_Start + m*60

return CountDownTime/1000-s
end

function Timer_HUD:StopUpdateTimer()

end

function Timer_HUD:Remove()
delete(self)
end