CS_BOMB_DEFUSAL = inherit(Gamemode)
CS_BOMB_DEFUSAL.ms_Settings = { 
  TranslationFile = "gamemodes/CS/res/translation/en/server.po";
}

function CS_BOMB_DEFUSAL:getSetting(key)
  return self.ms_Settings[key]
end

-- Shorten function
function CS_BOMB_DEFUSAL:get(...) return self:getSetting(...) end
