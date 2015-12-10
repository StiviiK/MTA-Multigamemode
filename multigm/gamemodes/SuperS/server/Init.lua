SuperS = inherit(Gamemode)

SuperS.ms_Settings = {
  Spawn = {
    Position  = Vector3(0, 0, 3);
    Rotation  = 0;
    Interior  = 0;
  };
  DownloadPath = RNS_DOWNLOAD_FILE;
  TranslationFile = "gamemodes/SuperS/res/translation/en/server.po";
}

function SuperS:getSetting(key)
  return self.ms_Settings[key]
end

-- Shorten function
function SuperS:get(...) return self:getSetting(...) end
