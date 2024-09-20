import "package:flutter/material.dart";

import "../../res/const_colors.dart";

Text text16Poppins(String text, {Color? color, int? maxLines, TextOverflow? overflow, TextAlign? textAlign, FontWeight? fontWeight, TextDecoration? decoration}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: TextStyle(
      color: color ?? colorDefTex,
      decoration: decoration,
      decorationColor: color ?? colorDefTex,
      height: 1.5,
      fontSize: 16,
      fontFamily: 'Poppins',
      fontWeight: fontWeight ?? FontWeight.w500,
      // height: 0.07,
    ),
  );
}

Text textPoppins(String text, double fontSize, {Color? color, int? maxLines, TextOverflow? overflow, TextAlign? textAlign, FontWeight? fontWeight, TextDecoration? decoration}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: TextStyle(
      color: color ?? colorDefTex,
      fontSize: fontSize,
      decorationColor: color ?? colorDefTex,
      decoration: decoration,
      height: 1.5,
      fontFamily: 'Poppins',
      fontWeight: fontWeight ?? FontWeight.w600,
      // height: 0.07,
    ),
  );
}

Text text18Poppins(String text, {Color? color, int? maxLines, TextOverflow? overflow, TextAlign? textAlign, FontWeight? fontWeight, TextDecoration? decoration}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: TextStyle(
      color: color ?? colorDefTex,
      decorationColor: color ?? colorDefTex,
      decoration: decoration,
      height: 1.5,
      fontSize: 18,
      fontFamily: 'Poppins',
      fontWeight: fontWeight ?? FontWeight.w600,
      // height: 0.07,
    ),
  );
}

Text text22Poppins(String text, {Color? color, int? maxLines, TextOverflow? overflow, TextAlign? textAlign, FontWeight? fontWeight, TextDecoration? decoration}) {
  return Text(
    text,
    textAlign: textAlign ?? TextAlign.start,
    maxLines: maxLines,
    overflow: overflow,
    // textAlign: TextAlign.start,
    style: TextStyle(
      color: color ?? colorDefTex,
      decorationColor: color ?? colorDefTex,
      decoration: decoration,
      height: 1.5,
      fontSize: 22,
      fontFamily: 'Poppins',
      fontWeight: fontWeight ?? FontWeight.w600,
    ),
  );
}

Text text20Poppins(String text, {Color? color, int? maxLines, TextOverflow? overflow, TextAlign? textAlign, FontWeight? fontWeight, TextDecoration? decoration}) {
  return Text(
    text,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: textAlign ?? TextAlign.start,
    style: TextStyle(
      color: color ?? colorDefTex,
      decorationColor: color ?? colorDefTex,
      decoration: decoration,
      height: 1.5,
      fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: fontWeight ?? FontWeight.w600,
    ),
  );
}

Text text14Poppins(String text, {Color? color, Key? key, int? maxLines, TextOverflow? overflow, TextAlign? textAlign, FontWeight? fontWeight, TextDecoration? decoration}) {
  return Text(
    text,
    maxLines: maxLines,
    overflow: overflow,
    key: key,
    textAlign: textAlign,
    style: TextStyle(
      overflow: TextOverflow.ellipsis,
      color: color ?? colorDefTex,
      decorationColor: color ?? colorDefTex,
      decoration: decoration,
      height: 1.5,
      fontSize: 14,
      fontFamily: 'Poppins',
      fontWeight: fontWeight ?? FontWeight.w400,
    ),
  );
}

Text text15Poppins(String text, {Color? color, int? maxLines, TextOverflow? overflow = TextOverflow.ellipsis, TextAlign? textAlign, FontWeight? fontWeight, Key? key, TextDecoration? decoration}) {
  return Text(
    text,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: textAlign,
    key: key,
    style: TextStyle(
      overflow: TextOverflow.ellipsis,
      color: color ?? colorDefTex,
      decorationColor: color ?? colorDefTex,
      decoration: decoration,
      height: 1.5,
      fontSize: 15,
      fontFamily: 'Poppins',
      fontWeight: fontWeight ?? FontWeight.w400,
    ),
  );
}

Text text12Poppins(String text, {Color? color, int? maxLines, TextOverflow? overflow, FontWeight? fontWeight, TextDecoration? decoration}) {
  return Text(
    text,
    maxLines: maxLines,
    overflow: overflow,
    style: TextStyle(
      overflow: TextOverflow.ellipsis,
      color: color ?? colorDefTex,
      decorationColor: color ?? colorDefTex,
      decoration: decoration,
      height: 1.5,
      fontSize: 12,
      fontFamily: 'Poppins',
      fontWeight: fontWeight ?? FontWeight.w400,
    ),
  );
}

Text text11Poppins(String text, {Color? color, int? maxLines, TextOverflow? overflow, FontWeight? fontWeight, TextDecoration? decoration}) {
  return Text(
    text,
    maxLines: maxLines,
    overflow: overflow,
    style: TextStyle(
      overflow: TextOverflow.ellipsis,
      color: color ?? colorDefTex,
      decorationColor: color ?? colorDefTex,
      decoration: decoration,
      height: 1.5,
      fontSize: 11,
      fontFamily: 'Poppins',
      fontWeight: fontWeight ?? FontWeight.w400,
    ),
  );
}

Text text10Poppins(String text, {Color? color, int? maxLines, TextOverflow? overflow, FontWeight? fontWeight, TextDecoration? decoration}) {
  return Text(
    text,
    maxLines: maxLines,
    overflow: overflow,
    style: TextStyle(
      overflow: TextOverflow.ellipsis,
      color: color ?? colorDefTex,
      decorationColor: color ?? colorDefTex,
      decoration: decoration,
      height: 1.5,
      fontSize: 10,
      fontFamily: 'Poppins',
      fontWeight: fontWeight ?? FontWeight.w400,
    ),
  );
}

Text text13Poppins(String text, {Color? color, int? maxLines, TextOverflow? overflow, FontWeight? fontWeight, TextDecoration? decoration}) {
  return Text(
    text,
    maxLines: maxLines,
    overflow: overflow,
    style: TextStyle(
      overflow: TextOverflow.ellipsis,
      color: color ?? colorDefTex,
      decoration: decoration,
      decorationColor: color ?? colorDefTex,
      height: 1.5,
      fontSize: 13,
      fontFamily: 'Poppins',
      fontWeight: fontWeight ?? FontWeight.w400,
    ),
  );
}
