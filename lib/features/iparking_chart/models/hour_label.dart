extension type HourLabel(double numericalPoint) implements double {
  HourLabel.parse(String time)
      : numericalPoint = _convertToNumericalRepresentation(time);

  String toStringRepr() {
    final hours = numericalPoint.floor();
    final minutes = ((numericalPoint - hours) * 60).round();
    return '$hours:${minutes.toString().padLeft(2, '0')}';
  }

  static double _convertToNumericalRepresentation(String time) {
    List<String> parts = time.split(":");
    if (parts.length < 2) return 0;
    int hours = int.tryParse(parts[0]) ?? 0;
    int minutes = int.tryParse(parts[1]) ?? 0;
    return hours + (minutes / 60);
  }
}
