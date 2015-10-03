﻿GateSystem = {}

function GateSystem:constructor (model,x,y,z,rx,ry,rz,ColRadius,moveTime,closeTime,richtung,Fraction )

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
self.GateObject:setDimension(CNR_DIM)

self.GateCol = createColSphere ( x,y,z, ColRadius )
self.GateCol:setDimension(CNR_DIM)

self.GateStatus = "zu"


if self.richtung == "up" then
self.MoveDirection = 1
elseif self.richtung == "down" then
self.MoveDirection = -1
elseif self.richtung == "left" then
self.MoveDirection = 1
elseif self.richtung == "right" then
self.MoveDirection = -1
end
addEventHandler ( "onColShapeHit", self.GateCol, bind(GateSystem.BindPlayerKey,self))

end



function GateSystem:BindPlayerKey(player, matchingDimension)
if self.Fraction == player.Fraction or not self.Fraction then
	self:Open()
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


new(GateSystem,985,1588.59,-1637.8,12.89,0,0,0,10,3000,1000,"left")
