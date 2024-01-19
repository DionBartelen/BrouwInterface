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

  String pompState() {
    return _parseState(pomp);
  }

  String plaatState() {
    return _parseState(plaat);
  }

  String kleinState() {
    return _parseState(klein);
  }

  String grootState() {
    return _parseState(groot);
  }

  String _parseState(int state) {
    return state == 1 ? "aan" : "uit";
  }
}