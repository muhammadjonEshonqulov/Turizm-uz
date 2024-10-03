import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/services/chuck.dart';
import 'package:turizm_uz/src/add_business/page/upload_photos_page.dart';

import '../../../core/common/widgets/text_widgets.dart';
import '../../../core/res/const_colors.dart';
import 'add_room_page.dart';
import 'hotel_facilities_page.dart';
import 'hotel_features_page.dart';
import 'owner_details_page.dart';

class RegisterNewOrg extends StatefulWidget {
  const RegisterNewOrg({super.key});

  @override
  State<RegisterNewOrg> createState() => _RegisterNewOrgState();
}

class _RegisterNewOrgState extends State<RegisterNewOrg> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageController.page != 0) {
          _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: colorBackground,
        appBar: appBar(context),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              positions(),
              const Gap(24),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (c) {
                    setState(() {
                      _currentIndex = c;
                    });
                  },
                  // physics: const NeverScrollableScrollPhysics(),
                  children: [OwnerDetailsPage(onNext: onNext), HotelFacilitiesPage(onNext: onNext), HotelFeaturesPage(onNext: onNext), AddRoomPage(onNext: onNext), UploadPhotosPage()],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onNext() {
    _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  Widget positions() {
    return Row(
      children: List.generate(5, (index) {
        return Expanded(
          child: GestureDetector(
            onTap: () {
              _pageController.jumpToPage(index);
              setState(() {
                _currentIndex = index;
              });
            },
            child: Container(
              height: 6,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: index <= _currentIndex ? colorPrimary : colorGreyF2),
            ),
          ),
        );
      }),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leadingWidth: 70,
      leading: IconButton(
        onPressed: () {
          if (_pageController.page != 0) {
            _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
            return;
          }
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
      title: text16Poppins(''),
    );
  }
}
