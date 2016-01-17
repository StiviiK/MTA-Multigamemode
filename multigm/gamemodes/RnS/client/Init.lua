RenegadeSquad = inherit(Gamemode)
RenegadeSquad.ms_Settings = {
  HeaderPath = "gamemodes/RnS/res/images/HeaderLobby.png";
  TranslationFile = "gamemodes/RnS/res/translation/en/client.po";
}

function RenegadeSquad:getSetting(key)
  return self.ms_Settings[key]
end

-- Shorten function
function RenegadeSquad:get(...) return self:getSetting(...) end

-- Add Help Text
HelpTexts.Gamemodes.RnS = {
  title = "Renegade Squad";
  text = LOREM_IPSUM;
};
