import 'package:flutter/cupertino.dart';
import 'package:turizm_uz/core/res/const_colors.dart';


class ConstBoxShadows {
  static List<BoxShadow> boxShadows = [
    BoxShadow(
      color: colorGreyF0.withOpacity(0.2),
      spreadRadius: 0,
      blurRadius: 4,
      offset: const Offset(0, 3),
    ),
  ];

  static List<BoxShadow> boxShadowsForItem = [
    BoxShadow(
      color: colorGreyF0.withOpacity(0.2),
      spreadRadius: 0,
      blurRadius: 4,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> boxShadowsForFinanceItem({
    Color? shadowColor,
    double? opacity,
    double? blurRadius,
    double? dy,
  }) =>
      [
        BoxShadow(
          color: (shadowColor ?? colorGreyF0).withOpacity(opacity ?? 0.2),
          spreadRadius: 0,
          blurRadius: blurRadius ?? 6,
          offset: Offset(0, dy ?? 4),
        ),
      ];
}
