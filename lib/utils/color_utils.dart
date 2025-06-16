import 'dart:ui';

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");

  if (hexColor.length == 6) {
    hexColor = "FF$hexColor"; // Add full opacity
  }

  return Color(int.parse(hexColor, radix: 16));
}
