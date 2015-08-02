Lobby = inherit(Gamemode)
Lobby.ms_Settings = {}

function Lobby:getSetting(key)
  return self.ms_Settings[key]
end
