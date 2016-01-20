function CS_BOMB_DEFUSAL:constructor()
--Handler--
  addRemoteEvents{"CS_BOMB_DEFUSAL_PlayerTeamSelected","CS_BOMB_DEFUSAL_PlayerTeamRemove"}
  
  addEventHandler("CS_BOMB_DEFUSAL_PlayerTeamSelected", root, bind(CS_BOMB_DEFUSAL.PlayerTeamSelected, self))
  addEventHandler("CS_BOMB_DEFUSAL_PlayerTeamRemove"  , root, bind(CS_BOMB_DEFUSAL.PlayerTeamRemove  , self))
  -- outputChatBox("CS_BOMB_DEFUSAL:constructor CLIENT")
  
  self.CS_MapLoader = CS_MapLoader:new()
  
   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))
end

function CS_BOMB_DEFUSAL:destructor()
delete(CS_MapLoader:getSingleton())
end

function CS_BOMB_DEFUSAL:PlayerTeamSelected()

end

function CS_BOMB_DEFUSAL:PlayerTeamRemove()

end

function CS_BOMB_DEFUSAL:onPlayerJoin()
  -- Change HelpBar Text
  -- HelpBar:getSingleton():setText(HelpTexts.Gamemodes.CnR)
end

function CS_BOMB_DEFUSAL:onPlayerLeft()

end


