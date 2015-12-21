CS = inherit(Gamemode)
CS.ms_Settings = {
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
  
  DownloadPath = CS_DOWNLOAD_FILE;
  TranslationFile = "gamemodes/CS/res/translation/en/server.po";
}

function CS:getSetting(key)
  return self.ms_Settings[key]
end

-- Shorten function
function CS:get(...) return self:getSetting(...) end
