function CS_BOMB_DEFUSAL:constructor()
   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))
  -- outputChatBox("CS_BOMB_DEFUSAL:constructor",player,0,255,0)
end

function CS_BOMB_DEFUSAL:destructor()

end

function CS_BOMB_DEFUSAL:onPlayerJoin(player)
outputChatBox("CS_BOMB_DEFUSAL:onPlayerJoin",player,0,255,0)
end

function CS_BOMB_DEFUSAL:onPlayerLeft(player)
outputChatBox("CS_BOMB_DEFUSAL:onPlayerLeft",player,0,255,0)
end





