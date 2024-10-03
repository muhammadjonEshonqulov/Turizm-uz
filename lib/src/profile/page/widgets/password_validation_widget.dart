import 'package:flutter/material.dart';
import 'package:turizm_uz/core/res/const_colors.dart';

import '../../../../core/services/password_validation.dart';

class PasswordValidationWidget extends StatelessWidget {
  final PasswordValidationResult validationResult;

  const PasswordValidationWidget({super.key, required this.validationResult});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildValidationRow('Maydon to\'ldirilishi shart', validationResult.isFilled),
        _buildValidationRow('Kamida bitta bosh harf (A-Z)', validationResult.hasUppercase),
        _buildValidationRow('Kamida bitta kichik harf (a-z)', validationResult.hasLowercase),
        _buildValidationRow('Kamida bitta maxsus belgi (@, #, \$, %)', validationResult.hasSpecialCharacter),
      ],
    );
  }

  Widget _buildValidationRow(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check : Icons.close,
          color: isValid ? colorPrimary : colorRed,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: isValid ? colorPrimary : colorRed,
          ),
        ),
      ],
    );
  }
}
