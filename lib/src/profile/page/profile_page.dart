import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_box_shadows.dart';
import 'package:turizm_uz/core/res/const_colors.dart';
import 'package:turizm_uz/core/res/const_icons.dart';
import 'package:turizm_uz/src/profile/page/security_page.dart';

import '../../../core/services/chuck.dart';
import 'own_info_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textPoppins('Profil', 24, fontWeight: FontWeight.w700),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap:  () {
                navKey.currentState?.push(CupertinoPageRoute(builder: (_) => const OwnInfoPage()));
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    child: textPoppins('Z', 24, fontWeight: FontWeight.w700, color: colorWhite),
                  ),
                  const Gap(8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text14Poppins('Zafarjon', color: colorBlack, fontWeight: FontWeight.w500),
                      text12Poppins('Profilni ko’rsatish', color: colorGrey7F),
                    ],
                  ),
                  const Spacer(),
                  Icon(Icons.chevron_right, color: colorGrey7F)
                ],
              ),
            ),
            const Gap(24),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  ConstBoxShadows.boxShadowsForFinanceItem(
                    dy: 4,
                    blurRadius: 8,
                    shadowColor: colorGreyCC.withOpacity(0.16),
                  ).first,
                  ConstBoxShadows.boxShadowsForFinanceItem(
                    dy: -2,
                    blurRadius: 8,
                    shadowColor: colorGreyCC.withOpacity(0.16),
                  ).first,
                ],
              ),
              child: Row(
                children: [
                  text14Poppins('Biznesingizni ro’yxatdan\n o’tkazing'),
                  const Spacer(),
                  Image.asset(
                    ConstIcons.businessLogo,
                    width: 100,
                    height: 67,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            const Gap(24),
            text16Poppins('Sozlamalar', color: colorBlack),
            const Gap(8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.circular(8),
                boxShadow: ConstBoxShadows.boxShadowsForFinanceItem(
                  dy: 3,
                  shadowColor: colorBlack.withOpacity(0.1),
                  blurRadius: 8,
                ),
              ),
              child: Column(
                children: [
                  _buildSettingItem(
                    icon: ConstIcons.userRounded,
                    label: 'Shaxsiy ma’lumotlar',
                    onTap: () {
                      print('Shaxsiy ma’lumotlar tapped');
                    },
                  ),
                  _buildDivider(),
                  _buildSettingItem(
                    icon: ConstIcons.lock,
                    label: 'Xavfsizlik',
                    onTap: () {
                      navKey.currentState?.push(CupertinoPageRoute(builder: (_) => const SecurityPage()));
                    },
                  ),
                  _buildDivider(),
                  _buildSettingItem(
                    icon: ConstIcons.dialog,
                    label: 'Texnik yordam',
                    onTap: () {
                      print('Texnik yordam tapped');
                    },
                  ),
                  _buildDivider(),
                  _buildSettingItem(
                    icon: ConstIcons.infoCircle,
                    label: 'Ilova haqida',
                    onTap: () {
                      print('Ilova haqida tapped');
                    },
                  ),
                  _buildDivider(),
                  _buildSettingItem(
                    icon: ConstIcons.logout,
                    label: 'Hisobdan chiqish',
                    color: colorRed,
                    onTap: () {
                      print('Hisobdan chiqish tapped');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
            ),
            const Gap(8),
            text14Poppins(label, color: color ?? colorBlack),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: colorGreyF2, height: 1);
  }
}
