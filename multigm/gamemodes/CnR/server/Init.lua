CopsnRobbers = inherit(Gamemode)
CopsnRobbers.ms_Settings = {
  Spawn = {
    Position  = Vector3(0, 0, 3);
    Rotation  = 0;
    Interior = 0;
  };
  DownloadPath = CNR_DOWNLOAD_FILE;
}

function CopsnRobbers:getSetting(key)
  return self.ms_Settings[key]
end
