CS_BOMB_DEFUSAL = inherit(Gamemode)

CS_BOMB_DEFUSAL.ms_Settings = {
  TranslationFile = "gamemodes/CS/res/translation/en/client.po";
  GamemodeLobbyMenu_BG = "gamemodes/CS/res/images/Bombdefusal_bg.jpg",
  GamemodeLobbyMenu_Color = {0,100,200,100},
  GamemodeLobbyMenu_Type  = "Bombe Defuse"
}

function CS_BOMB_DEFUSAL:getSetting(key)
  return self.ms_Settings[key]
end

-- Shorten function
function CS_BOMB_DEFUSAL:get(...) return self:getSetting(...) end