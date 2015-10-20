SchrankeSystem = {}

function SchrankeSystem:constructor (CNR_SELF,x,y,z,rx,ry,rz,ColRadius,moveTime,closeTime,richtung,Fraction )

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
self.SchrankeObject = createObject( 968,self.x,self.y,self.z+0.7,rx,ry,rz)--schranke
self.SchrankeObjectUnten = createObject( 966,self.x,self.y,self.z,0,0,self.rz)
self.SchrankeObject:setDimension(CNR_SELF:getDimension())
self.SchrankeObjectUnten:setDimension(CNR_SELF:getDimension())


self.SchrankeCol = createColSphere ( x,y,z, ColRadius )
self.SchrankeCol:setDimension(CNR_SELF:getDimension())
self.HornOpen = function () self:Open() end
self.SchrankeStatus = "zu"


	if self.richtung == 1 then
		self.move1 = -90
		self.move2 = 90
		else
		self.move1 = 90
		self.move2 = -90
	end

addEventHandler ( "onColShapeHit", self.SchrankeCol, bind(SchrankeSystem.BindPlayerKey,self))
addEventHandler ( "onColShapeLeave", self.SchrankeCol, bind(SchrankeSystem.UnBindPlayerKey,self))
end



function SchrankeSystem:BindPlayerKey(player, matchingDimension)
	if getElementType ( player ) == "player" then  
		if self.Fraction == player.Fraction or not self.Fraction then
			self:Open()
		end

		bindKey(player,"horn","down",self.HornOpen)
	end
end



function SchrankeSystem:UnBindPlayerKey(player, matchingDimension)
	if getElementType ( player ) == "player" then  

		unbindKey(player,"horn","down",self.HornOpen)
	end
end









function SchrankeSystem:Open()

if ( self.SchrankeStatus == "zu" ) then
				moveObject(self.SchrankeObject,self.moveTime,self.x,self.y,self.z+0.7, 0, self.move1 ,0,"OutBack")
				self.SchrankeStatus = "auf" 

				
					setTimer( function()
						moveObject(self.SchrankeObject,self.moveTime,self.x,self.y,self.z+0.7, 0, self.move2 ,0,"OutBounce")
						setTimer( 
							function() self.SchrankeStatus = "zu" end ,self.moveTime,1)
							end , self.closeTime,1 )		
			end
			
end




