screenX, screenY = guiGetScreenSize()
screenWidth, screenHeight = guiGetScreenSize()
ASPECT_RATIO_MULTIPLIER = (screenWidth/screenHeight)/1.8

LOREM_IPSUM = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."

HelpTexts = {
  General = {
    Main = {
      title = "vMultigamemode";
      text = "vMultigamemode ist ein moderner Multigamemode, dieser wird von StiviK geschrieben und/n/administriert. Das Ziel dieses MG ist es viele verschiedene und aber auch im Typ verschiedene Gamemodes zusammen zu bringen, somit ist von Race bis DM alles dabei! Die einzelnen Gamemodes werden aber auch von anderen Spielern aus der Community, geschrieben und/n/administriert! Dieses Projekt wird verwaltet via GIT auf GitLab.com. Das Projekt befindet sich seit ca. September 2015 in Entwicklung, und wird auch immernoch weiterhin weiter Entwickelt. Die aktuelle Version ist derzeit %s./n//n/Beteiligte Entwickler:/n/vMG-Kern: StiviK/n/Cops'n'Robbers: Piccolo/n/Renegade Squad: StiviK";
      format = {VERSION_LABEL:gsub("vMultigamemode ", "")};
    };
    FastLobby = {
      title = "Quick-Lobby";
      text = LOREM_IPSUM;
    };
  };
  Game = {
    AccountType = {
      title = "Account-Typ";
      text = LOREM_IPSUM
    };
    JobPoints = {
      title = "Job-Points";
      text = LOREM_IPSUM
    };
  };
  Gamemodes = {
    CnR = {
      title = "Cops'n'Robbers";
      text = LOREM_IPSUM;
    };
	CS = {
      title = "CS";
      text = LOREM_IPSUM;
    };
    RnS = {
      title = "Renegade Squad";
      text = LOREM_IPSUM;
    };
  }
}
