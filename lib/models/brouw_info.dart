import 'package:brouw/models/brouw_snapshot.dart';
import 'package:brouw/models/digital_outputs.dart';
import 'package:brouw/models/modes.dart';
import 'package:brouw/models/temperatures.dart';

class BrouwInfo {

  final DigitalOutputs digitalOutputs;
  final Temperatures temperatures;
  final Modes modes;
  final BrouwSnapshot brouwSnapshot;

  BrouwInfo({
    required this.digitalOutputs,
    required this.temperatures,
    required this.modes,
    required this.brouwSnapshot,
  });

  factory BrouwInfo.fromJson(Map<String, dynamic> json) {
    return BrouwInfo(
      digitalOutputs: DigitalOutputs.fromJson(json['digitalOutputs']),
      temperatures: Temperatures.fromJson(json['temperatures']),
      modes: Modes.fromJson(json['modes']),
      brouwSnapshot: BrouwSnapshot.fromJson(json['brouw']),
    );
  }
}