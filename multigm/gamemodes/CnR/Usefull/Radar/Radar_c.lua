
-- local myBlip = createBlip( 0,0,0, 0, 255, 0, 0, 100 )-- Test später weg machen

MiniMap = inherit(Singleton)

local lp = getLocalPlayer()
local sw,sh = guiGetScreenSize()

local abstand = 10
function MiniMap:constructor()
self.w     = screenWidth*0.285
self.h     = screenHeight*0.25

self.x     = abstand
self.y     = sh-abstand*2-self.h



self.Diagonal   = math.sqrt(self.w^2+self.h^2)

--IMAGE--
self.IMG_Map             =   "gamemodes/CnR/res/images/Radar/Radar.jpg"--dxCreateTexture( "gamemodes/CnR/res/images/Radar/Radar.jpg","dxt5" )
self.IMG_Cursor          =   "gamemodes/CnR/res/images/Radar/Cursor.png"--dxCreateTexture( "gamemodes/CnR/res/images/Radar/Cursor.png","dxt5" )
self.IMG_Heli     		 =   "gamemodes/CnR/res/images/Radar/Heli.png"--dxCreateTexture( "gamemodes/CnR/res/images/Radar/Heli.png","dxt5" )
self.IMG_HeliRotoren     =   "gamemodes/CnR/res/images/Radar/HeliRotoren.png"--dxCreateTexture( "gamemodes/CnR/res/images/Radar/HeliRotoren.png","dxt5" )
self.IMG_Flugzeug     	 =   "gamemodes/CnR/res/images/Radar/Flugzeug.png"--dxCreateTexture( "gamemodes/CnR/res/images/Radar/Flugzeug.png","dxt5" )
self.IMG_Water     		 =   "gamemodes/CnR/res/images/Radar/Water.jpg"-- dxCreateTexture( "gamemodes/CnR/res/images/Radar/Water.jpg","dxt5" )        =
self.Blip = {}
for BlipID = 0,63 do
self.Blip[BlipID]     =   "gamemodes/CnR/res/images/Radar/blip/"..BlipID..".png" --dxCreateTexture( "gamemodes/CnR/res/images/Radar/blip/"..BlipID..".png","dxt5" )
end
---------

self.ZoomWertStandart = 1
self.ZoomWert   = self.ZoomWertStandart
self.CarZoom = self.ZoomWertStandart
self.CarZoomMax = 2
self.CarZoomMin = 0.7
self.MapSizeX   = 3000
self.MapSizeY   = 3000
self.m_Diagonal = 100


self.RenderTargetMap           = dxCreateRenderTarget( 3000, 3000 )
self.RenderTargetFenster       = dxCreateRenderTarget( self.w, self.h )

self.RenderHandler 		   = function() self:render() end
self.RenderHandler_Status  = false
self.RenderTargetUmrandung = dxCreateRenderTarget( self.w, self.h,true  )
self.RenderTargetInterior  = dxCreateRenderTarget( self.w, self.h,true  )
self.visible = false

self:Umrandung()
self:NoSignalInterior()
end

function MiniMap:NoSignalInterior()

dxSetRenderTarget( self.RenderTargetInterior )
dxDrawRectangle ( 0,0, self.w, self.h, tocolor ( 100,100,100,255 ) )--oben
dxDrawText("No Signal",0,0,self.w, self.h,tocolor ( 255, 0, 0, 255 ),2,"pricedown","center","center")

dxSetRenderTarget()
end

function MiniMap:Umrandung()
local dicke = 5
local kreuzdicke = 1
dxSetRenderTarget( self.RenderTargetUmrandung )
local r,g,b,a = 255,0,0,200


dxDrawRectangle ( dicke,            0, self.w-dicke*2, dicke, tocolor ( r,g,b,a ) )--oben
dxDrawRectangle ( dicke, self.h-dicke, self.w-dicke*2, dicke, tocolor ( r,g,b,a ) )--unten

dxDrawRectangle ( 0, 0, dicke, self.h, tocolor ( r,g,b,a ) )--links
dxDrawRectangle ( self.w-dicke, 0, dicke, self.h, tocolor ( r,g,b,a ) )--rechts



dxSetRenderTarget()
end
local CarZoom = 2




function MiniMap:ZoomInByDriving ()
if not getPedOccupiedVehicle(getLocalPlayer()) then self.ZoomWert = self.ZoomWertStandart return end
local speed = getElementSpeed(getPedOccupiedVehicle(getLocalPlayer()), "km/h")

	if speed > 70 then
		self:RausZoomen()
	else
		if CarZoom == self.ZoomWertStandart then return end
			self:ReinZoomen ()

	end


self.ZoomWert = CarZoom
end

function MiniMap:ReinZoomen ()
	if CarZoom < self.CarZoomMax then
			CarZoom = CarZoom +0.01
	end
end

function MiniMap:RausZoomen ()
	if CarZoom-0.01 > self.CarZoomMin then
		CarZoom = CarZoom -0.01
	end
end


function MiniMap:DrawArea ()
	local x,y = getElementPosition(lp)
	local cam = getCamera()
	local _, _, camRotZ = getElementRotation(cam)


		 for i, Area in pairs(getElementsByType("radararea")) do
		 local areaX, areaY=getElementPosition(Area)
		 local areaSizeX,areaSizeY=getRadarAreaSize(Area)
		 local AreaDistanceToPlayer1 = getDistanceBetweenPoints2D ( areaX, areaY, x,y )
		 local AreaDistanceToPlayer2 = getDistanceBetweenPoints2D ( areaX+areaSizeX, areaY+areaSizeY, x,y )
		 
				 if AreaDistanceToPlayer1 < self.Diagonal or AreaDistanceToPlayer2 < self.Diagonal then
				 
		
							
							local areaR,areaG,areaB,areaA=getRadarAreaColor(Area)
							dxDrawRectangle(1500+areaX*0.5, 1500+areaY*0.5-areaSizeY*0.5,areaSizeX*0.5,areaSizeY*0.5, tocolor(areaR,areaG,areaB,areaA))
			
				 end
 end
end










function findRotation(x1,y1,x2,y2) --Author: Doomed_Space_Marine & robhol
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;
end

function getPointFromDistanceRotation(x, y, dist, angle) --Author: robhol
    local a = math.rad(90 - angle);
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
    return x+dx, y+dy;
end





function RechteckKantenBerechnung(w,h,winkel)
if winkel < 0 	then winkel = 360-winkel end
if winkel > 360 then winkel = winkel-360 end
local w,h =w/2,h/2
local av = w/h
local X,Y
if winkel == 90 then 
X,Y = w,0
elseif winkel == 180 then
X,Y = 0,h
elseif winkel == 270 then
X,Y = -w,0
elseif winkel == 360 then
X,Y = 0,-h

elseif  winkel > 0 and winkel <  91 then

           if winkel < 45 then
                    X = h*math.tan(math.rad(winkel))*av
                    Y = -h
           else
                    X = w
                    Y = (w*math.tan(math.rad(winkel-2*45)))/av
           end
elseif winkel > 90 and  winkel <  180 then

           if winkel < 135 then
                    X = w
                    Y = -w*math.tan(math.rad(-winkel-135+45))/av
           else
                    X =  (h+h*math.tan(math.rad(-winkel-135+2*45)))*av
                    Y =  h
           end
elseif winkel > 180 and  winkel <  270 then

           if winkel < 225 then
                    X = h*math.tan(math.rad(-winkel-180))*av
                    Y = h
           else
                    X = -w
                    Y = w*math.tan(math.rad(-winkel-180+2*45))/av
           end
elseif winkel > 270 and  winkel <  360 then

           if winkel < 315 then
                    X = -w
                    Y = w*math.tan(math.rad(-winkel-270))/av
           else

                    X =  -h*math.tan(math.rad(360-winkel))*av
                    Y =  -h
           end
else
                   X = 0
                   Y = 0
end
return X,Y
end









local myBlip2 = createBlip( 100,0,0, 0, 50, 0, 0, 100 )-- Test später weg machen

function MiniMap:DrawBlip ()
	local x,y = getElementPosition(lp)
	local _, _, RotZ = getElementRotation(lp)
	local cam = getCamera()
	local _, _, camRotZ = getElementRotation(cam)
	local cx,cy,_,tx,ty = getCameraMatrix()


	for i, Blip in pairs(getElementsByType("blip")) do
-----------------Blip Size einfügen und zoom einfügen-----------------------------
local BlipX, BlipY  = getElementPosition(Blip)
local BlipDistanceToPlayer = getDistanceBetweenPoints2D ( BlipX, BlipY, x,y )
local BlipVisibleDistance =  getBlipVisibleDistance ( Blip )

		if BlipDistanceToPlayer < (self.Diagonal)  then
			local blipicon 		= getBlipIcon(Blip)
			local blipsize = false
			if blipicon == 0 then
				 blipsize 		=  15
			else
				 blipsize 		=  25
			end

			local r, g, b 		= getBlipColor(Blip)
			
			local xg,yg = 1500+(BlipX*0.5)-blipsize*0.5,1500+(-BlipY*0.5)-blipsize*0.5
			
						
						
				local PlayerX = (1500+x/2)--*self.ZoomWert
				local PlayerY = (1500-y/2)--*self.ZoomWert

	
				local Winkel = findRotation(PlayerX,PlayerY,xg,yg)
				local Distance = getDistanceBetweenPoints2D ( xg,yg, PlayerX, PlayerY )
				-- outputChatBox("Winkel+180-camRotZ:"..Winkel+180-camRotZ)
				local X,Y = RechteckKantenBerechnung(150,150,Winkel+180-camRotZ)
				Var = 0.6
			A = Vector2(xg,yg)
			B = Vector2(PlayerX,PlayerY)
			
			VerbindungsVector = -(B - A)
			VectorTT = B + VerbindungsVector * Var
			if blipicon == 0 then 
						if Distance < 50 then
						dxDrawImage(xg,yg, blipsize, blipsize, self.Blip[blipicon], -camRotZ, 0, 0,tocolor(r, g, b)	)
						else
						
						outputChatBox("VectorTT.x,VectorTT.y: "..VectorTT.x.." | "..VectorTT.y)
							dxDrawImage(VectorTT.x-blipsize/2,VectorTT.y-blipsize/2, blipsize, blipsize, self.Blip[blipicon], -camRotZ, 0, 0,tocolor(r, g, b)	)
						
						end
			else	
						
						dxDrawImage(xg,yg, blipsize, blipsize, self.Blip[blipicon], -camRotZ, 0, 0	)
			end
				
		end
		
	end
end






function MiniMap:show()
	if self.visible == false then
		addEventHandler("onClientRender", getRootElement(), self.RenderHandler) ;
		self.visible = true
	end
end

function MiniMap:hide()
	if self.visible == true then
		removeEventHandler("onClientRender", getRootElement(), self.RenderHandler );
		self.visible = false
	end
end


local HeliRotationCount = 1
function MiniMap:DrawHeliCursor ()

	local _, _, RotZ = getElementRotation(lp)
	local cam = getCamera()
	local _, _, camRotZ = getElementRotation(cam)

	
local vehicle = getPedOccupiedVehicle ( lp )
local RotationSpeed = getHelicopterRotorSpeed ( vehicle  )*40
local ImageSize = 140
dxDrawImage ( self.x+(self.w*0.5)-(ImageSize*0.5),self.y+(self.h*0.5)-(ImageSize*0.5), ImageSize, ImageSize, self.IMG_Heli,-RotZ+camRotZ-90 )

if HeliRotationCount > 360 then HeliRotationCount = 1 end
HeliRotationCount = HeliRotationCount + RotationSpeed
dxDrawImage ( self.x+(self.w*0.5)-(ImageSize*0.5),self.y+(self.h*0.5)-(ImageSize*0.5), ImageSize, ImageSize, self.IMG_HeliRotoren ,HeliRotationCount)
end


function MiniMap:DrawFlugzeugCursor ()

	local _, _, RotZ = getElementRotation(lp)
	local cam = getCamera()
	local _, _, camRotZ = getElementRotation(cam)


local ImageSize = 85*self.ZoomWert
dxDrawImage ( self.x+(self.w*0.5)-(ImageSize*0.5),self.y+(self.h*0.5)-(ImageSize*0.5), ImageSize, ImageSize, self.IMG_Flugzeug,-RotZ+camRotZ )
end



	local cam = getCamera()
function MiniMap:render()
 local Interior = getElementInterior(lp)
	if self.visible  then
		if Interior == 0 then
			local x,y = getElementPosition(lp)
			local _, _, RotZ = getElementRotation(lp)

			local _, _, camRotZ = getElementRotation(cam)
			local cx,cy,_,tx,ty = getCameraMatrix()
			
				self:ZoomInByDriving ()



		dxSetRenderTarget( self.RenderTargetMap )

				dxDrawImage ( 0, 0, self.MapSizeX, self.MapSizeY, self.IMG_Map 	 )
				self:DrawArea ()-------Muss verbessern weil es leicht läggt
				self:DrawBlip ()-------Muss verbessern weil es leicht läggt

		dxSetRenderTarget()



		dxSetRenderTarget( self.RenderTargetFenster )

			dxDrawImage ( 0,0, self.w, self.h, self.IMG_Water )

			dxDrawImage ( 		(-self.MapSizeX/(6000/self.MapSizeX)-(x*0.5))*self.ZoomWert+(self.w*0.5), --x
								(-self.MapSizeX/(6000/self.MapSizeY)+(y*0.5))*self.ZoomWert+(self.h*0.5), --y
								self.MapSizeX*self.ZoomWert, --w
								self.MapSizeY*self.ZoomWert, --h
								self.RenderTargetMap,
			camRotZ,
								(x/(6000/self.MapSizeX))*self.ZoomWert,--offset x
								(-y/(6000/self.MapSizeY))*self.ZoomWert--offset y


			)
		dxSetRenderTarget()













		dxDrawImage ( self.x,self.y, self.w, self.h, self.RenderTargetFenster )	   ---map

		 dxDrawImage ( self.x,self.y, self.w, self.h, self.RenderTargetUmrandung )---Umrandung


		local vehicle = getPedOccupiedVehicle ( lp )
			if vehicle and getVehicleType ( getElementModel(vehicle) ) == "Helicopter" then 
				self:DrawHeliCursor ()
			elseif vehicle and getVehicleType ( getElementModel(vehicle) ) == "Plane" then 
				self:DrawFlugzeugCursor ()
			else
				local Cursordicke = 30--*self.ZoomWert
				dxDrawImage ( self.x+((self.w)*0.5)-Cursordicke*0.5,self.y+((self.h)*0.5)-Cursordicke*0.5, Cursordicke, Cursordicke, self.IMG_Cursor,-RotZ+camRotZ )---Cursor
			end
		local X,Y = RechteckKantenBerechnung(self.w,self.h ,camRotZ)
		local mitteX,mitteY = self.x+((self.w)*0.5),	self.y+((self.h)*0.5)

		local NorthSize = 50
		dxDrawImage ( mitteX+X-NorthSize/2,mitteY+Y-NorthSize/2, NorthSize, NorthSize, self.Blip[4],0 )---Cursor
else
	
 dxDrawImage ( self.x,self.y, self.w, self.h, self.RenderTargetInterior )---Umrandung
 dxDrawImage ( self.x,self.y, self.w, self.h, self.RenderTargetUmrandung )---Umrandung
 
		end
	end
end


function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    assert(getElementType(theElement) == "player" or getElementType(theElement) == "ped" or getElementType(theElement) == "object" or getElementType(theElement) == "vehicle", "Invalid element type @ getElementSpeed (player/ped/object/vehicle expected, got " .. getElementType(theElement) .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end



