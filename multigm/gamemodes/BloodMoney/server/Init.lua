BloodMoney = inherit(Gamemode)

BloodMoney.ms_Settings = {
  Spawn = {
    Position  = Vector3(0, 0, 3);
    Rotation  = 0;
    Interior  = 0;
  };
  DownloadPath = BLM_DOWNLOAD_FILE;
  TranslationFile = "gamemodes/BloodMoney/res/translation/en/server.po";
}

function BloodMoney:getSetting(key)
  return self.ms_Settings[key]
end

-- Shorten function
function BloodMoney:get(...) return self:getSetting(...) end
