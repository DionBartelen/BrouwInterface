
class BrouwInfo {
  static List<BrouwInfo> allData = List.empty(growable: true);

  final DigitalOutputs digitalOutputs;
  final Temperatures temperatures;
  final Modes modes;
  final Brouw brouw;

  BrouwInfo({
    required this.digitalOutputs,
    required this.temperatures,
    required this.modes,
    required this.brouw,
  });

  factory BrouwInfo.fromJson(Map<String, dynamic> json) {
    return BrouwInfo(
      digitalOutputs: DigitalOutputs.fromJson(json['digitalOutputs']),
      temperatures: Temperatures.fromJson(json['temperatures']),
      modes: Modes.fromJson(json['modes']),
      brouw: Brouw.fromJson(json['brouw']),
    );
  }
}

class DigitalOutputs {
  final int pomp;
  final int plaat;
  final int klein;
  final int groot;

  DigitalOutputs({
    required this.pomp,
    required this.plaat,
    required this.klein,
    required this.groot,
  });

  factory DigitalOutputs.fromJson(Map<String, dynamic> json) {
    return DigitalOutputs(
      pomp: json['pomp'],
      plaat: json['plaat'],
      klein: json['klein'],
      groot: json['groot'],
    );
  }
}

class Temperatures {
  final double wort;
  final double pomp;

  Temperatures({
    required this.wort,
    required this.pomp,
  });

  factory Temperatures.fromJson(Map<String, dynamic> json) {
    return Temperatures(
      wort: json['wort'].toDouble(),
      pomp: json['pomp'].toDouble(),
    );
  }
}

class Modes {
  final int verwarm;
  final int pomp;
  final int tempWort;
  final int tempPomp;

  Modes({
    required this.verwarm,
    required this.pomp,
    required this.tempWort,
    required this.tempPomp,
  });

  factory Modes.fromJson(Map<String, dynamic> json) {
    return Modes(
      verwarm: json['verwarm'],
      pomp: json['pomp'],
      tempWort: json['temp_wort'],
      tempPomp: json['temp_pomp'],
    );
  }

}

class Brouw {
  final int brouwMode;
  final int loopWachtMode;
  final int cyclusTijd;
  final int percentageAan;

  Brouw({
    required this.brouwMode,
    required this.loopWachtMode,
    required this.cyclusTijd,
    required this.percentageAan,
  });

  factory Brouw.fromJson(Map<String, dynamic> json) {
    return Brouw(
      brouwMode: json['brouwMode'],
      loopWachtMode: json['loopWachtMode'],
      cyclusTijd: json['cyclusTijd'],
      percentageAan: json['percentageAan'],
    );
  }
}