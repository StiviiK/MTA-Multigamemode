


function CopsnRobbers:setPlayerFraction(player,Fraction)
	if  Fraction == "1" or  Fraction == "2" then
		Fraction = tonumber(Fraction)
	end
if Fraction == CNR_Fraction_Name[1] then
Fraction = CNR_Fraction_ID[Fraction]
elseif Fraction == CNR_Fraction_Name[2] then
Fraction = CNR_Fraction_ID[Fraction]
else
	if CNR_Fraction_ID[CNR_Fraction_Name[Fraction]] == Fraction or CNR_Fraction_ID[CNR_Fraction_Name[Fraction]] == Fraction then
	
	else
	outputDebugString("Error:setPlayerFraction wrong argument player:"..tostring(player:getName()).." | Fraction:"..tostring(Fraction))
	return 
	end
end

 -- DebugOutPut("setPlayerFraction Player:"..tostring(player:getName()).." | Fraction:"..tostring(Fraction),0,255,0)

setElementData(player,"Fraction",Fraction)
end

function CopsnRobbers:getPlayerFraction(player)
return tonumber(getElementData(player,"Fraction")) or false
end