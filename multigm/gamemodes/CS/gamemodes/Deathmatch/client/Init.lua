CS_Deathmath = inherit(Gamemode)
CS_Deathmath.ms_Settings = {
  TranslationFile = "gamemodes/CS/res/translation/en/client.po";
  GamemodeLobbyMenu_BG = "gamemodes/CS/res/images/cs_deathmatch.png",
  GamemodeLobbyMenu_Color = {200,100,200,100},
  GamemodeLobbyMenu_Type  = "Deathmatch"
}

function CS_Deathmath:getSetting(key)
  return self.ms_Settings[key]
end

-- Shorten function
function CS_Deathmath:get(...) return self:getSetting(...) end