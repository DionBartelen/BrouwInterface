enum TempModes {

  // Enum with number values
  AUTO(0),
  HAND(1);

  const TempModes(this.value);
  final int value;

  String makeReadable() {
    String name = toString().replaceAll("_", " ").split(".")[1];
    // Capitalize first letter
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }

  static TempModes getByValue(int value) {
    return TempModes.values.firstWhere((element) => element.value == value);
  }
}