enum BrouwModes {

  // Enum with number values, so u can actually map different values
  // Basing it on the index works, except if you would want a different order.
  // And no more magic numbers :D
  UIT(0),
  LOOP_WACHT(1),
  AUTO(2);

  const BrouwModes(this.value);
  final int value;

  String makeReadable() {
    String name = toString().replaceAll("_", " ").split(".")[1];
    // Capitalize first letter
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }

  static BrouwModes getByValue(int value) {
    return BrouwModes.values.firstWhere((element) => element.value == value);
  }
}