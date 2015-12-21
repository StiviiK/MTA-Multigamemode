CS_DEMOLITION = inherit(Gamemode)
CS_DEMOLITION.ms_Settings = {
  TranslationFile = "gamemodes/CS/res/translation/en/client.po";
  GamemodeLobbyMenu_BG = "gamemodes/CS/res/images/Demolition_bg.jpg",
  GamemodeLobbyMenu_Color = {200,100,0,100},
  GamemodeLobbyMenu_Type  = "Demolition"
}

function CS_DEMOLITION:getSetting(key)
  return self.ms_Settings[key]
end

-- Shorten function
function CS_DEMOLITION:get(...) return self:getSetting(...) end