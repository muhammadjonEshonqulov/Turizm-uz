import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:share_plus/share_plus.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_colors.dart';
import 'package:turizm_uz/core/res/const_icons.dart';
import 'package:turizm_uz/core/services/chuck.dart';
import 'package:turizm_uz/src/hotels/page/hotel_info_page.dart';

class HotelsPage extends StatefulWidget {
  const HotelsPage({super.key, required this.name});

  final String name;

  @override
  State<HotelsPage> createState() => _HotelsPageState();
}

class _HotelsPageState extends State<HotelsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBackground,
        body: Column(
          children: [_buildAppBar(context), _buildRecommendationGrid()],
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
            child: text16Poppins(widget.name, textAlign: TextAlign.center),
          ),
          // const Gap(16),
        ],
      ),
    );
  }

  Widget _buildRecommendationGrid() {
    final List<Map<String, String>> recommendations = [
      {
        'title': 'Turon Lux Hotel',
        'rating': '4.8 (200 izoh)',
        'imagePath': ConstIcons.image,
      },
      {
        'title': 'Registon Saroy Hotel',
        'rating': '4.8 (200 izoh)',
        'imagePath': ConstIcons.image1,
      },
      {
        'title': 'Sangzor boutique Hotel',
        'rating': '4.8 (200 izoh)',
        'imagePath': ConstIcons.image,
      },
      {
        'title': 'Savitskiy Plaza',
        'rating': '4.8 (200 izoh)',
        'imagePath': ConstIcons.image1,
      },
      {
        'title': 'Sangzor boutique Hotel',
        'rating': '4.8 (200 izoh)',
        'imagePath': ConstIcons.image,
      },
      {
        'title': 'Savitskiy Plaza',
        'rating': '4.8 (200 izoh)',
        'imagePath': ConstIcons.image1,
      },
      {
        'title': 'Sangzor boutique Hotel',
        'rating': '4.8 (200 izoh)',
        'imagePath': ConstIcons.image,
      },
      {
        'title': 'Savitskiy Plaza',
        'rating': '4.8 (200 izoh)',
        'imagePath': ConstIcons.image1,
      },
    ];

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: recommendations.length,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemBuilder: (context, index) {
          return _buildRecommendationTile(
            recommendations[index]['title']!,
            recommendations[index]['rating']!,
            recommendations[index]['imagePath']!,
          );
        },
      ),
    );
  }

  Widget _buildRecommendationTile(String title, String rating, String imagePath) {
    final isFavorite = imagePath != ConstIcons.image;
    return GestureDetector(
      onTap: () {
        navKey.currentState?.push(CupertinoPageRoute(builder: (_) => HotelInfoPage(hotelName: title)));
      },
      child: Container(
        height: 270,
        margin: const EdgeInsets.only(top: 16.0),
        padding: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: 200,
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
              child: Row(
                children: [
                  text14Poppins(title, fontWeight: FontWeight.w500),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.share_outlined),
                    onPressed: () async {
                      await Share.share('text');
                    },
                  ),
                  const Gap(8.0),
                  IconButton(
                    icon: Transform.flip(flipX: true, child: Transform.rotate(angle: 3.14 / 2, child: const Icon(Icons.route_outlined))),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Icon(Icons.star, color: colorWarning, size: 16),
                  const Gap(4),
                  text12Poppins(rating.split(' (').first, color: colorWarning),
                  const Gap(4),
                  text12Poppins(rating.split(' (').last, color: colorGreyA9),
                ],
              ),
            ),
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
}
