function CS_DEMOLITION:constructor()
   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))
  outputChatBox("CS_DEMOLITION:constructor",player,0,255,0)
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




