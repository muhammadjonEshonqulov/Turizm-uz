import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_colors.dart';
import 'package:turizm_uz/core/res/const_icons.dart';
import 'package:turizm_uz/core/services/chuck.dart';
import 'package:turizm_uz/src/add_business/page/register_new_org.dart';

class SelectBusinessTypePage extends StatefulWidget {
  const SelectBusinessTypePage({super.key});

  @override
  State<SelectBusinessTypePage> createState() => _SelectBusinessTypePageState();
}

class _SelectBusinessTypePageState extends State<SelectBusinessTypePage> {
  int selectedIndex = 0;

  final List<Map<String, String>> businessTypes = [
    {'icon': ConstIcons.bed, 'label': 'Mehmonxonalar'},
    {'icon': ConstIcons.wineglassTriangle, 'label': 'Restoranlar'},
    {'icon': ConstIcons.bag, 'label': 'Savdo markazlari'},
    {'icon': ConstIcons.mingcuteCarFill, 'label': 'Ijaraga avtomobil'},
    {'icon': ConstIcons.globus, 'label': 'Sayyohlik xizmatlari'},
    {'icon': ConstIcons.artStudio, 'label': 'Art studio'},
    {'icon': ConstIcons.swimming, 'label': 'Aqua park'},
    {'icon': ConstIcons.gamePad, 'label': 'O’yin klubi'},
    {'icon': ConstIcons.zooPark, 'label': 'Hayvonot bog’i'},
    {'icon': ConstIcons.cart, 'label': 'Oziq-ovqatlar'},
    {'icon': ConstIcons.cup, 'label': 'Kafelar'},
    {'icon': ConstIcons.mingcuteCarFill, 'label': 'Motel'},
    {'icon': ConstIcons.mingcuteCarFill, 'label': 'Uy mehmonxonasi'},
    {'icon': ConstIcons.stethoscope, 'label': 'Shifoxonalar'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBackground,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
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
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text16Poppins('Biznes turini tanlang'),
                  IconButton(
                    icon: SvgPicture.asset(ConstIcons.notification),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: businessTypes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      Future.delayed(const Duration(milliseconds: 300)).then((value) => navKey.currentState?.push(CupertinoPageRoute(builder: (_) => const RegisterNewOrg())));
                    },
                    child: Container(
                      decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.circular(8), border: Border.all(width: 1, color: index == selectedIndex ? colorPrimary : colorGreyF2)),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SvgPicture.asset(businessTypes[index]['icon'] ?? '', height: 24),
                                const Gap(10),
                                text12Poppins(businessTypes[index]['label'].toString()),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: SvgPicture.asset(index == selectedIndex ? ConstIcons.selectedRadio : ConstIcons.unSelectedRadio, width: 20),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
