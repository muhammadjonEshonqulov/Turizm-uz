import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/src/profile/page/widgets/otp_security_bottomsheet.dart';

import '../../../core/common/widgets/buttons.dart';
import '../../../core/common/widgets/text_widgets.dart';
import '../../../core/res/const_colors.dart';
import '../../../core/services/chuck.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {






  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: const Offset(-8, 0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: CircleAvatar(
                      radius: 20,
                      backgroundColor: colorPrimary,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: colorWhite,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const Gap(16),
                text16Poppins('Xavfsizlik'),
                const Gap(24),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          text14Poppins('Parol'),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: colorWhite,
                                    builder: (context) {
                                      return const OtpSecurityBottomSheet();
                                    });
                              },
                              child: text12Poppins('O’zgartirish', color: colorPrimary)),
                        ],
                      ),
                      const Gap(4),
                      text12Poppins('*********', color: colorGrey7F),
                      const Gap(8),
                      Divider(color: colorGreyF2, height: 1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
