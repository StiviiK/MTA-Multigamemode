function CS_Deathmath:constructor()
--Handler--
  -- outputChatBox("CS_Deathmath:constructor CLIENT")

   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))
end

function CS_Deathmath:destructor()

end

function CS_Deathmath:onPlayerJoin()
  -- Change HelpBar Text
  -- HelpBar:getSingleton():setText(HelpTexts.Gamemodes.CnR)
end

function CS_Deathmath:onPlayerLeft()

end
