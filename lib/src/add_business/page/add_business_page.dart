import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_colors.dart';
import 'package:turizm_uz/core/res/const_icons.dart';

import 'owner_details_page.dart';

class BusinessTypePage extends StatelessWidget {
  final List<Map<String, String>> businessTypes = [
    {'icon': ConstIcons.bed, 'label': 'Mehmonxonalar'},
    {'icon': ConstIcons.wineglassTriangle, 'label': 'Restoranlar'},
    {'icon': ConstIcons.bag, 'label': 'Savdo markazlari'},
    {'icon': ConstIcons.cashOut, 'label': 'Bankomatlar'},
    {'icon': ConstIcons.cart, 'label': 'Oziq-ovqatlar'},
    {'icon': ConstIcons.cup, 'label': 'Kafelar'},
    {'icon': ConstIcons.stethoscope, 'label': 'Shifoxonalar'},
    {'icon': ConstIcons.widget, 'label': 'Barchasi'},
  ];

  BusinessTypePage({super.key});

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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OwnerDetailsPage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.circular(8), border: Border.all(width: 1, color: index == 0 ? colorPrimary : colorGreyF2)),
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
                            child: SvgPicture.asset(index == 0 ? ConstIcons.selectedRadio : ConstIcons.unSelectedRadio, width: 20),
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
