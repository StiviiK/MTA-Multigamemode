Teleports = {};


function Teleports:constructor(StartPos,StartRot,StartInt,StartDim,EndPos,EndRot,EndInt,EndDim,twoway,model)
  self.StartPickup = Pickup.create( StartPos,3,model,1)
  
  self.StartCol = ColShape.Sphere ( StartPos, 1.3 )
  self.TeleportStatus = true
  self.StartPickup:setDimension(StartDim)
  self.StartPickup:setInterior(StartInt)
  self.StartCol:setDimension(StartDim)
  self.StartCol:setInterior(StartInt)

  function self.onColShapeHit_Start(theElement,matchingDim)
	if self.TeleportStatus and matchingDim then
		 self.TeleportStatus = false
		 setTimer ( function() self.TeleportStatus = true end, 1000, 1 )
		 
		local x = EndPos.x+1.5*math.cos(math.rad(EndRot.z+180+90))
		local y = EndPos.y+1.5*math.sin(math.rad(EndRot.z+180+90))
		
		 theElement:setPosition(x,y,EndPos.z)
		 theElement:setRotation(0,0,EndRot.z+180)
		 theElement:setDimension(EndDim)
		 theElement:setInterior(EndInt)

	 end
end 
addEventHandler ( "onColShapeHit", self.StartCol,self.onColShapeHit_Start)

if twoway then
 self.EndCol = ColShape.Sphere ( EndPos, 1.3 )
 self.EndPickup = Pickup.create   (EndPos,3,model,1)
 self.EndCol:setDimension(EndDim)
 self.EndCol:setInterior(EndInt)
 
 self.EndPickup:setDimension(EndDim)
 self.EndPickup:setInterior(EndInt)
 
					 function self.onColShapeHit_End(theElement,matchingDim)
						if self.TeleportStatus and matchingDim then
							self.TeleportStatus = false
							setTimer ( function() self.TeleportStatus = true end, 1000, 1 )
							
							
							local x = StartPos.x+1.5*math.cos(math.rad(StartRot.z+180+90))
							local y = StartPos.y+1.5*math.sin(math.rad(StartRot.z+180+90))
							
							 theElement:setPosition(x,y,StartPos.z)
							 theElement:setRotation(0,0,StartRot.z+180)
							 theElement:setDimension(StartDim)
							 theElement:setInterior(StartInt)
							
						end
					end 
					addEventHandler ( "onColShapeHit", self.EndCol, self.onColShapeHit_End)


end

return self
end

function Teleports:Delete ()
removeEventHandler ( "onColShapeHit", self.EndCol  , self.onColShapeHit_End)
removeEventHandler ( "onColShapeHit", self.StartCol, self.onColShapeHit_Start)
destroyElement (self.StartPickup)
destroyElement (self.EndPickup)

destroyElement ( self.StartCol)
destroyElement ( self.EndCol)

end




function CreateTeleport (TeleportsTable)

	local StartPos 		   = Vector3(unpack(TeleportsTable["FistPos"]))
	local StartRot         = Vector3(unpack(TeleportsTable["FistRot"]))
	local StartInt         = TeleportsTable["FistInt"] 
	local StartDim         = TeleportsTable["FistDim"]
	
	local EndPos           = Vector3(unpack(TeleportsTable["LastPos"]))
	local EndRot           = Vector3(unpack(TeleportsTable["LastRot"]))
	local EndInt       	   = TeleportsTable["LastInt"] 
	local EndDim       	   = TeleportsTable["LastDim"]
	local TwoWay           = TeleportsTable["TwoWay"]
	local PickupModel	   = TeleportsTable["PickupModel"]
	local TeleportText     = TeleportsTable["TeleportName"]

AddTeleportToScript ("\n--local "..TeleportText.." = new(Teleports,Vector3("..StartPos.x..","..StartPos.y..","..StartPos.z.."),Vector3(0,0,"..StartRot.z.."),"..StartInt..","..StartDim..",Vector3("..EndPos.x..","..EndPos.y..","..EndPos.z.."),Vector3(0,0,"..EndRot.z.."),"..EndInt..","..EndDim..","..tostring(TwoWay)..","..PickupModel..")",255,0,0)
new(Teleports,StartPos,StartRot,StartInt,StartDim,EndPos,EndRot,EndInt,EndDim,TwoWay,PickupModel)
end
addEvent("CreateTeleport", true)
addEventHandler("CreateTeleport", root, CreateTeleport)

function AddTeleportToScript (TeleportText)




outputChatBox(TeleportText)



-- outputChatBox("Write")

-- local hFile = fileOpen ( "gamemodes/CnR/TeleportMaker/TeleportsListe.lua")
-- if hFile then  
	 -- local buffer
    -- while not fileIsEOF(hFile) do             
        -- buffer = fileRead(hFile, 500)  
    -- end
                                
    -- fileWrite(hFile, buffer.."\n"..TeleportText)
    -- fileClose(hFile)                        
-- else
    -- outputChatBox("Unable to open TeleportsListe.lua")
-- end

end
