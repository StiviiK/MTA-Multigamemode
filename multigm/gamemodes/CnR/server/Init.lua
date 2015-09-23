CopsnRobbers = inherit(Gamemode)
CopsnRobbers.ms_Settings = {
  Spawn = {
    Position  = Vector3(0, 0, 3);
    Rotation  = 0;
    Interior = 0;
  };
  DownloadPath = CNR_DOWNLOAD_FILE;
  TranslationFile = "gamemodes/CnR/files/translation/en/server.po";
}

function CopsnRobbers:getSetting(key)
  return self.ms_Settings[key]
end

-- Shorten function
function CopsnRobbers:get(...) return self:getSetting(...) end
