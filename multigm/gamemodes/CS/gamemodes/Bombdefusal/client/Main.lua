function CS_BOMB_DEFUSAL:constructor()
--Handler--

  outputChatBox("CS_BOMB_DEFUSAL:constructor CLIENT")

   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))
end

function CS_BOMB_DEFUSAL:destructor()

end

function CS_BOMB_DEFUSAL:onPlayerJoin()
  -- Change HelpBar Text
  -- HelpBar:getSingleton():setText(HelpTexts.Gamemodes.CnR)
end

function CS_BOMB_DEFUSAL:onPlayerLeft()

end


