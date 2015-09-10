CopsnRobbers = inherit(Gamemode)
CopsnRobbers.ms_Settings = {
  HeaderPath = "gamemodes/CopsnRobbers/files/images/HeaderLobby.png"
}

function CopsnRobbers:getSetting(key)
  return self.ms_Settings[key]
end
