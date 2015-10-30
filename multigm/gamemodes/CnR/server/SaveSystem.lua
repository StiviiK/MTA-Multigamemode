--TODO


function CopsnRobbers:Save_Player(player)
local pos 		= player:getPosition()
local rot 		= player:getRotation()
local Money 	= player:getMoney()
local Skin 		= player:getModel()
local Fraction  = self:GetPlayerFraktion(player)
local Weapons   = "xxxxxxx"
local Dim  		= player:getDimension()
local Int  		= player:getInterior()

-----------CNR_DEBUG---------------
DebugOutPut( "Pos"..":"..tostring(pos.x)..","..tostring(pos.y)..","..tostring(pos.z) )
-----------------------------------
end

function CopsnRobbers:Load_Player(player)

player:triggerEvent("CreateFractionSelectMenu",player)

end