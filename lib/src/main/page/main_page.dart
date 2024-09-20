import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_colors.dart';
import 'package:turizm_uz/core/res/const_icons.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBackground,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
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
              Gap(20),
              // Categories
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildCategoryButton(Icons.restaurant, 'Restoranlar'),
                    buildCategoryButton(Icons.hotel_outlined, 'Mehmonxonalar'),
                    buildCategoryButton(Icons.fastfood_outlined, 'Fast food'),
                    buildCategoryButton(Icons.restaurant, 'Restoranlar'),
                    buildCategoryButton(Icons.hotel, 'Mehmonxonalar'),
                    buildCategoryButton(Icons.fastfood, 'Fast food'),
                  ],
                ),
              ),
              const Gap(20),
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
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: colorPrimary,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Asosiy'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Xarita'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Sevimlilar'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
      ),
    );
  }

  // Reusable method to build category buttons
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
            Text(label, style:   TextStyle(color: colorDefTex)),
          ],
        ),
      ),
    );
  }

  // Reusable method for heart icon inside a circle
  Widget buildHeartIcon({bool isFilled = false, Color iconColor = Colors.white, double size = 32.0}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isFilled ? Icons.favorite_outlined : Icons.favorite_border_outlined,
        color: iconColor,
        size: size * 0.6,
      ),
    );
  }

  // Reusable method to build recent places
  Widget buildRecentPlaceTile(String label, String imagePath) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1, color: colorGreyCC), borderRadius: BorderRadius.circular(100)),
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.only(right: 10.0),
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
    );
  }

  // Reusable method to build recommendation tiles
  Widget buildRecommendationTile(String title, String rating, String imagePath) {
    return Container(
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
                  child: buildHeartIcon(isFilled: imagePath != ConstIcons.image),
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
    );
  }
}
