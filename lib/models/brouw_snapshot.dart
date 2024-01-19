import 'package:brouw/enums/brouw_modes.dart';
import 'package:brouw/enums/wacht_modes.dart';

class BrouwSnapshot {
  final BrouwModes brouwMode;
  final WachtModes loopWachtMode;
  final int cyclusTijd;
  final int percentageAan;

  BrouwSnapshot({
    required this.brouwMode,
    required this.loopWachtMode,
    required this.cyclusTijd,
    required this.percentageAan,
  });

  factory BrouwSnapshot.fromJson(Map<String, dynamic> json) {
    return BrouwSnapshot(
      brouwMode: BrouwModes.getByValue(json['brouwMode']),
      loopWachtMode: WachtModes.getByValue(json['loopWachtMode']),
      cyclusTijd: json['cyclusTijd'],
      percentageAan: json['percentageAan'],
    );
  }
}