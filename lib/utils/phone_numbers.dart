extension PhoneNumbers on String {
  String toPolishPohoneNumber() {
    final String number = replaceAll("<p>", "").replaceAll("</p>", "");
    if (number.length != 9) return "+48 $this";
    return "+48 ${number.substring(0, 3)} ${number.substring(3, 6)} ${number.substring(6, 9)}";
  }
}
