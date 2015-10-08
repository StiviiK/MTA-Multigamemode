CopsnRobbers = inherit(Gamemode)
CopsnRobbers.ms_Settings = {
  HeaderPath = "gamemodes/CnR/res/images/HeaderCnR.png";
  TranslationFile = "gamemodes/CnR/res/translation/en/client.po";
}

function CopsnRobbers:getSetting(key)
  return self.ms_Settings[key]
end

-- Shorten function
function CopsnRobbers:get(...) return self:getSetting(...) end