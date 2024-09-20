import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_colors.dart';

import '../../../core/res/const_icons.dart';
import '../../../core/services/chuck.dart';
import '../../login/page/login_page.dart';
import '../../main/page/main_page.dart';
import '../../onbording/page/onboarding_page.dart';
import '../../registration/page/registration_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = false;
  bool _animateTop = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      // navKey.currentState?.pushAndRemoveUntil(CupertinoPageRoute(builder: (_) => const RegistrationPage()), (route) => false);
      // navKey.currentState?.pushAndRemoveUntil(CupertinoPageRoute(builder: (_) => const OnboardingScreen()), (route) => false);
      // navKey.currentState?.pushAndRemoveUntil(CupertinoPageRoute(builder: (_) => const LoginPage()), (route) => false);
      // navKey.currentState?.pushAndRemoveUntil(CupertinoPageRoute(builder: (_) => const RegistrationPage()), (route) => false);
      navKey.currentState?.pushAndRemoveUntil(CupertinoPageRoute(builder: (_) => const MainPage()), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorPrimary,
      body: Center(
        child: AnimatedSlide(
          offset: Offset(0, _animateTop ? -1.4 : 0),
          duration: const Duration(seconds: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(ConstIcons.logo),
              const Gap(24),
              textPoppins("Turizm.uz",24, color: colorWhite, fontWeight: FontWeight.w700),
            ],
          ),
        ),
      ),
    );
  }
}
