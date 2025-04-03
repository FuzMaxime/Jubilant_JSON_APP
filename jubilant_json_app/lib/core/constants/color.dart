import 'dart:ui';

//Gestion centralisé des couleurs
class ColorConstant {
  static Color orange = hexToColor("#EB6E06");
  static Color green = hexToColor("#18A197");
  static Color yellow = hexToColor("#F9B234");
  static Color black = hexToColor("#1D1B20");
  static Color darkGrey = hexToColor("#444444");
  static Color lightGrey = hexToColor("#E6E6E6");
  static Color white = hexToColor("#fffefb");
  static Color cardBg = hexToColor("#FAFAFA");
}

//transformation de l'hexadécimal en coleur utilisable
Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
