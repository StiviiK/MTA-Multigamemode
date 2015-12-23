SuperS = inherit(Gamemode)
SuperS.ms_Settings = {
  HeaderPath = "gamemodes/SuperS/res/images/HeaderSuperS.png";
  TranslationFile = "gamemodes/SuperS/res/translation/en/client.po";
}

function SuperS:getSetting(key)
  return self.ms_Settings[key]
end

-- Shorten function
function SuperS:get(...) return self:getSetting(...) end


-- CONSTANTS
WEAPON_STATE_READY = "ready"
WEAPON_STATE_FIRING = "firing"
WEAPON_STATE_RELOADING = "reloading"

-- Add Help Text
HelpTexts.Gamemodes.SuperS = {
  title = "Super Sweeper";
  text = "Willkommen bei Super-Sweeper! Hier erlebst du eine völlig neue Art von Spaß und Entertainment! Schau dich am besten erst einmal in der Lobby um, bevor du mit Hilfe von zahlreichen Waffen und Items in den Kampf gegen andere Sweeper trittst. Nach der erfolgreichen Schlacht kannst du deine hart verdienten Sweeper-Punkte in sinnvolle Tunings und optische Feinheiten für deinen fahrbaren Untersatz umwandeln. Also los, hör auf die Hilfe zu lesen und werde der neue Super Sweeper!/n//n/Developer:/n/Source Code: MasterM/n/Code Edit: StiviK";
};
