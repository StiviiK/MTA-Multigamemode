SchrankeSystem = {}

function SchrankeSystem:constructor (x,y,z,rx,ry,rz,ColRadius,moveTime,closeTime,richtung,Fraction )

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
self.SchrankeObject:setDimension(CNR_DIM)
self.SchrankeObjectUnten:setDimension(CNR_DIM)


self.SchrankeCol = createColSphere ( x,y,z, ColRadius )
self.SchrankeCol:setDimension(CNR_DIM)

self.SchrankeStatus = "zu"


	if self.richtung == 1 then
		self.move1 = -90
		self.move2 = 90
		else
		self.move1 = 90
		self.move2 = -90
	end

addEventHandler ( "onColShapeHit", self.SchrankeCol, bind(SchrankeSystem.BindPlayerKey,self))

end



function SchrankeSystem:BindPlayerKey(player, matchingDimension)
if self.Fraction == player.Fraction or not self.Fraction then
	self:Open()
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


new(SchrankeSystem,1544.68,-1630.79,12.315,0,270,269.929,10,3000,1000,0,"Cops")


