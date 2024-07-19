


extension AddressFormatter on String {
  String get divideAddressInto3Lines {
    final parts = split(' ');
    final postalCodeIndex =
        parts.indexWhere((part) => RegExp(r'^\d{2}-\d{3}$').hasMatch(part));
    final streetStartIndex =
        parts.indexWhere((part) => RegExp('^ul.').hasMatch(part));
    final postalCodeAndCity = parts.sublist(postalCodeIndex).join(' ');
    final streetAddress =
        parts.sublist(streetStartIndex, postalCodeIndex).join(' ');
    final name = parts.sublist(0, streetStartIndex).join(' ');
    return '$name\n$streetAddress\n$postalCodeAndCity';
  }
}
