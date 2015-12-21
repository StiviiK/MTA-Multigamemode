function CS_Deathmath:constructor()
   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))
  -- outputChatBox("CS_Deathmath:constructor",player,0,255,0)
end

function CS_Deathmath:destructor()

end

function CS_Deathmath:onPlayerJoin(player)
outputChatBox("CS_Deathmath:onPlayerJoin",player,0,255,0)
end

function CS_Deathmath:onPlayerLeft(player)
outputChatBox("CS_Deathmath:onPlayerLeft",player,0,255,0)
end






