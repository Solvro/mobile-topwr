String formatBool({required String key, required bool? value}) {
  if (value == null) {
    return "Nieznane";
  }

  switch (key) {
    case "isMain":
      return value ? "To jest wejście główne" : "To nie jest wejście główne";
    case "isAccessible":
      return value ? "Wejście jest dostępne" : "Wejście jest niedostępne";
    case "isForPersonel":
      return value
          ? "Wejście wymaga specjalnych uprawnień"
          : "Wejście nie wymaga specjalnych uprawnień";
    case "isBuildingMarkedFromEntrance":
      return value
          ? "Budynek jest oznaczony od strony wejścia"
          : "Budynek nie jest oznaczony od strony wejścia";
    case "isBuildingMarkedInEn":
      return value
          ? "Budynek jest oznaczony w języku angielskim"
          : "Budynek nie jest oznaczony w języku angielskim";
    case "isLit":
      return value ? "Wejście jest oświetlone" : "Wejście nie jest oświetlone";
    case "isEmergencyExit":
      return value
          ? "Wejście jest ewakuacyjne"
          : "Wejście nie jest ewakuacyjne";
    case "isProtectionFromWeather":
      return value
          ? "Wejście jest chronione przed warunkami atmosferycznymi"
          : "Wejście nie jest chronione przed warunkami atmosferycznymi";
    case "isSolidSurface":
      return value
          ? "Teren przed wejściem jest równy"
          : "Teren przed wejściem nie jest równy";
    case "areDifferentTypesOfSurface":
      return value
          ? "Przed wejściem znajdują się różne rodzaje nawierzchni"
          : "Przed wejściem nie znajdują się różne rodzaje nawierzchni";
    case "areBenches":
      return value
          ? "Przed wejściem znajdują się ławki"
          : "Przed wejściem nie znajdują się ławki";
    case "hasSoundTransmitter":
      return value
          ? "Przy wejściu znajduje się znacznik dźwiękowy systemu nawigacyjno-informacyjnego"
          : "Przy wejściu nie znajduje się znacznik dźwiękowy systemu nawigacyjno-informacyjnego";
    case "hasTactilePaving":
      return value
          ? "Przed wejściem znajdują się ścieżki naprowadzające"
          : "Przed wejściem nie znajdują się ścieżki naprowadzające";
    default:
      return "";
  }
}
