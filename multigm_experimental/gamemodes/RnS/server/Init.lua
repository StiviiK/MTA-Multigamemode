RenegadeSquad = inherit(Gamemode)

RenegadeSquad.ms_Settings = {
  Spawn = {
    Position  = Vector3(0, 0, 3);
    Rotation  = 0;
    Interior  = 0;
  };
  DownloadPath = RNS_DOWNLOAD_FILE;
  TranslationFile = "gamemodes/RnS/res/translation/en/server.po";
}

function RenegadeSquad:getSetting(key)
  return self.ms_Settings[key]
end

-- Shorten function
function RenegadeSquad:get(...) return self:getSetting(...) end
