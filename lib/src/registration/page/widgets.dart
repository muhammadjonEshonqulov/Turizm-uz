import 'package:flutter/material.dart';
import 'package:turizm_uz/core/common/widgets/phone_number_component.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_colors.dart';

Widget phone(TextEditingController phoneController, Function(String) onChanged, {bool? isUnderlined}) {
  return PhoneNumberComponent(
    fillColor: colorWhite,
    controller: phoneController,
    onChanged: onChanged,
    isUnderlined: isUnderlined,
  );
}

