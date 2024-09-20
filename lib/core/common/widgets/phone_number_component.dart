import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:turizm_uz/core/res/const_colors.dart';

class PhoneNumberComponent extends StatefulWidget {
  const PhoneNumberComponent({
    super.key,
    required this.controller,
    this.onChanged,
    this.hintText,
    this.labelTextString,
    this.fillColor,
    this.isUnderlined,
  });

  final TextEditingController controller;
  final Function(String tel)? onChanged;
  final String? hintText;
  final String? labelTextString;
  final Color? fillColor;
  final bool? isUnderlined;

  @override
  State<PhoneNumberComponent> createState() => _PhoneNumberComponentState();
}

class _PhoneNumberComponentState extends State<PhoneNumberComponent> {
  late MaskTextInputFormatter mask;
  String? errorText;
  Color borderColor = colorPrimary;

  late FocusNode _focusNode;
  String _hintText = "+998 (__) ___ __ __";

  // List of valid operator codes
  final List<String> validOperatorCodes = ['90', '91', '93', '94', '95', '97', '98', '99', '33', '50', '55', '88', '77'];

  @override
  void initState() {
    super.initState();
    mask = MaskTextInputFormatter(
      mask: "(##) ### ## ##",
    );

    if (widget.controller.text.isNotEmpty) {
      widget.controller.text = mask.maskText(widget.controller.text.substring(3));
    }

    widget.controller.addListener(_applyMask);

    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        if (_focusNode.hasFocus) {
          _hintText = "(__) ___ __ __";
        } else {
          _hintText = "+998 (__) ___ __ __";
        }
      });
    });
  }

  void _applyMask() {
    final text = widget.controller.text;

    if (text.length >= 3) {
      final operatorCode = text.substring(1, 3);

      setState(() {
        if (validOperatorCodes.contains(operatorCode)) {
          borderColor = text.length == 14 ? colorGreen : colorPrimary;
          errorText = text.length == 14 ? null : 'phone_number_error'.tr();
        } else {
          errorText = 'phone_number_operator_error'.tr();
          widget.controller.clear();
        }
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    widget.controller.removeListener(_applyMask);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var borderRadius = const BorderRadius.all(Radius.circular(10));

    return TextFormField(
      controller: widget.controller,
      maxLines: 1,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(9),
        mask,
      ],
      onChanged: (value) {
        if (widget.onChanged != null) {
          value = value.replaceAll(RegExp(r'[\D]'), '');
          widget.onChanged!(value);
        }
      },
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value?.isEmpty ?? false) {
          setState(() {
            errorText = 'phone_number'.tr();
          });
        }
        return null;
      },
      style: TextStyle(color: colorBlack, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
      focusNode: _focusNode,
      decoration: InputDecoration(
        fillColor: widget.fillColor,
        hintStyle: TextStyle(color: colorGreyCC, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
        filled: true,
        prefixText: !_focusNode.hasFocus ? null : "+998 ",
        labelText: widget.labelTextString,
        prefixStyle: TextStyle(color: colorBlack, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
        hintText: _hintText,
        errorText: errorText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: widget.isUnderlined == true ? const UnderlineInputBorder() : OutlineInputBorder(borderRadius: borderRadius),
        enabledBorder: widget.isUnderlined == true ? UnderlineInputBorder(borderSide: BorderSide(color: colorGreyCC)) : OutlineInputBorder(borderRadius: borderRadius, borderSide: BorderSide(color: colorGreyCC)),
        focusedBorder: widget.isUnderlined == true ? UnderlineInputBorder(borderSide: BorderSide(color: borderColor)) : OutlineInputBorder(borderRadius: borderRadius, borderSide: BorderSide(color: borderColor)),
      ),
    );
  }
}
