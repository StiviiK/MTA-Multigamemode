function genPublicKey(player, accountname)
	return hash("md5", ("%s->%s->%s"):format(getRealTime().timestamp, getPlayerIP(player), accountname))
end

function genFriendId(Id, accountname)
	return hash("md5", ("%s->%s"):format(Id, accountname))
end
