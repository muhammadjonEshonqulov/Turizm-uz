import 'package:flutter/material.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_colors.dart';

Widget defPriButton(String text, VoidCallback onPressed) {
  return SizedBox(
    height: 48,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), backgroundColor: colorPrimary, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
      child: text16Poppins(text, fontWeight: FontWeight.w600, color: colorWhite),
    ),
  );
}

Widget borderedPriButton(String text, VoidCallback onPressed) {
  return SizedBox(
    height: 48,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), backgroundColor: colorWhite, elevation: 0, shape: RoundedRectangleBorder(side: BorderSide(color: colorPrimary, width: 1), borderRadius: BorderRadius.circular(100))),
      child: text16Poppins(text, fontWeight: FontWeight.w600, color: colorPrimary),
    ),
  );
}

Widget disabledPriButton(String text) {
  return SizedBox(
    height: 48,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), backgroundColor: colorGreyF6, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
      child: text16Poppins(text, fontWeight: FontWeight.w600, color: colorGreyA9),
    ),
  );
}

Widget ghostPriButton(String text, VoidCallback onPressed) {
  return SizedBox(
    height: 48,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), backgroundColor: colorWhite, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
      child: text16Poppins(text, fontWeight: FontWeight.w600, color: colorPrimary),
    ),
  );
}

Widget defSecondaryButton(String text, VoidCallback onPressed) {
  return SizedBox(
    height: 48,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), backgroundColor: colorPrimary, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
      child: text14Poppins(text, fontWeight: FontWeight.w500, color: colorWhite),
    ),
  );
}

Widget borderedSecondaryButton(String text, VoidCallback onPressed) {
  return SizedBox(
    height: 48,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), backgroundColor: colorWhite, elevation: 0, shape: RoundedRectangleBorder(side: BorderSide(color: colorPrimary, width: 1), borderRadius: BorderRadius.circular(100))),
      child: text14Poppins(text, fontWeight: FontWeight.w500, color: colorPrimary),
    ),
  );
}

Widget disabledSecondaryButton(String text) {
  return SizedBox(
    height: 48,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), backgroundColor: colorGreyF6, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
      child: text14Poppins(text, fontWeight: FontWeight.w500, color: colorGreyA9),
    ),
  );
}

Widget ghostSecondaryButton(String text, VoidCallback onPressed) {
  return SizedBox(
    height: 48,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), backgroundColor: colorWhite, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
      child: text14Poppins(text, fontWeight: FontWeight.w500, color: colorPrimary),
    ),
  );
}
