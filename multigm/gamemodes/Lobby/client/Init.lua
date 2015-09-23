Lobby = inherit(Gamemode)
Lobby.ms_Settings = {
  HeaderPath = "gamemodes/Lobby/files/images/HeaderLobby.png";
  Spawn = {
    Position  = Vector3(1717.84912, -1651.28259, 20.23014);
    Rotation  = 223.45709228516;
    Interior = 18;
  };
  TranslationFile = "gamemodes/Lobby/files/translation/en/client.po";
}

function Lobby:getSetting(key)
  return self.ms_Settings[key]
end

-- Shorten function
function Lobby:get(...) return self:getSetting(...) end
