enum VerwarmModes {

  // Enum with number values
  AUTO(0),
  ALLES(1),
  KLEIN_EN_GROOT(2),
  KLEIN_EN_PLAAT(3),
  GROOT_EN_PLAAT(4),
  KLEIN(5),
  GROOT(6),
  PLAAT(7),
  UIT(8);

  const VerwarmModes(this.value);
  final int value;

  String makeReadable() {
    String name = toString().replaceAll("_", " ").split(".")[1];
    // Capitalize first letter
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }

  static VerwarmModes getByValue(int value) {
    return VerwarmModes.values.firstWhere((element) => element.value == value);
  }
}