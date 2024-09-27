import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/buttons.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/common/widgets/un_focus_widget.dart';
import 'package:turizm_uz/src/registration/page/widgets.dart';

import '../../../core/common/widgets/text_field_component.dart';
import '../../../core/res/const_colors.dart';
import '../../../core/res/const_icons.dart';
import '../../../core/services/chuck.dart';
import 'otp_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: OnUnFocusTap(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(30),
                Align(alignment: Alignment.centerLeft, child: SvgPicture.asset(ConstIcons.logo, colorFilter: ColorFilter.mode(colorPrimary, BlendMode.srcIn), height: 64)),
                const Gap(25),
                textPoppins('Ro’yxatdan o’tish', 24, fontWeight: FontWeight.w700),
                text14Poppins('Davom etish uchun iltimos \nro’yxatdan o’ting', color: colorGreyA9),
                const Gap(30),
                phone(phoneController, (value) {}, isUnderlined: true),
                const Gap(15),
                TextFieldComponent(controller: passwordController, isUnderlined: true, isPassword: true, hintText: 'Parol'),
                const Gap(8.0),
                Align(alignment: Alignment.centerRight, child: InkWell(onTap: () {}, child: text12Poppins('Parolni unutdingizmi?'))),
                const Gap(30),
                defPriButton('Ro’yxatdan o’tish', () {
                  navKey.currentState?.push(CupertinoPageRoute(builder: (_) => const OtpPage()));
                }),
                const Gap(16.0),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorWhite,
                        elevation: 0,
                        shape: RoundedRectangleBorder(side: BorderSide(width: 1, color: colorDefTex), borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [SvgPicture.asset(ConstIcons.google), Gap(8.0), text16Poppins('Google orqali o’tish')],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
