import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/buttons.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/common/widgets/un_focus_widget.dart';
import 'package:turizm_uz/core/res/const_colors.dart';
import 'package:turizm_uz/core/services/chuck.dart';

import '../../../core/common/widgets/text_field_component.dart';
import '../../../core/res/const_icons.dart';
import '../../registration/page/otp_page.dart';
import '../../registration/page/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                Align(alignment: Alignment.centerLeft, child: SvgPicture.asset(ConstIcons.logo, colorFilter: ColorFilter.mode(colorPrimary, BlendMode.srcIn), height: 64)),
                const Gap(25),
                textPoppins('Kirish', 24, fontWeight: FontWeight.w700),
                text14Poppins('Davom etish uchun iltimos \nakkauntingizga kiring', color: colorGreyA9),
                const Gap(30),
                phone(phoneController, (value) {}, isUnderlined: true),
                const Gap(15),
                TextFieldComponent(controller: passwordController, isUnderlined: true, isPassword: true, hintText: 'Parol'),
                const Gap(8.0),
                Align(alignment: Alignment.centerRight, child: InkWell(onTap: () {}, child: text12Poppins('Parolni unutdingizmi?'))),
                const Gap(30),
                defPriButton('Kirish', () {}),
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
