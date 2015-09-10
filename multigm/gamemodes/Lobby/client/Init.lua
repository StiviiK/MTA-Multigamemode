Lobby = inherit(Gamemode)
Lobby.ms_Settings = {
  HeaderPath = "gamemodes/Lobby/files/images/HeaderLobby.png"
}

function Lobby:getSetting(key)
  return self.ms_Settings[key]
end
