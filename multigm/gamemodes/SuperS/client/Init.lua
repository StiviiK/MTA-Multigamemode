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
