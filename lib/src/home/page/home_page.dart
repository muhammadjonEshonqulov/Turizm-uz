import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_colors.dart';
import 'package:turizm_uz/core/res/const_icons.dart';
import 'package:turizm_uz/core/services/chuck.dart';
import 'package:turizm_uz/src/hotels/page/hotel_info_page.dart';
import 'package:turizm_uz/src/hotels/page/hotels_page.dart';

import '../../city/page/city_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorPrimary),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.black),
                      Gap(10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Qidiruv...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(16),
              SvgPicture.asset(ConstIcons.sms),
              const Gap(16),
              SvgPicture.asset(ConstIcons.notification),
            ],
          ),
          const Gap(20),
          _buildGridItems(),
          const Gap(15),
          // Recently viewed
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text16Poppins('Bugun qayerga borasiz? >'),
              Text('>', style: TextStyle(fontSize: 16)),
            ],
          ),
          const Gap(16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                buildRecentPlaceTile('Samarqand', ConstIcons.image),
                buildRecentPlaceTile('Buxoro', ConstIcons.image1),
                buildRecentPlaceTile('Buxoro', ConstIcons.image1),
                buildRecentPlaceTile('Toshkent', ConstIcons.image),
                buildRecentPlaceTile('Toshkent', ConstIcons.image),
                buildRecentPlaceTile('Toshkent', ConstIcons.image),
              ],
            ),
          ),
          const Gap(40),
          text16Poppins('Tavsiyalar'),
          const Gap(16),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              buildRecommendationTile('Turon Lux Hotel', '4.8 (200)', ConstIcons.image),
              buildRecommendationTile('Registon Saroy Hotel', '4.8 (200)', ConstIcons.image1),
              buildRecommendationTile('Sangzor boutique Hotel', '4.8 (200)', ConstIcons.image),
              buildRecommendationTile('Sangzor boutique Hotel', '4.8 (200)', ConstIcons.image),
              buildRecommendationTile('Sangzor boutique Hotel', '4.8 (200)', ConstIcons.image),
              buildRecommendationTile('Sangzor boutique Hotel', '4.8 (200)', ConstIcons.image),
              buildRecommendationTile('Sangzor boutique Hotel', '4.8 (200)', ConstIcons.image),
              buildRecommendationTile('Savitskiy Plaza', '4.8 (200)', ConstIcons.image1),
            ],
          ),
        ],
      ),
    )));
  }

  Widget buildCategoryButton(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: colorDefTex),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(icon, color: colorDefTex),
            const Gap(8),
            Text(label, style: TextStyle(color: colorDefTex)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeartIcon({
    bool isFilled = false,
  }) {
    return SvgPicture.asset(
      isFilled ? ConstIcons.liked : ConstIcons.like,
      width: 20,
    );
  }

  Widget buildRecentPlaceTile(String label, String imagePath) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1, color: colorGreyCC), borderRadius: BorderRadius.circular(100)),
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.only(right: 10.0),
      child: GestureDetector(
        onTap: () {
          navKey.currentState?.push(CupertinoPageRoute(builder: (_) => CityPage(cityName: label)));
        },
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                imagePath,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const Gap(8),
            text12Poppins(label),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItems() {
    final List<Map<String, String>> gridItems = [
      {'icon': ConstIcons.bed, 'label': 'Mehmonxonalar'},
      {'icon': ConstIcons.wineglassTriangle, 'label': 'Restoranlar'},
      {'icon': ConstIcons.bag, 'label': 'Savdo markazlari'},
      {'icon': ConstIcons.cashOut, 'label': 'Bankomatlar'},
      {'icon': ConstIcons.cart, 'label': 'Oziq-ovqatlar'},
      {'icon': ConstIcons.cup, 'label': 'Kafelar'},
      {'icon': ConstIcons.stethoscope, 'label': 'Shifoxonalar'},
      {'icon': ConstIcons.widget, 'label': 'Barchasi'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: gridItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.4,
      ),
      itemBuilder: (context, index) {
        final item = gridItems[index];
        return InkWell(
          onTap: () {
            navKey.currentState?.push(CupertinoPageRoute(
                builder: (_) => HotelsPage(
                      name: item['label'] ?? '-',
                    )));
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                item['icon']!,
              ),
              const Gap(8.0),
              text12Poppins(item['label'] ?? '-', color: colorBlack),
            ],
          ),
        );
      },
    );
  }

  Widget buildRecommendationTile(String title, String rating, String imagePath) {
    return GestureDetector(
      onTap: () {
        navKey.currentState?.push(CupertinoPageRoute(builder: (_) => HotelInfoPage(hotelName: title)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: _buildHeartIcon(isFilled: imagePath != ConstIcons.image),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: text14Poppins(title, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Icon(Icons.star, color: colorWarning, size: 16),
                  const Gap(4),
                  text12Poppins('4.8', color: colorWarning),
                  const Gap(4),
                  text12Poppins('(200)', color: colorGreyA9),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
