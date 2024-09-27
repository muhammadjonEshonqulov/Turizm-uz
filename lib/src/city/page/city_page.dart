import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/buttons.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_colors.dart';
import 'package:turizm_uz/core/res/const_icons.dart';
import 'package:turizm_uz/core/services/chuck.dart';
import 'package:turizm_uz/src/gallery/page/gallery_page.dart';
import 'package:turizm_uz/src/suggestion/page/suggestion_page.dart';

import '../../hotels/page/hotel_info_page.dart';
import '../../hotels/page/hotels_page.dart';
import 'filter_main_page.dart';

class CityPage extends StatefulWidget {
  const CityPage({super.key, required this.cityName});

  final String cityName;

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: [
            _buildAppBar(context),
            const Gap(24),
            _buildImageWithOverlay(),
            const Gap(16),
            _buildGridItems(),
            const Gap(15),
            _buildSectionTitle('Tarixiy obidalar'),
            const Gap(16),
            _buildRecommendationGrid(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: borderedSecondaryButton('Barchasini ko’rish', () {}),
            ),
            InkWell(onTap: () {
              navKey.currentState?.push(CupertinoPageRoute(builder: (_) => const SuggestionPage()));
            }, child: _buildSectionTitle('Tavsiyalar  >')),
            const Gap(16),
            _buildHorizontalRecommendations(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 16, left: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              navKey.currentState?.pop();
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
          const Gap(4),
          Expanded(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: colorPrimary),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.black),
                  Gap(10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: widget.cityName,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // const Gap(16),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                backgroundColor: colorBackground,
                isScrollControlled: true,
                builder: (context) => FilterBottomSheet(),
              );
            },
            icon: CircleAvatar(
              radius: 20,
              backgroundColor: colorPrimary,
              child: SvgPicture.asset(ConstIcons.filter),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    navKey.currentState?.pop();
                  },
                  icon: const Icon(Icons.close)),
              const Spacer(),
              text16Poppins('Filtrlash', color: colorBlack),
              const Spacer(),
              const Spacer(),
            ],
          ),
        ),
        const Gap(16),
        text14Poppins('Narx oralig’i'),
        const Gap(16),
        Slider(value: 0.2, onChanged: (value) {})
      ],
    );
  }

  Widget _buildImageWithOverlay() {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            child: Image.asset(ConstIcons.image, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: -5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text16Poppins('Samarqand', color: colorWhite),
                    InkWell(
                      onTap: (){
                        navKey.currentState?.push(CupertinoPageRoute(builder: (_) => const GalleryPage()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colorBlack.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(ConstIcons.gallery),
                            const Gap(4),
                            text12Poppins('Galereya', color: colorWhite),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Container(
                height: 30,
                decoration: BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
            if (item['label'] == 'Barchasi') {
              List<Map<String, String>> bottomSheetItems = [];
              bottomSheetItems.clear();
              bottomSheetItems.addAll(gridItems);
              bottomSheetItems.removeLast();
              bottomSheetItems.add({'icon': ConstIcons.tram, 'label': 'Temiryo’l'});
              bottomSheetItems.add({'icon': ConstIcons.gasStation, 'label': 'AYOQSH'});
              bottomSheetItems.add({'icon': ConstIcons.electricRefueling, 'label': 'Elektromobillarni zaryadlash'});

              showModalBottomSheet(
                context: context,
                backgroundColor: colorBackground,
                builder: (context) => _buildAllBottomSheet(bottomSheetItems),
              );
              return;
            }
            navKey.currentState?.push(CupertinoPageRoute(builder: (_) => HotelsPage(name: item['label'] ?? '-')));
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

  Widget _buildAllBottomSheet(List<Map<String, String>> bottomSheetItems) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text16Poppins('Barcha  kategoriyalar', color: colorBlack),
              IconButton(
                  onPressed: () {
                    navKey.currentState?.pop();
                  },
                  icon: const Icon(Icons.close)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: bottomSheetItems.length,
            itemBuilder: (context, index) {
              final item = bottomSheetItems[index];
              return InkWell(
                onTap: () {
                  navKey.currentState?.push(CupertinoPageRoute(builder: (_) => HotelsPage(name: item['label'] ?? '-')));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      SvgPicture.asset(item['icon'] ?? '', width: 24),
                      const Gap(8),
                      text12Poppins(item['label'] ?? '', color: colorBlack),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: text16Poppins(title),
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

  Widget _buildRecommendationGrid() {
    final List<Map<String, String>> recommendations = [
      {
        'title': 'Turon Lux Hotel',
        'rating': '4.8 (200)',
        'imagePath': ConstIcons.image,
      },
      {
        'title': 'Registon Saroy Hotel',
        'rating': '4.8 (200)',
        'imagePath': ConstIcons.image1,
      },
      {
        'title': 'Sangzor boutique Hotel',
        'rating': '4.8 (200)',
        'imagePath': ConstIcons.image,
      },
      {
        'title': 'Savitskiy Plaza',
        'rating': '4.8 (200)',
        'imagePath': ConstIcons.image1,
      },
    ];

    return GridView.count(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      physics: const NeverScrollableScrollPhysics(),
      children: recommendations
          .map((rec) => _buildRecommendationTile(
                rec['title']!,
                rec['rating']!,
                rec['imagePath']!,
              ))
          .toList(),
    );
  }

  Widget _buildRecommendationTile(String title, String rating, String imagePath) {
    final isFavorite = imagePath != ConstIcons.image;
    return GestureDetector(
      onTap: (){
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
                    child: _buildHeartIcon(isFilled: isFavorite),
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
                  text12Poppins(rating.split(' ').first, color: colorWarning),
                  const Gap(4),
                  text12Poppins(rating.split(' ').last, color: colorGreyA9),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalRecommendations() {
    final List<Map<String, String>> recommendations = List.generate(
      4,
      (index) => {
        'title': 'Family Park',
        'distance': '4 km uzoqlikda',
        'imagePath': ConstIcons.image,
      },
    );

    return SizedBox(
      height: 220,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        scrollDirection: Axis.horizontal,
        itemCount: recommendations.length,
        separatorBuilder: (context, index) => const Gap(16),
        itemBuilder: (context, index) {
          final rec = recommendations[index];
          return _buildRecommendationCard(
            rec['title']!,
            rec['distance']!,
            rec['imagePath']!,
          );
        },
      ),
    );
  }

  Widget _buildRecommendationCard(String title, String distance, String imagePath) {
    return InkWell(
      onTap: (){
        navKey.currentState?.push(CupertinoPageRoute(builder: (_) => HotelInfoPage(hotelName: title)));
      },
      child: Stack(
        children: [
          SizedBox(
            height: 200,
            width: 300,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 12,
            bottom: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text16Poppins(title, color: colorWhite),
                const Gap(4),
                text12Poppins(distance, color: colorWhite),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
