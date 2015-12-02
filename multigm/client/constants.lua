screenX, screenY = guiGetScreenSize()
screenWidth, screenHeight = guiGetScreenSize()
ASPECT_RATIO_MULTIPLIER = (screenWidth/screenHeight)/1.8

LOREM_IPSUM = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."

HelpTexts = {
  General = {
    Main = {
      title = "vMultigamemode";
      text = "vMultigamemode ist ein moderner Multigamemode, dieser wird von StiviK geschrieben und\nadministriert. Das Ziel dieses MG ist es viele verschiedene und aber auch im Typ verschiedene Gamemodes zusammen zu bringen, somit ist von Race bis DM alles dabei! Die einzelenen Gamemodes werden aber auch von anderen Spielern aus der Community, geschrieben und\nadministriert! Dieses Projekt wird verwaltet via GIT auf GitLab.com. Das Projekt befindet sich seit ca. Setember 2015 in Entwicklung, und wird auch immernoch weiterhin weiter Entwickelt. Die aktuelle Version ist derzeit %s.\n\nDie Entwickler der einzelen Gamemodes sind folgende:\nvMG-Kern: StiviK\nCops'n'Robbers: Piccolo\nRenegade Squad: StiviK";
      format = {("%sdev"):format(VERSION)};
    };
    AccountType = {
      title = "Account-Typ";
      text = LOREM_IPSUM
    };
  };
  Game = {
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
    RnS = {
      title = "Renegade Squad";
      text = LOREM_IPSUM;
    };
  }
}
