function CS_DEMOLITION:constructor()
--Handler--
  addRemoteEvents{"CS_DEMOLITION_PlayerTeamSelected","CS_DEMOLITION_PlayerTeamRemove"}
  
  addEventHandler("CS_DEMOLITION_PlayerTeamSelected", root, bind(CS_DEMOLITION.PlayerTeamSelected, self))
  addEventHandler("CS_DEMOLITION_PlayerTeamRemove"  , root, bind(CS_DEMOLITION.PlayerTeamRemove, self))
  
  self.CS_MapLoader = CS_MapLoader:new()
  
  -- outputChatBox("CS_DEMOLITION:constructor CLIENT")

   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))
end

function CS_DEMOLITION:destructor()
delete(CS_MapLoader:getSingleton())
end

function CS_DEMOLITION:PlayerTeamSelected()

end

function CS_DEMOLITION:PlayerTeamRemove()

end

function CS_DEMOLITION:onPlayerJoin()
  -- Change HelpBar Text
  -- HelpBar:getSingleton():setText(HelpTexts.Gamemodes.CnR)
end

function CS_DEMOLITION:onPlayerLeft()

end


