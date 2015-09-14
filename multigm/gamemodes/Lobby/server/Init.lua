Lobby = inherit(Gamemode)
inherit(GameRooms, Lobby)

Lobby.ms_Settings = {
  Spawn = {
    Position  = Vector3(1717.84912, -1651.28259, 20.23014);
    Rotation  = 223.45709228516;
    Interior = 18;
  };
  DownloadPath = LOBBY_DOWNLOAD_FILE;
}

function Lobby:getSetting(key)
  return self.ms_Settings[key]
end