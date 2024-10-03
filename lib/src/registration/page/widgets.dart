import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:turizm_uz/core/common/widgets/phone_number_component.dart';
import 'package:turizm_uz/core/common/widgets/text_field_component.dart';
import 'package:turizm_uz/core/res/const_colors.dart';

Widget phone(TextEditingController phoneController, Function(String) onChanged, {bool? isUnderlined}) {
  return PhoneNumberComponent(
    fillColor: colorWhite,
    controller: phoneController,
    onChanged: onChanged,
    isUnderlined: isUnderlined,
    labelTextString: 'Telefon raqam',
  );
}

Widget textField(TextEditingController textFieldController, String label, Function(String) onChanged, {bool? isUnderlined, String? errorText, bool? isEmail, bool? isRequired, bool? isPassword, bool? isEnabled, TextInputType? keyboardType, List<TextInputFormatter>? formatters}) {
  return TextFieldComponent(
    fillColor: colorWhite,
    controller: textFieldController,
    onChanged: onChanged,
    isUnderlined: isUnderlined,
    labelTextString: label,
    errorText: errorText,
    isEmail: isEmail,
    isRequired: isRequired,
    isPassword: isPassword,
    isEnabled: isEnabled,
    keyboardType: keyboardType,
    formatters: formatters,
  );
}
