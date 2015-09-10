CopsnRobbers = inherit(Gamemode)
CopsnRobbers.ms_Settings = {
  HeaderPath = "gamemodes/CnR/files/images/HeaderCnR.png"
}

function CopsnRobbers:getSetting(key)
  return self.ms_Settings[key]
end
