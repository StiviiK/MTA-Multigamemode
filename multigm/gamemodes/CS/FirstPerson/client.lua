FirstPerson = inherit(Singleton)

function FirstPerson:constructor()
-- outputChatBox("FirstPerson:constructor")

end
local RotationPlus = false
function FirstPerson:CreateFirstPerson()
outputChatBox("FirstPerson:CreateFirstPerson",tocolor(255,0,0))
self.LookX = false
self.LookY = false
self.LookZ = false

self.FP_Hands_path = "gamemodes/CS/res/txd/FirstPersonHands.txd"
local skin = engineLoadTXD ( self.FP_Hands_path  )
			 engineImportTXD ( skin, 160 )
local x,y,z = getElementPosition  (getLocalPlayer())
self.PlayerModel = getElementModel(getLocalPlayer())

setElementModel(getLocalPlayer(),160)
		
self.PreRenderEvent = function(...) self:updateCamera (...) end
addEventHandler ( "onClientPreRender", getRootElement(),self.PreRenderEvent)

self.FreeCamMoveEvent = function(...) self:updateFreeCam(...) end
addEventHandler ("onClientCursorMove",root, self.FreeCamMoveEvent)

		bindKey ( "left", "both", sidewalking )
		bindKey ( "right", "both", sidewalking )
		bindKey ( "backwards", "both", sidewalking )
		
-- GunMove_L
-- GunMove_R
end
local function getCameraRotation ()
    local px, py, pz, lx, ly, lz = getCameraMatrix()
    local rotz = 6.2831853071796 - math.atan2 ( ( lx - px ), ( ly - py ) ) % 6.2831853071796
    local rotx = math.atan2 ( lz - pz, getDistanceBetweenPoints2D ( lx, ly, px, py ) )
    --Convert to degrees
    rotx = math.deg(rotx)
    rotz = -math.deg(rotz)	
    return rotx, 180, rotz
end
function FirstPerson:updateCamera ()
local Headx,Heady,Headz = getPedBonePosition ( getLocalPlayer(), 4 )
	if self.LookX and self.LookY and self.LookZ then
		setCameraMatrix (Headx,Heady,Headz,self.LookX,self.LookY,self.LookZ)
	else
		setCameraMatrix (Headx,Heady,Headz,Headx,Heady,Headz)	
	end

local CameraX,CameraY,CameraZ = getCameraRotation()
setElementRotation(getLocalPlayer(),0,0,CameraZ )


end


function sidewalking(key, keystate)
	if ( keystate == "down" ) then
		if key == "left" then
			wleft = true
			RotationPlus = 45
		elseif key == "right" then
			wright = true
		elseif key == "backwards" then
		RotationPlus = -45
			wback = true
		end
	elseif ( keystate == "up" ) then
		if key == "left" then
			wleft = false
			RotationPlus = false
		elseif key == "right" then
			wright = false
			RotationPlus = false
		elseif key == "backwards" then
			wback = false
		end
	end
end

function FirstPerson:updateFreeCam (cursorX, cursorY, absoluteX, absoluteY, worldX, worldY, worldZ)
self.LookX = worldX
self.LookY = worldY
self.LookZ = worldZ

end

function FirstPerson:RemoveFirstPerson()
-- outputChatBox("FirstPerson:RemoveFirstPerson")
engineRestoreModel ( 160 )
setElementModel(getLocalPlayer(),self.PlayerModel)
end