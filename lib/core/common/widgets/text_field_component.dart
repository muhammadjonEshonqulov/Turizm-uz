import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turizm_uz/core/res/const_colors.dart';

import '../../res/const_icons.dart';

class TextFieldComponent extends StatefulWidget {
  const TextFieldComponent({
    super.key,
    required this.controller,
    this.onChanged,
    this.hintText,
    this.labelTextString,
    this.fillColor,
    this.isUnderlined,
    this.errorText,
    this.isPassword,
  });

  final TextEditingController controller;
  final Function(String tel)? onChanged;
  final String? hintText;
  final String? labelTextString;
  final Color? fillColor;
  final bool? isUnderlined;
  final bool? isPassword;
  final String? errorText;

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  Color borderColor = colorPrimary;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    var borderRadius = const BorderRadius.all(Radius.circular(10));

    return TextFormField(
      controller: widget.controller,
      maxLines: 1,
      obscureText: widget.isPassword == true ? obscureText : false,
      style: TextStyle(color: colorBlack, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
      decoration: InputDecoration(
        fillColor: widget.fillColor ?? colorWhite,
        hintStyle: TextStyle(color: colorGreyCC, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
        filled: true,
        labelText: widget.labelTextString,
        hintText: widget.hintText,
        suffixIcon: IconButton(
          padding: EdgeInsetsDirectional.zero,
          iconSize: 24,
          icon: SvgPicture.asset(
            obscureText ? ConstIcons.eye : ConstIcons.eyeHide,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(colorGreyA9, BlendMode.srcIn),
          ),
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
        ),
        errorText: widget.errorText,
        contentPadding: const EdgeInsets.all(10),
        border: widget.isUnderlined == true ? const UnderlineInputBorder() : OutlineInputBorder(borderRadius: borderRadius),
        enabledBorder: widget.isUnderlined == true ? UnderlineInputBorder(borderSide: BorderSide(color: colorGreyCC)) : OutlineInputBorder(borderRadius: borderRadius, borderSide: BorderSide(color: colorGreyCC)),
        focusedBorder: widget.isUnderlined == true ? UnderlineInputBorder(borderSide: BorderSide(color: borderColor)) : OutlineInputBorder(borderRadius: borderRadius, borderSide: BorderSide(color: borderColor)),
      ),
    );
  }
}
