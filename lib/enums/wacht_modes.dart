enum WachtModes {

  // Enum with number values
  ALLES(0),
  KLEIN_EN_GROOT(1),
  KLEIN_EN_PLAAT(2),
  GROOT_EN_PLAAT(3),
  KLEIN(4),
  GROOT(5),
  PLAAT(6),
  UIT(7);

  const WachtModes(this.value);
  final int value;

  String makeReadable() {
    String name = toString().replaceAll("_", " ").split(".")[1];
    // Capitalize first letter
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }

  static WachtModes getByValue(int value) {
    return WachtModes.values.firstWhere((element) => element.value == value);
  }
}