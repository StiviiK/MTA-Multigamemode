CopsnRobbers = inherit(Gamemode)
CopsnRobbers.ms_Settings = {
  SpawnCops = {
    Position  = Vector3(1550.53 ,-1675.54 ,15.44);
    Rotation  = 90;
    Interior = 0;
  };

    SpawnRobbers = {
    Position  = Vector3(2509 ,-1676  , 14);
    Rotation  = 90;
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
