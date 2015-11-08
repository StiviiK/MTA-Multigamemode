local WeaponObject   = false
local SelectedSlot   = 0 
local SelectedWeapon = 1 
local FensterW,FensterH =  300, 200


function CopsnRobbers:CreateWeaponSelection (Weapon_Pos,Int,Dim)

-----------CNR_DEBUG---------------
-- DebugOutPut( ("Weapon_Pos1 = %s, Weapon_Pos2 = %s, Weapon_Pos3 = %s,"):format(tostring(Weapon_Pos[1]),tostring(Weapon_Pos[2]),tostring(Weapon_Pos[3])) )
-----------------------------------
CNR_SELF = self
self:HideRadar()

WeaponObject = createObject(WeaponsList[SelectedWeapon]["ModelID"],Vector3(Weapon_Pos[1],Weapon_Pos[2],Weapon_Pos[3]),Vector3(0,0,0))
WeaponObject:setInterior(Int)
WeaponObject:setDimension(Dim)

 self.WeaponSelectionRenderTarget = dxCreateRenderTarget( FensterW,FensterH,true ) 
 
self.WeaponSelection_SpaceHandler  = function() self:WeaponSelection_Space() end
self.WeaponSelection_LeftHandler   = function() self:WeaponSelection_Left()  end
self.WeaponSelection_RightHandler  = function() self:WeaponSelection_Right() end
self.WeaponSelection_UpHandler     = function() self:WeaponSelection_Up()    end
self.WeaponSelection_DownHandler   = function() self:WeaponSelection_Down()  end
self.WeaponSelection_EnterHandler  = function() self:WeaponSelection_Enter() end

bindKey("space"   ,"down", self.WeaponSelection_SpaceHandler)
bindKey("arrow_l" ,"down", self.WeaponSelection_LeftHandler)
bindKey("arrow_r" ,"down", self.WeaponSelection_RightHandler) 
bindKey("arrow_u" ,"down", self.WeaponSelection_UpHandler)	
bindKey("arrow_d" ,"down", self.WeaponSelection_DownHandler)
bindKey("enter"   ,"down", self.WeaponSelection_EnterHandler)

self.ObjectDrehenHandler = function() self:ObjectDrehenLassen() end

-----------CNR_DEBUG---------------
-- DebugOutPut( "CreateWeaponSelection" )
-----------------------------------
addEventHandler("onClientRender",root,self.ObjectDrehenHandler)

self.WeaponSelectionMenuRender_Handler  = function() self:WeaponSelectionMenuRender() end
addEventHandler("onClientRender",root,self.WeaponSelectionMenuRender_Handler)


end


local Drehen_Z = 0

function CopsnRobbers:ObjectDrehenLassen ()
if Drehen_Z > 360 then Drehen_Z = 0 end
   Drehen_Z = Drehen_Z +2
WeaponObject:setRotation(0,-25,Drehen_Z)
end



function CopsnRobbers:WeaponSelection_Left ()
playSoundFrontEnd ( 0  )
	if SelectedWeapon-1 < 1 then 
		SelectedWeapon = #WeaponSlot[SelectedSlot] 
	else
		SelectedWeapon = SelectedWeapon -1
	end

		WeaponObject:setModel(WeaponsList[WeaponSlot[SelectedSlot][SelectedWeapon]]["ModelID"])
end

function CopsnRobbers:WeaponSelection_Right ()
playSoundFrontEnd ( 0 )
	if SelectedWeapon+1 > #WeaponSlot[SelectedSlot] then 
		SelectedWeapon = 1 
	else
		SelectedWeapon = SelectedWeapon +1
	end

		WeaponObject:setModel(WeaponsList[WeaponSlot[SelectedSlot][SelectedWeapon]]["ModelID"])
end

function CopsnRobbers:WeaponSelection_Up ()
playSoundFrontEnd ( 1  )
SelectedWeapon = 1
	if SelectedSlot+1 > 12 then 
		SelectedSlot = 0 

	else
		SelectedSlot = SelectedSlot + 1

	end

		WeaponObject:setModel(WeaponsList[WeaponSlot[SelectedSlot][SelectedWeapon]]["ModelID"])
		

end

function CopsnRobbers:WeaponSelection_Down ()
playSoundFrontEnd ( 1  )
SelectedWeapon = 1
	if SelectedSlot-1 < 0 then 
		SelectedSlot = 12 

	else
		SelectedSlot = SelectedSlot - 1

	end

		WeaponObject:setModel(WeaponsList[WeaponSlot[SelectedSlot][SelectedWeapon]]["ModelID"])
		

end

function CopsnRobbers:WeaponSelection_Space ()
local TableID  = WeaponSlot[SelectedSlot][SelectedWeapon]
local WeaponID = WeaponsList[TableID]["WeaponID"]
local WeaponAmmo = 200
triggerServerEvent("BuyWeapon",lp,WeaponID,WeaponAmmo,TableID)
-----------CNR_DEBUG---------------
-- DebugOutPut( "buy WeaponID:"..WeaponID )
-----------------------------------
end

function CopsnRobbers:WeaponSelection_Enter ()
self:DestroyWeaponSelection ()
end

function CopsnRobbers:DestroyWeaponSelection ()

--self.Radar:show()
setCameraTarget ( lp)
lp:setFrozen(false)
if self.ObjectDrehenHandler and self.WeaponSelectionMenuRender_Handler then
removeEventHandler("onClientRender",root,self.ObjectDrehenHandler)
removeEventHandler("onClientRender",root,self.WeaponSelectionMenuRender_Handler)
end
	if isElement(WeaponObject) then
		WeaponObject:destroy()
	end
unbindKey("space"   ,"down", self.WeaponSelection_SpaceHandler)
unbindKey("arrow_l" ,"down", self.WeaponSelection_LeftHandler)
unbindKey("arrow_r" ,"down", self.WeaponSelection_RightHandler) 
unbindKey("arrow_u" ,"down", self.WeaponSelection_UpHandler)	
unbindKey("arrow_d" ,"down", self.WeaponSelection_DownHandler)
unbindKey("enter"   ,"down", self.WeaponSelection_EnterHandler)
-----------CNR_DEBUG---------------
DebugOutPut( "DestroyWeaponSelection" )
-----------------------------------
end


function CopsnRobbers:CreateWeaponSelectionEvent ()
self.CreateWeaponSelectionEventHandler = function(...) self:CreateWeaponSelection(...) end
self.DestroyWeaponSelectionHandler = function(...) self:DestroyWeaponSelection(...) end

addRemoteEvents{"CreateWeaponSelection"}
addEventHandler("CreateWeaponSelection", root,  self.CreateWeaponSelectionEventHandler )

addRemoteEvents{"DestroyWeaponSelection"}
addEventHandler("DestroyWeaponSelection", root, self.DestroyWeaponSelectionHandler)
end




-------------------Gui--------------


---Slot
---WaffenName
---Preis
---Schaden

--benutzung


local sw,sh = guiGetScreenSize()
-- FensterW , FensterH
function CopsnRobbers:WeaponSelectionMenuRender ()

	
dxDrawImage((sw-FensterW)/2,sh-FensterH-20,FensterW , FensterH,"gamemodes/CnR/res/images/Weapon_Selection/select.png",0,0,0,tocolor(255,0,0))

dxDrawRectangle(5,sh-50,185,45,tocolor(255,255,255,150))

dxDrawText("Press Space to Buy"     ,10,sh-50,100,50, tocolor ( 255, 0, 0, 255 ),1.5)
dxDrawText("Press Enter  to Leave"  ,10,sh-30,100,50, tocolor ( 255, 0, 0, 255 ),1.5)

if lp:isDead() then self:DestroyWeaponSelection() end

end





-------------------------------------