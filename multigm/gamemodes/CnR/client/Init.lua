CopsnRobbers = inherit(Gamemode)
CopsnRobbers.ms_Settings = {
  HeaderPath = "gamemodes/CnR/files/images/HeaderCnR.png";
  TranslationFile = "gamemodes/CnR/files/translation/en/client.po";
}

function CopsnRobbers:getSetting(key)
  return self.ms_Settings[key]
end

-- Shorten function
function CopsnRobbers:get(...) return self:getSetting(...) end
