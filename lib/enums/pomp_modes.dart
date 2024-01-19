enum PompModes {

  // Enum with number values
  AUTO(0),
  HAND_AAN(1),
  HAND_UIT(2);

  const PompModes(this.value);
  final int value;

  String makeReadable() {
    String name = toString().replaceAll("_", " ").split(".")[1];
    // Capitalize first letter
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }

  static PompModes getByValue(int value) {
    return PompModes.values.firstWhere((element) => element.value == value);
  }
}