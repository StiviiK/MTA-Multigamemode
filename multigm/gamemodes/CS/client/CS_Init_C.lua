CS = inherit(Gamemode)
CS.ms_Settings = {
  HeaderPath           = "gamemodes/CS/res/images/HeaderCnR.png";
  TranslationFile      = "gamemodes/CS/res/translation/en/client.po";
}

function CS:getSetting(key)
  return self.ms_Settings[key]
end

-- Shorten function
function CS:get(...) return self:getSetting(...) end

-- Add Help Text
HelpTexts.Gamemodes.CS = {
  title = "CS";
  text = LOREM_IPSUM;
}
