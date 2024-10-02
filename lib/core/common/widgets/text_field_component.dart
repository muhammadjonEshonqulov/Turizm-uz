import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_colors.dart';
import 'package:turizm_uz/core/utils/core_utils.dart';

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
    this.isEmail,
    this.isRequired,
    this.isEnabled,
    this.keyboardType,
    this.actions,
    this.formatters,
  });

  final TextEditingController controller;
  final Function(String tel)? onChanged;
  final String? hintText;
  final String? labelTextString;
  final Color? fillColor;
  final bool? isUnderlined;
  final bool? isPassword;
  final bool? isEmail;
  final bool? isRequired;
  final bool? isEnabled;
  final String? errorText;
  final TextInputType? keyboardType;
  final List<Widget>? actions;
  final List<TextInputFormatter>? formatters;

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  Color borderColor = colorPrimary;
  bool obscureText = true;
  bool? isValidate;

  @override
  Widget build(BuildContext context) {
    var borderRadius = const BorderRadius.all(Radius.circular(10));

    return TextFormField(
      controller: widget.controller,
      maxLines: 1,
      enabled: widget.isEnabled,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword == true ? obscureText : false,
      style: TextStyle(color: colorBlack, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
      validator: (value) {
        if (value?.isEmpty ?? false) {
          setState(() {
            isValidate = true;
          });
          return widget.errorText;
        }
        if (widget.isEmail == true && value != null && !isEmailValid(value)) {
          setState(() {
            isValidate = true;
          });
          return 'Iltimos, to\'g\'ri email kiriting';
        }
        setState(() {
          isValidate = false;
        });
        return null;
      },
      inputFormatters: widget.formatters,
      decoration: InputDecoration(
        fillColor: widget.fillColor ?? colorWhite,
        hintStyle: TextStyle(color: colorGreyCC, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
        filled: true,
        label: widget.isRequired == true
            ? RichText(text: TextSpan(text: widget.labelTextString, style: TextStyle(color: colorGreyA9, fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'Poppins'), children: [TextSpan(text: ' *', style: TextStyle(color: colorRed))]))
            : text12Poppins(widget.labelTextString ?? '-', color: colorGreyA9),
        hintText: widget.hintText,
        suffixIcon: widget.isPassword == true
            ? IconButton(
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
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        suffix: isValidate != null ? Icon(isValidate == true ? Icons.error_outline_rounded : Icons.check_circle_outline, size: 16, color: isValidate == false ? colorGreen : colorRed) : null,
        // labelStyle: TextStyle(color: colorGreyCC, fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
        border: widget.isUnderlined == true ? const UnderlineInputBorder() : OutlineInputBorder(borderRadius: borderRadius),
        enabledBorder: widget.isUnderlined == true ? UnderlineInputBorder(borderSide: BorderSide(color: isValidate == false ? colorGreen : colorGreyCC)) : OutlineInputBorder(borderRadius: borderRadius, borderSide: BorderSide(color: colorGreyCC)),
        focusedBorder: widget.isUnderlined == true ? UnderlineInputBorder(borderSide: BorderSide(color: borderColor)) : OutlineInputBorder(borderRadius: borderRadius, borderSide: BorderSide(color: borderColor)),
      ),
    );
  }
}
