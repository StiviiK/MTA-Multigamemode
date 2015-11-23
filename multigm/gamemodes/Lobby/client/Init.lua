Lobby = inherit(Gamemode)
Lobby.ms_Settings = {
  TranslationFile = "gamemodes/Lobby/res/translation/en/client.po";
  HeaderPath = "gamemodes/Lobby/res/images/HeaderLobby.png";
  Spawn = {
    Position  = Vector3(1717.84912, -1651.28259, 20.23014);
    Rotation  = 223.45709228516;
    Interior = 18;
  };
  GamemodePedPositions = {
    Vector3(1713.793, -1655.604, 20.222);
    Vector3(1713.793, -1663.490, 20.222);
    Vector3(1729.256, -1647.652, 20.222);
    Vector3(1729.256, -1655.511, 20.222);
  };
  GamemodePedRotations = {
    Vector3(0, 0, -90);
    Vector3(0, 0, -90);
    Vector3(0, 0, 90);
    Vector3(0, 0, 90);
  };
  GamemodePedSkins = {
    {0};
    {280, 281, 282, 283, 284, 285, 286};
    {163, 164, 165, 166};
    {0}
  }
}

function Lobby:getSetting(key)
  return self.ms_Settings[key]
end

-- Shorten function
function Lobby:get(...) return self:getSetting(...) end
