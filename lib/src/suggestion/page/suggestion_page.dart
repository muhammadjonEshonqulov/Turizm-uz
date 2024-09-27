import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/res/const_icons.dart';

import '../../../core/common/widgets/text_widgets.dart';
import '../../../core/res/const_colors.dart';
import '../../../core/services/chuck.dart';
import '../../hotels/page/hotel_info_page.dart';

class SuggestionPage extends StatefulWidget {
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          _buildAppBar(context),
          const Gap(24),
          _buildSuggestionsList(),
        ],
      ),
    ));
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
            child: text16Poppins('Tavsiyalar', textAlign: TextAlign.center),
          ),
          // const Gap(16),
        ],
      ),
    );
  }

  Widget _buildSuggestionsList() {
    final List<Map<String, String>> recommendations = List.generate(
      22,
      (index) => {
        'title': 'Family Park',
        'distance': '4 km uzoqlikda',
        'imagePath': ConstIcons.image,
      },
    );

    return Expanded(
      child: ListView.builder(
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          final rec = recommendations[index];
          return _buildSuggestionItem(
            rec['title']!,
            rec['distance']!,
            rec['imagePath']!,
          );
        },
      ),
    );
  }

  Widget _buildSuggestionItem(String title, String distance, String imagePath) {
    return InkWell(
      onTap: () {
        navKey.currentState?.push(CupertinoPageRoute(builder: (_) => HotelInfoPage(hotelName: title)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
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
      ),
    );
  }
}
