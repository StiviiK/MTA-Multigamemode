
CNR_DEBUG = false

function DebugOutPut (Text,r,g,b)

if not r or not g or not b then
	r,g,b = 255,255,255
end

	if CNR_DEBUG then
		if SERVER then
			outputChatBox("CNR_DEBUG SERVER: "..Text,getRootElement(),r,g,b)
		else
			outputChatBox("CNR_DEBUG CLIENT:"..Text,tocolor(r,g,b))
		end
		
	end
end


if SERVER and CNR_DEBUG then

	function SavePosition (player)
		local pos = {getElementPosition(player)}
		local rot = {getElementRotation(player)}
		local int = getElementInterior(player)
		local dim = getElementDimension(player)
			 local playeraccount = getPlayerAccount ( player )
				 if ( playeraccount ) and not isGuestAccount ( playeraccount ) then
				setAccountData ( playeraccount, "PosX", pos[1] )
				setAccountData ( playeraccount, "PosY", pos[2] )
				setAccountData ( playeraccount, "PosZ", pos[3] )
				
				setAccountData ( playeraccount, "Rot", rot[3] )
				setAccountData ( playeraccount, "Int", int )
				setAccountData ( playeraccount, "Dim", dim )
				
				outputChatBox(("Save : %s , %s , %s"):format(pos[1],pos[2],pos[3]))
				end
		
	end

	
	function LoadPosition (player)
	local playeraccount = getPlayerAccount ( player )
		if ( playeraccount ) and getAccountData ( playeraccount, "PosX" ) and not isGuestAccount ( playeraccount ) then
		
			local PosX = getAccountData ( playeraccount, "PosX" )
			local PosY = getAccountData ( playeraccount, "PosY" )
			local PosZ = getAccountData ( playeraccount, "PosZ" )
			
			local rot = getAccountData ( playeraccount, "Rot" )
			local int = getAccountData ( playeraccount, "Int" )
			local dim = getAccountData ( playeraccount, "Dim" )
			
			outputChatBox(("load : %s , %s , %s"):format(PosX,PosY,PosZ))
			
			setElementPosition(player,PosX,PosY,PosZ)
			setElementRotation(player,0,0,rot)
			setElementInterior(player,int)
			setElementDimension(player,dim)

		end
		
	end

end





