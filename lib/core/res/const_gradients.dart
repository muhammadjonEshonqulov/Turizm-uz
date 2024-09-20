import 'package:flutter/cupertino.dart';

import 'const_colors.dart';

class ConstGradients {
  static const primaryGradient = LinearGradient(
    colors: [
      Color(0xFF21D4FD),
      Color(0xFFB721FF),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static var selectedGradient = LinearGradient(
    colors: [
      colorPrimary,
      colorWhite.withOpacity(0.1),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static LinearGradient selectedGradientByColor({required List<Color> colors}) => LinearGradient(
        colors: colors,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );
}
