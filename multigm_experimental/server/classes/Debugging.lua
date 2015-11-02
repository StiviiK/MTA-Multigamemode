Debugging = inherit(Singleton)

function Debugging:constructor()
	addCommandHandler("drun", bind(Debugging.runString, self))
end

function Debugging:runString(player, cmd, ...)
	--if getPlayerName(player) == "Console" or player:getRank() == RANK.Developer then
		local codeString = table.concat({...}, " ")
		runString(codeString, root, player)
	--end
end
