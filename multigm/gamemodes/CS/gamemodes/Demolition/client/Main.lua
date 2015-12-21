function CS_DEMOLITION:constructor()
--Handler--

  outputChatBox("CS_DEMOLITION:constructor CLIENT")

   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))
end

function CS_DEMOLITION:destructor()

end

function CS_DEMOLITION:onPlayerJoin()
  -- Change HelpBar Text
  -- HelpBar:getSingleton():setText(HelpTexts.Gamemodes.CnR)
end

function CS_DEMOLITION:onPlayerLeft()

end


