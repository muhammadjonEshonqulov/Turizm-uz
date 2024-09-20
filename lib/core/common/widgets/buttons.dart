import 'package:flutter/material.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_colors.dart';

Widget defaultButton(String text, VoidCallback onPressed) {
  return SizedBox(
    height: 48,
    // margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), backgroundColor: colorPrimary, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      child: text16Poppins(text, fontWeight: FontWeight.w600, color: colorWhite),
    ),
  );
}

Widget borderedButton(String text, VoidCallback onPressed) {
  return SizedBox(
    height: 48,
    // margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), backgroundColor: colorWhite, elevation: 0, shape: RoundedRectangleBorder(side: BorderSide(color: colorPrimary, width: 1), borderRadius: BorderRadius.circular(8))),
      child: text16Poppins(text, fontWeight: FontWeight.w600, color: colorPrimary),
    ),
  );
}

Widget disabledButton(String text) {
  return SizedBox(
    height: 48,
    // margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    width: double.infinity,
    child: ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), backgroundColor: colorGreyF6, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      child: text16Poppins(text, fontWeight: FontWeight.w600, color: colorGreyA9),
    ),
  );
}

Widget ghostButton(String text, VoidCallback onPressed) {
  return SizedBox(
    height: 48,
    // margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), backgroundColor: colorWhite, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      child: text16Poppins(text, fontWeight: FontWeight.w600, color: colorPrimary),
    ),
  );
}
