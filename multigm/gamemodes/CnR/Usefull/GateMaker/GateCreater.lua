GateSystem = {}

function GateSystem:constructor (CNR_SELF,model,x,y,z,rx,ry,rz,ColRadius,moveTime,closeTime,richtung,Fraction )

self.Fraction = Fraction
self.x = x
self.y = y
self.z = z
self.rx = rx
self.ry = ry
self.rz = rz
self.ColRadius = ColRadius
self.moveTime = moveTime
self.closeTime = moveTime+closeTime
self.richtung = richtung
self.GateObject = createObject( model,self.x,self.y,self.z,rx,ry,rz)--schranke
self.GateObject:setDimension(CNR_SELF:getDimension())

self.GateCol = createColSphere ( x,y,z, ColRadius )
self.GateCol:setDimension(CNR_SELF:getDimension())

self.GateStatus = "zu"
self.HornOpen = function () self:Open() end

if self.richtung == "up" then
self.MoveDirection = 1
elseif self.richtung == "down" then
self.MoveDirection = -1
elseif self.richtung == "left" then
self.MoveDirection = 1
elseif self.richtung == "right" then
self.MoveDirection = -1
end
addEventHandler ( "onColShapeHit"  , self.GateCol, bind(GateSystem.BindPlayerKey,self))
addEventHandler ( "onColShapeLeave", self.GateCol, bind(GateSystem.UnBindPlayerKey,self))
end



function GateSystem:BindPlayerKey(player, matchingDimension)
	if getElementType ( player ) == "player" then  
		if self.Fraction == player.Fraction or not self.Fraction then
			self:Open()
		end
		
	bindKey(player,"horn","down",self.HornOpen)
	end
end

function GateSystem:UnBindPlayerKey(player, matchingDimension)
	if getElementType ( player ) == "player" then  
		unbindKey(player,"horn","down",self.HornOpen)
	end
end



function GateSystem:Open()

	if ( self.GateStatus == "zu" ) then
		if self.richtung == "left" or self.richtung == "right" then

				moveObject(self.GateObject,self.moveTime,self.x+self.MoveDirection*10,self.y,self.z, 0,0,0,"OutBack")
				self.GateStatus = "auf" 			
				setTimer( function()
				moveObject(self.GateObject,self.moveTime,self.x,self.y,self.z, 0,0,0,"OutInQuad")
				
				setTimer( 
				function() 
				self.GateStatus = "zu" end ,self.moveTime,1)
				end , self.closeTime,1 )
				
				
		elseif self.richtung == "down" or self.richtung == "up" then

				moveObject(self.GateObject,self.moveTime,self.x,self.y,self.z+self.MoveDirection*10, 0,0,0,"OutBack")
				self.GateStatus = "auf" 			
				setTimer( function()
				moveObject(self.GateObject,self.moveTime,self.x,self.y,self.z, 0,0,0,"OutInQuad")
				
				setTimer( 
				function() 
				self.GateStatus = "zu" end ,self.moveTime,1)
				end , self.closeTime,1 )
										
		end							
	end
			
end




