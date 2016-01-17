CS_DEMOLITION = inherit(Gamemode)
CS_DEMOLITION.ms_Settings = {
  TranslationFile = "gamemodes/CS/res/translation/en/server.po";
}

function CS_DEMOLITION:getSetting(key)
  return self.ms_Settings[key]
end

-- Shorten function
function CS_DEMOLITION:get(...) return self:getSetting(...) end
