local lp = getLocalPlayer()

local FractionSelection = {}
FractionSelectionMenu = inherit(GUIForm)
--(screenWidth)/2,screenHeight/2
FractionSelection.Select = CNR_Cops
FractionSelection.SelectTeam = "Cops"
FractionSelection.SelectSkin = 1--TableID




function FractionSelectionMenu:constructor ()
GUIForm.constructor(self, (screenWidth/2)-656/2, (screenHeight)-(187+50), 656, 187)---Hier Drauf wird alles gezeichnet
self.m_Button_Left   = GUIButton:new(10, 125, 206, 49, "<---", self)
self.m_Button_Select   = GUIButton:new(226, 127, 206, 47, "Select", self)
self.m_Button_Right   = GUIButton:new(442, 125, 206, 48, "--->", self)
self.m_GridList = GUIGridList:new(231, 29, 201, 90, self)
local GridTeam = self.m_GridList:addColumn("Team", 70)
local CopsItem = self.m_GridList:addItem("Cops")
local RobbersItem = self.m_GridList:addItem("Robbers")

Cursor:show()
 self.m_GridList.onLeftClick = function ()


 self2 = self
 setTimer(function()---verzögerung weil Grid Select Item in dem selben moment....
	local SelectedName = self2.m_GridList.m_SelectedItem.m_Columns[1].text
	
	
	if SelectedName then
		if SelectedName == "Cops" then
			CopsnRobbers:ShowCopsSelection ()
		elseif SelectedName == "Robbers" then
			CopsnRobbers:ShowRobbersSelection ()
		else
			outputDebugString("debug error not selected")
		end
	end
 end,100,1)
 end
 
 self.m_Button_Select.onLeftClick = function ()	
local Team = FractionSelection.SelectTeam
local Skin = FractionSelection.Select[FractionSelection.SelectSkin]["Skin"]
local SelectID = FractionSelection.SelectSkin
self:delete ()
triggerServerEvent("onPlayerSelectTeam",lp,Team,Skin,SelectID)
 end
 
 
 
self.m_Button_Right.onLeftClick = function ()
FractionSelection.SelectSkin = FractionSelection.SelectSkin +1

	if FractionSelection.SelectSkin > #FractionSelection.Select then FractionSelection.SelectSkin = 1 end
		FractionSelection.Ped:setModel(FractionSelection.Select[FractionSelection.SelectSkin]["Skin"])
	end

	
self.m_Button_Left.onLeftClick = function () 
FractionSelection.SelectSkin = FractionSelection.SelectSkin -1

	if FractionSelection.SelectSkin < 1 then FractionSelection.SelectSkin = #FractionSelection.Select end
		FractionSelection.Ped:setModel(FractionSelection.Select[FractionSelection.SelectSkin]["Skin"])
	end

FractionSelection.Ped = createPed(0,0,0,0,0)
FractionSelection.Ped:setFrozen(true)
CopsnRobbers:ShowCopsSelection ()
end

function FractionSelectionMenu:delete ()
self:destructor()
FractionSelection.Ped:destroy()
end

function CopsnRobbers:ShowRobbersSelection ()

FractionSelection.Select = CNR_RobbersSkins
FractionSelection.SelectTeam = "Robbers"
FractionSelection.SelectSkin = 1--TableID

--Ped--
FractionSelection.Ped:setInterior(0)
FractionSelection.Ped:setDimension(CNR_DIM)
FractionSelection.Ped:setHealth(100)
FractionSelection.Ped:setPosition(2494.3000488281,-1690.1999511719,21.799999237061)
FractionSelection.Ped:setRotation(0,0,0)
FractionSelection.Ped:setModel(FractionSelection.Select[FractionSelection.SelectSkin]["Skin"])
--Player--
lp:setInterior(0)
lp:setDimension(CNR_DIM)
Camera.setMatrix(2494.4318847656,-1683.3291015625,24.370414733887,2492.5209960938,-1773.3660888672,-19.100179672241 )

end


function CopsnRobbers:ShowCopsSelection ()

FractionSelection.Select = CNR_Cops
FractionSelection.SelectTeam = "Cops"
FractionSelection.SelectSkin = 1--TableID
--Ped--
FractionSelection.Ped:setInterior(0)
FractionSelection.Ped:setDimension(CNR_DIM)
FractionSelection.Ped:setHealth(100)
FractionSelection.Ped:setPosition(1552.5999755859,-1675.5999755859,16.21)
FractionSelection.Ped:setRotation(0,0,90)
FractionSelection.Ped:setModel(FractionSelection.Select[FractionSelection.SelectSkin]["Skin"])
--Player--
lp:setInterior(0)
lp:setDimension(CNR_DIM)
Camera.setMatrix( 1547.1048583984,-1675.3217773438,17.216079711914,1641.9064941406,-1681.0043945313,-13.09459400177 )

end




