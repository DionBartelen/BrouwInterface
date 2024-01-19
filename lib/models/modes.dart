import 'package:brouw/enums/pomp_modes.dart';
import 'package:brouw/enums/temp_modes.dart';
import 'package:brouw/enums/verwarm_modes.dart';

class Modes {
  final VerwarmModes verwarmMode;
  final PompModes pompMode;
  final TempModes tempWort;
  final TempModes tempPomp;

  Modes({
    required this.verwarmMode,
    required this.pompMode,
    required this.tempWort,
    required this.tempPomp,
  });

  factory Modes.fromJson(Map<String, dynamic> json) {
    return Modes(
      verwarmMode: VerwarmModes.getByValue(json['verwarm']),
      pompMode: PompModes.getByValue(json['pomp']),
      tempWort: TempModes.getByValue(json['temp_wort']),
      tempPomp: TempModes.getByValue(json['temp_pomp']),
    );
  }
}