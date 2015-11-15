--TODO


function CopsnRobbers:Save_Player(player)
local Pos 		= player:getPosition()
local rot 		= player:getRotation()

local Position 		= toJSON ( { ["x"] = Pos.x , ["y"] = Pos.y , ["z"] = Pos.z , ["rot"] = rot.z  } )

local Money 	= player:getMoney()
local Skin 		= player:getModel()
local Fraction  = "Cops"--self:GetPlayerFraktion(player)

local Int  		= player:getInterior()
local Dim  		= player:getDimension()

local Weapons   = "xxxxxxx"


	local row = sql:queryFetchSingle("SELECT Name FROM ??_CnR WHERE Name = ? ", sql:getPrefix(), player:getAccount():getName())
     if not row or not row.Name then
		--INSERT
	sql:queryExec("INSERT INTO multigm_CnR (Name, Position, Skin, Fraction, Weapons, Dimension, Interior) VALUES (?,?,?,?,?,?,?);", player:getAccount():getName(), Position ,Skin ,Fraction ,Weapons ,Dim ,Int )

	else
		--Update
	sql:queryExec("UPDATE multigm_CnR SET Position = ?, Skin = ?, Fraction = ?, Weapons = ?, Dimension = ?, Interior = ? WHERE Name = ?;", Position ,Skin ,Fraction ,Weapons ,Dim ,Int, player:getAccount():getName())

	end

-----------CNR_DEBUG---------------
--DebugOutPut( "Pos"..":"..tostring(pos.x)..","..tostring(pos.y)..","..tostring(pos.z) )
-----------------------------------
end

function CopsnRobbers:Load_Player(player)

	local row = sql:queryFetchSingle("SELECT * FROM ??_CnR WHERE Name = ? ", sql:getPrefix(), player:getAccount():getName())
     if  not row or  not row.Name then

		-- Default

		player:triggerEvent("CreateFractionSelectMenu",player)

	 else

		  local Position = fromJSON(row.Position)
		  self:SpawnPlayer(player,Position.x,Position.y,Position.z,Position.rot,row.Interior,player:getDimension(),row.Skin,row.Fraction)
  	 end


end
