import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/buttons.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_colors.dart';

import '../../registration/page/widgets.dart';

class OwnerDetailsPage extends StatefulWidget {
  const OwnerDetailsPage({super.key, required this.onNext});

  final Function() onNext;

  @override
  State<OwnerDetailsPage> createState() => _OwnerDetailsPageState();
}

class _OwnerDetailsPageState extends State<OwnerDetailsPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text16Poppins('Mehmonxona egasi ma’lumotlari'),
          const Gap(24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.circular(8.0)),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textField(fullNameController, 'Ism va familiya ', (v) {}, isUnderlined: true, errorText: 'Ushbu qator to’ldirilishi shart', isRequired: true),
                  phone(
                    phoneController,
                    (v) {},
                    isUnderlined: true,
                  ),
                  textField(emailController, 'E-mail ', (v) {}, isUnderlined: true, errorText: 'Ushbu qator to’ldirilishi shart', isEmail: true, isRequired: true),
                  const Gap(24),
                  defSecondaryButton('Davom etish', () {
                    if (_formKey.currentState?.validate() == true) {
                      widget.onNext.call();
                    }
                  }),
                  const Gap(16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
