function CS_DEMOLITION:constructor()
   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))
  -- outputChatBox("CS_DEMOLITION:constructor",player,0,255,0)
end

function CS_DEMOLITION:destructor()

end

function CS_DEMOLITION:onPlayerJoin(player)
player:triggerEvent("onCS_DEMOLITIONStartDownload", player)
outputChatBox("CS_DEMOLITION:onPlayerJoin",player,0,255,0)
end

function CS_DEMOLITION:onPlayerLeft(player)
outputChatBox("CS_DEMOLITION:onPlayerLeft",player,0,255,0)
end

function CS_DEMOLITION:PlayerTeamSelected (player,Team)
triggerClientEvent(player,"CS_DEMOLITION_PlayerTeamSelected",player,player,Team)
end

function CS_DEMOLITION:PlayerTeamRemove (player,Team)
triggerClientEvent(player,"CS_DEMOLITION_PlayerTeamRemove",player,player,Team)
end
