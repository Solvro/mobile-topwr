import "package:test/test.dart";
import "package:topwr/theme/colors.dart";

void main() {

  test("Hex color values should be the same when using converter", () {
    final colorValues = {
      ColorsConsts.blackMirage: "#293241",
      ColorsConsts.whiteSoap: "#FFFDFC",
      ColorsConsts.orangePomegranade: "#E43D32",
      ColorsConsts.greyPigeon: "#76859D",
      ColorsConsts.greyLight: "#F7F7F8",
      ColorsConsts.blueAzure: "#3F6499",
    };
    colorValues.forEach((color, expectedHex) {
      final actualColorHexValue = color.hexString;
      expect(actualColorHexValue, expectedHex.toUpperCase());
    });
  });
}
