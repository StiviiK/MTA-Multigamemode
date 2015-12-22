BloodMoney = inherit(Gamemode)
BloodMoney.ms_Settings = {
  HeaderPath = "gamemodes/BloodMoney/res/images/HeaderBLM.jpg";
  TranslationFile = "gamemodes/BloodMoney/res/translation/en/client.po";
}

function BloodMoney:getSetting(key)
  return self.ms_Settings[key]
end

-- Shorten function
function BloodMoney:get(...) return self:getSetting(...) end
