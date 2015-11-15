local lp = getLocalPlayer()

local FractionSelection = {}
FractionSelectionMenu = inherit(GUIForm)
--(screenWidth)/2,screenHeight/2
FractionSelection.Select = CNR_Cops
FractionSelection.SelectTeam = "Cops"
FractionSelection.SelectSkin = 1--TableID




function FractionSelectionMenu:constructor (CNR_SELF)

	---------------------------CNR_DEBUG------------------------------------
						if CNR_DEBUG then
								triggerServerEvent("onPlayerSelectTeam",lp,"Cops",1,1)
								CNR_SELF:onPlayerSelectTeam("Cops",1,1)
						return end
	-----------------------------------------------------------------------

GUIForm.constructor(self, (screenWidth/2)-656/2, (screenHeight)-(187+50), 656, 187)---Hier Drauf wird alles gezeichnet
Cursor:show()
self.m_Button_Left   = GUIButton:new(10, 125, 206, 49, "<---", self)
	:setBackgroundColor(CNR_SELF:getColor())
self.m_Button_Select   = GUIButton:new(226, 127, 206, 47, "Select", self)
	:setBackgroundColor(CNR_SELF:getColor())
self.m_Button_Right   = GUIButton:new(442, 125, 206, 48, "--->", self)
	:setBackgroundColor(CNR_SELF:getColor())
self.m_GridList = GUIGridList:new(231, 29, 201, 90, self)
	:setColor(CNR_SELF:getColor())
local GridTeam = self.m_GridList:addColumn("Team", 70)
local CopsItem = self.m_GridList:addItem("Cops")
local RobbersItem = self.m_GridList:addItem("Robbers")
-- Force click the first Item
CopsItem:onInternalLeftClick()

self.m_GridList.onSelectItem = function (item)
  local SelectedName = item:getColumnText(1)
	if SelectedName then
		if SelectedName == "Cops" then
			CopsnRobbers:ShowCopsSelection ()
		elseif SelectedName == "Robbers" then
			CopsnRobbers:ShowRobbersSelection ()
		end
	end
 end

self.m_Button_Select.onLeftClick = function ()
  local Team = FractionSelection.SelectTeam
  local Skin = FractionSelection.Select[FractionSelection.SelectSkin]["Skin"]
  local SelectID = FractionSelection.SelectSkin
  self:delete ()
  triggerServerEvent("onPlayerSelectTeam",lp,Team,Skin,SelectID)
  CNR_SELF:onPlayerSelectTeam(Team,Skin,SelectID)
  Cursor:hide()
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
if isElement(FractionSelection.Ped) then
FractionSelection.Ped:destroy()
end
end

function CopsnRobbers:ShowRobbersSelection ()

FractionSelection.Select = CNR_RobbersSkins
FractionSelection.SelectTeam = "Robbers"
FractionSelection.SelectSkin = 1--TableID

--Ped--
FractionSelection.Ped:setInterior(0)

-- self:addSyncChangeHandler("Dimension", function (dim)
-- FractionSelection.Ped:setDimension(dim)
-- end)
FractionSelection.Ped:setDimension(CNR_DIM)

FractionSelection.Ped:setHealth(100)
FractionSelection.Ped:setPosition(2494.3000488281,-1690.1999511719,21.799999237061)
FractionSelection.Ped:setRotation(0,0,0)
FractionSelection.Ped:setModel(FractionSelection.Select[FractionSelection.SelectSkin]["Skin"])
--Player--
lp:setInterior(0)

-- self:addSyncChangeHandler("Dimension", function (dim)
-- lp:setDimension(dim)
-- end)
lp:setDimension(CNR_DIM)
Camera.setMatrix(2494.4318847656,-1683.3291015625,24.370414733887,2492.5209960938,-1773.3660888672,-19.100179672241 )

end

function CopsnRobbers:ShowCopsSelection ()

FractionSelection.Select = CNR_Cops
FractionSelection.SelectTeam = "Cops"
FractionSelection.SelectSkin = 1--TableID
--Ped--
FractionSelection.Ped:setInterior(0)

-- self:addSyncChangeHandler("Dimension", function (dim)
-- FractionSelection.Ped:setDimension(dim)
-- end)
FractionSelection.Ped:setDimension(CNR_DIM)

FractionSelection.Ped:setHealth(100)
FractionSelection.Ped:setPosition(1552.5999755859,-1675.5999755859,16.21)
FractionSelection.Ped:setRotation(0,0,90)
FractionSelection.Ped:setModel(FractionSelection.Select[FractionSelection.SelectSkin]["Skin"])
--Player--
lp:setInterior(0)


-- self:addSyncChangeHandler("Dimension", function (dim)
-- lp:setDimension(dim)
-- end)
lp:setDimension(CNR_DIM)
Camera.setMatrix( 1547.1048583984,-1675.3217773438,17.216079711914,1641.9064941406,-1681.0043945313,-13.09459400177 )

end



function CopsnRobbers:CreateFractionSelectMenu ()
self.FractionSelectionMenu = FractionSelectionMenu:new(self)
end
