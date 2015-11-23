function CopsnRobbers:TazerDamage( attacker, weapon )
	if attacker and weapon == 23 then
		triggerServerEvent( "onTazerShot", source )
		cancelEvent()
	end
end



