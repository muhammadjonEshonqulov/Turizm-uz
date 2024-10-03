import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/src/profile/page/widgets/password_validation_widget.dart';
import 'package:turizm_uz/src/registration/page/widgets.dart';

import '../../../../core/common/widgets/buttons.dart';
import '../../../../core/common/widgets/text_widgets.dart';
import '../../../../core/services/chuck.dart';
import '../../../../core/services/password_validation.dart';

class ChangePasswordBottomSheet extends StatefulWidget {
  const ChangePasswordBottomSheet({super.key});

  @override
  State<ChangePasswordBottomSheet> createState() => _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState extends State<ChangePasswordBottomSheet> {
  var key = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  late PasswordValidationResult passwordValidation;

  @override
  void initState() {
    super.initState();
    passwordValidation = validatePassword(passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: text16Poppins('Parolni o’zgartirish', textAlign: TextAlign.center)),
                    IconButton(
                        onPressed: () {
                          navKey.currentState?.pop();
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
                Gap(32),
                textField(passwordController, 'Yangi parolni kiriting *', (v) {
                  setState(() {
                    passwordValidation = validatePassword(v);
                  });
                }, isUnderlined: true, isPassword: true, errorText: 'sd'),
                PasswordValidationWidget(validationResult: passwordValidation),
                Gap(32),
                defSecondaryButton('Tasdiqlash', () {
                  if (key.currentState?.validate() == true) {
                    navKey.currentState?.pop();
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
