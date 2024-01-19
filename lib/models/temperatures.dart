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