import 'package:flutter/material.dart';
import 'package:turizm_uz/core/res/const_colors.dart'; // Assuming colorPrimary is defined here
import 'package:turizm_uz/core/res/const_icons.dart';
import 'package:turizm_uz/core/services/chuck.dart'; // Assuming image constants are defined here

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  final List<String> images = [
    ConstIcons.image,
    ConstIcons.image1,
    ConstIcons.image,
    ConstIcons.image1,
    ConstIcons.image,
    ConstIcons.image1,
    ConstIcons.image,
    ConstIcons.image1,
    ConstIcons.image,
    ConstIcons.image1,
    ConstIcons.image,
    ConstIcons.image1,
    ConstIcons.image,
    ConstIcons.image1,
    ConstIcons.image,
    ConstIcons.image1,
    ConstIcons.image,
    ConstIcons.image1,
    ConstIcons.image,
    ConstIcons.image1,
  ];

  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onThumbnailTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _scrollToThumbnail(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _scrollToThumbnail(index);
  }

  void _scrollToThumbnail(int index) {
    double thumbnailOffset = index * 69.0;
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        thumbnailOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorTransparent,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(child: Container(color: colorWhite.withOpacity(0.9))),
                      Expanded(
                        child: Stack(
                          children: [
                            PageView.builder(
                              controller: _pageController,
                              onPageChanged: _onPageChanged,
                              itemCount: images.length,
                              itemBuilder: (context, index) {
                                return Image.asset(images[index], fit: BoxFit.cover);
                              },
                            ),
                            Positioned(
                              bottom: 0,
                              top: 0,
                              left: 10,
                              right: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        if (_selectedIndex == 0) {
                                          _selectedIndex = images.length - 1;
                                        } else {
                                          _selectedIndex = _selectedIndex - 1;
                                        }
                                        _onThumbnailTap(_selectedIndex);
                                        _onPageChanged(_selectedIndex);
                                      },
                                      icon: CircleAvatar(
                                        backgroundColor: colorBlack.withOpacity(0.3),
                                        child: Icon(
                                          Icons.arrow_back_ios_new,
                                          color: colorWhite,
                                        ),
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        if (_selectedIndex == images.length - 1) {
                                          _selectedIndex = 0;
                                        } else {
                                          _selectedIndex = _selectedIndex + 1;
                                        }

                                        _onThumbnailTap(_selectedIndex);
                                        _onPageChanged(_selectedIndex);
                                      },
                                      icon: CircleAvatar(
                                        backgroundColor: colorBlack.withOpacity(0.3),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: colorWhite,
                                        ),
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(child: Container(color: colorWhite.withOpacity(0.9))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 75,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.5 - 40,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _onThumbnailTap(index),
                        child: Container(
                          height: 65,
                          width: 65,
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: _selectedIndex == index ? colorPrimary : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.asset(images[index], fit: BoxFit.cover),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                    onPressed: () {
                      navKey.currentState?.pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: colorDefTex,
                    )))
          ],
        ),
      ),
    );
  }
}
