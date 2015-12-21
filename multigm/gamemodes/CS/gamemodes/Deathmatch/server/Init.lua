CS_Deathmath = inherit(Gamemode)
CS_Deathmath.ms_Settings = {
  TranslationFile = "gamemodes/CS/res/translation/en/server.po";
}

function CS_Deathmath:getSetting(key)
  return self.ms_Settings[key]
end

-- Shorten function
function CS_Deathmath:get(...) return self:getSetting(...) end
