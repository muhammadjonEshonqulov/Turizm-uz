import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_colors.dart';
import 'package:turizm_uz/core/res/const_icons.dart';

import '../../../core/common/widgets/buttons.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                OnboardingPage(
                  image: ConstIcons.onboarding1,
                  title: 'Xush kelibsiz',
                  description: 'O’zbekistonga unutilmas sayohatni boshlang! Ilovamiz orqali siz barcha kerakli joylarni oson topishingiz mumkin. ',
                  currentPage: _currentPage,
                ),
                OnboardingPage(
                  image: ConstIcons.onboarding2,
                  title: 'Kerakli joylarni Tez Toping!',
                  description: 'Mehmonxonalarning keng tanlovi, narxlari va sharhlarini ko‘rib, eng yaxshisini tanlang. Qulay va ishonchli joylarni topish endi juda oson!',
                  currentPage: _currentPage,
                ),
                OnboardingPage(
                  image: ConstIcons.onboarding3,
                  title: 'Lokatsiyangiz Orqali Yaqin Joylarni Toping!',
                  description: 'Lokatsiyangiz asosida yaqin atrofdagi mehmonxonalar, ATMlar, va sayyohlik maskanlarini toping.',
                  currentPage: _currentPage,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => buildDot(index, context)),
            ),
          ),
          defaultButton('Keyingisi', () {
            _controller.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
          }),
          ghostButton('O’tkazib yuborish', () {}),
          const Gap(10)
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: _currentPage == index ? Border.all(color: colorWhite.withOpacity(0.48), width: 2) : null,
        color: _currentPage == index ? colorPrimary : colorGreyF6,
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final int currentPage;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Gap(MediaQuery.of(context).size.height * 0.1),
          SvgPicture.asset(image),
          const Spacer(),
          const Gap(30),
          textPoppins(title, 24, fontWeight: FontWeight.w700, textAlign: TextAlign.center),
          const Gap(20),
          text16Poppins(description, textAlign: TextAlign.center, color: colorGrey7F, fontWeight: FontWeight.w400),
          const Spacer(),
        ],
      ),
    );
  }
}
