function CopsnRobbers:SpawnFractionVehicles ()
local FilePath = false
local Frak = false
	for i = 1,2 do

	  if i == 1 then
		 FilePath = "gamemodes/CnR/server/Fraction_Cars/Fraction_Cops.Cars"
		 Frak = "Cops"
	  else
		 FilePath = "gamemodes/CnR/server/Fraction_Cars/Fraction_Robbers.Cars"
		 Frak = "Robbers"
	  end
	  
	  if not fileExists(FilePath) then return end
	  
	  local xml = XML.load(FilePath)
	
		  for k in pairs(xml:getChildren()) do
			local child
			child = xml:findChild("vehicle", k-1)
			if child then
				local attributes = child:getAttributes()
			  
				local id = attributes["id"]
				local paintjob = attributes["paintjob"]
				local alpha = attributes["alpha"]
				local model = attributes["model"]
				local plate = attributes["plate"]
				local position = Vector3(attributes["posX"], attributes["posY"], attributes["posZ"])
				local rotation = Vector3(attributes["rotX"], attributes["rotY"], attributes["rotZ"])
				local color = split(attributes["color"], ",")

				self:CreateFractionVehicle(Frak,model,position,rotation,color)	  
			end
		  end
	end
end