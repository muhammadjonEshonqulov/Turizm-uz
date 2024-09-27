import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:share_plus/share_plus.dart';
import 'package:turizm_uz/core/common/widgets/buttons.dart';
import 'package:turizm_uz/core/res/const_box_shadows.dart';
import 'package:turizm_uz/core/services/chuck.dart';
import 'package:turizm_uz/core/utils/core_utils.dart';
import 'package:turizm_uz/src/calendar/page/calendar_page.dart';

import '../../../core/common/widgets/text_widgets.dart';
import '../../../core/res/const_colors.dart';
import '../../../core/res/const_icons.dart';

class HotelInfoPage extends StatefulWidget {
  const HotelInfoPage({super.key, required this.hotelName});

  final String hotelName;

  @override
  State<HotelInfoPage> createState() => _HotelInfoPageState();
}

class _HotelInfoPageState extends State<HotelInfoPage> {
  final List<String> imagePaths = [
    ConstIcons.image,
    ConstIcons.image1,
    ConstIcons.image,
    ConstIcons.image1,
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBackground,
        bottomNavigationBar: _bottomNavigationBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
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
              const Gap(16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 200,
                        child: Stack(
                          children: [
                            PageView.builder(
                              itemCount: imagePaths.length,
                              onPageChanged: (int index) {
                                setState(() {
                                  _currentPage = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    imagePaths[index],
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(imagePaths.length, (index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                    width: _currentPage == index ? 12 : 8,
                                    height: _currentPage == index ? 12 : 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentPage == index ? colorWhite : colorWhite.withOpacity(0.6),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            _galleryButton(),
                          ],
                        ),
                      ),
                      const Gap(16),
                      Row(
                        children: [
                          text16Poppins(widget.hotelName),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.share_outlined),
                            onPressed: () async {
                              await Share.share('text');
                            },
                          ),
                          const Gap(8.0),
                          IconButton(
                            icon: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(pi),
                              child: Transform.rotate(
                                angle: pi / 2,
                                child: const Icon(Icons.route_outlined),
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          _featureChip(
                            icon: SvgPicture.asset(ConstIcons.crownMinimalistic),
                            label: 'VIP',
                            borderColor: colorWarning,
                            textColor: colorWarning,
                          ),
                          _featureChip(
                            icon: SvgPicture.asset(ConstIcons.shieldCheck),
                            label: 'Xavfsizlik',
                          ),
                          _featureChip(
                            icon: SvgPicture.asset(ConstIcons.Wi_Fi_Router),
                            label: 'WiFi',
                          ),
                          _featureChip(
                            icon: SvgPicture.asset(ConstIcons.chefHat),
                            label: 'Oshxona',
                          ),
                          _featureChip(
                            icon: SvgPicture.asset(
                              ConstIcons.bedOutlined,
                              colorFilter: ColorFilter.mode(colorDefTex, BlendMode.srcIn),
                            ),
                            label: 'Shinam xonalar',
                          ),
                        ],
                      ),
                      const Gap(24),
                      text16Poppins('Manzil'),
                      const Gap(16),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: colorPrimary),
                          const Gap(4.0),
                          Expanded(
                            child: text12Poppins('Bustonsaroy St 1/4, Universitetskiy Boulevard, Samarkand', maxLines: 2),
                          ),
                        ],
                      ),
                      const Gap(24),
                      text16Poppins('Qulayliklar'),
                      const Gap(16),
                      Column(
                        children: [
                          _facilityRow('Imkoniyati cheklanganlar uchun kirish joyi'),
                          _facilityRow('Oldindan band qilish imkoniyati'),
                          _facilityRow('Nonushta'),
                          _facilityRow('Bepul avtoturargoh'),
                        ],
                      ),
                      const Gap(24),
                      text16Poppins('Mehmonxona haqida'),
                      const Gap(16),
                      text12Poppins(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut rhoncus volutpat ullamcorper. Duis egestas pharetra elit, eu dignissim urna porttitor nec. Sed facilisis lacus magna, ut pharetra lorem faucibus efficitur. Nunc placerat fringilla.',
                        maxLines: 4,
                      ),
                      const Gap(10),
                      text12Poppins('Batafsil ^', color: colorPrimary),
                      const Gap(24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          text16Poppins('Izohlar'),
                          text14Poppins('Barchasi', color: colorPrimary),
                        ],
                      ),
                      const Gap(16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _commentCard(
                              name: 'John Doe',
                              date: '23-sentyabr, 2024-yil',
                              comment: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut rhoncus volutpat ullamcorper.',
                            ),
                            _commentCard(
                              name: 'Jane Smith',
                              date: '24-sentyabr, 2024-yil',
                              comment: 'Sed facilisis lacus magna, ut pharetra lorem faucibus efficitur. Nunc placerat fringilla.',
                            ),
                          ],
                        ),
                      ),
                      const Gap(24),
                      text16Poppins('Tillar'),
                      const Gap(16),
                      Wrap(
                        children: [
                          _languageChip(iconPath: ConstIcons.us, label: 'Ingliz'),
                          _languageChip(iconPath: ConstIcons.uz, label: 'O’zbek'),
                          _languageChip(iconPath: ConstIcons.fr, label: 'Fransuz'),
                          _languageChip(iconPath: ConstIcons.ru, label: 'Rus'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _galleryButton() {
    return Positioned(
      bottom: 8,
      right: 9,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(color: colorBlack.withOpacity(0.5), borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              ConstIcons.gallery,
              width: 16,
            ),
            const Gap(4),
            text12Poppins('${imagePaths.length}', color: colorWhite),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: colorWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text16Poppins('\$100'),
              const Gap(4),
              text12Poppins('Bir kecha'),
            ],
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: defSecondaryButton('Buyurtma qilish', () {
                setStatusBarColor(color: colorWhite);
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: '',
                  pageBuilder: (context, animation1, animation2) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: colorWhite,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: ConstBoxShadows.boxShadows,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
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
                            const Gap(15),
                            text16Poppins('Savitskiy Plaza'),
                            const Gap(8),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(border: Border.all(color: colorGreyF2, width: 1), borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        navKey.currentState?.push(CupertinoPageRoute(builder: (_) => const CalendarPage()));
                                      },
                                      child: Column(
                                        children: [
                                          text12Poppins('dan'),
                                          const Gap(8),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                ConstIcons.calendar,
                                                height: 24,
                                              ),
                                              const Gap(8),
                                              text16Poppins('09.25.2024', color: colorPrimary),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: colorGreyF2,
                                    width: 1,
                                    height: 50,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        navKey.currentState?.push(CupertinoPageRoute(builder: (_) => const CalendarPage()));
                                      },
                                      child: Column(
                                        children: [
                                          text12Poppins('dan'),
                                          const Gap(8),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                ConstIcons.calendar,
                                                height: 24,
                                              ),
                                              const Gap(8),
                                              text16Poppins('09.25.2024', color: colorPrimary),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(24),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  ConstIcons.groups,
                                  height: 20,
                                ),
                                const Gap(8),
                                text14Poppins('Kattalar'),
                                const Spacer(),
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(color: colorRed, borderRadius: BorderRadius.circular(4)),
                                  child: Icon(Icons.remove_circle_outline, color: colorWhite, size: 16),
                                ),
                                const Gap(8),
                                text16Poppins('2'),
                                const Gap(8),
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(4)),
                                  child: Icon(Icons.add_circle_outline, color: colorWhite, size: 16),
                                ),
                              ],
                            ),
                            const Gap(8),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  ConstIcons.lamp,
                                  height: 20,
                                ),
                                const Gap(8),
                                text14Poppins('Xonalar'),
                                const Spacer(),
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(color: colorRed, borderRadius: BorderRadius.circular(4)),
                                  child: Icon(Icons.remove_circle_outline, color: colorWhite, size: 16),
                                ),
                                const Gap(8),
                                text16Poppins('2'),
                                const Gap(8),
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(4)),
                                  child: Icon(Icons.add_circle_outline, color: colorWhite, size: 16),
                                ),
                              ],
                            ),
                            const Gap(8),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  ConstIcons.groups,
                                  height: 20,
                                ),
                                const Gap(8),
                                text14Poppins('Bolalar'),
                                const Spacer(),
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(color: colorRed, borderRadius: BorderRadius.circular(4)),
                                  child: Icon(Icons.remove_circle_outline, color: colorWhite, size: 16),
                                ),
                                const Gap(8),
                                text16Poppins('2'),
                                const Gap(8),
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(4)),
                                  child: Icon(Icons.add_circle_outline, color: colorWhite, size: 16),
                                ),
                              ],
                            ),
                            const Gap(8),
                            Row(
                              children: [
                                SvgPicture.asset(ConstIcons.pets),
                                const Gap(8),
                                text14Poppins('Uy hayvonlari'),
                                const Spacer(),
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(color: colorRed, borderRadius: BorderRadius.circular(4)),
                                  child: Icon(Icons.remove_circle_outline, color: colorWhite, size: 16),
                                ),
                                const Gap(8),
                                text16Poppins('2'),
                                const Gap(8),
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(4)),
                                  child: Icon(Icons.add_circle_outline, color: colorWhite, size: 16),
                                ),
                              ],
                            ),
                            const Gap(24),
                            defSecondaryButton('Band qilish', () {
                              Navigator.of(context).pop();
                            }),
                            const Gap(16),
                          ],
                        ),
                      ),
                    );
                  },
                  transitionBuilder: (context, animation1, animation2, child) {
                    return SlideTransition(
                      position: Tween(
                        begin: Offset(0, -1),
                        end: Offset(0, 0),
                      ).animate(animation1),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                ).then((onValue) {
                  setStatusBarColor(color: colorPrimary);
                });
              })),
        ],
      ),
    );
  }

  Widget _featureChip({
    required Widget icon,
    required String label,
    Color? borderColor,
    Color? textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? colorDefTex, width: 1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const Gap(4),
          text12Poppins(label, color: textColor),
        ],
      ),
    );
  }

  Widget _facilityRow(String text) {
    return Row(
      children: [
        Icon(Icons.check, color: colorPrimary),
        const Gap(4),
        Expanded(
          child: text12Poppins(
            text,
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  Widget _commentCard({
    required String name,
    required String date,
    required String comment,
    int rating = 5,
  }) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorWhite,
        border: Border.all(width: 1, color: colorGreyF2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text14Poppins(name, color: colorPrimary),
          const Gap(13),
          Row(
            children: [
              for (int i = 0; i < rating; i++) Icon(Icons.star, size: 16, color: colorWarning),
              const Gap(10),
              Expanded(child: text12Poppins(date, maxLines: 2)),
            ],
          ),
          const Gap(16),
          text12Poppins(comment, maxLines: 3),
        ],
      ),
    );
  }

  Widget _languageChip({required String iconPath, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: colorGreyF2, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(iconPath),
          const Gap(8),
          text14Poppins(label),
        ],
      ),
    );
  }
}
