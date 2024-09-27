import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_colors.dart';
import 'package:turizm_uz/core/res/const_icons.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<Map> images = [
    {"image": ConstIcons.image, "title": "Tashqi ko’rinish"},
    {"image": ConstIcons.image, "title": "Tashqi ko’rinish"},
    {"image": ConstIcons.image1, "title": "Xonalar"},
    {"image": ConstIcons.image, "title": "Taomlar"},
    {"image": ConstIcons.image, "title": "Taomlar"},
    {"image": ConstIcons.image1, "title": "Bar"},
    {"image": ConstIcons.image1, "title": "Bar"},
    {"image": ConstIcons.image, "title": "Tashqi ko’rinish"},
    {"image": ConstIcons.image, "title": "Taomlar"},
    {"image": ConstIcons.image1, "title": "Bar"},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                  const Spacer(),
                  text16Poppins('Galereya'),
                  const Spacer(),
                ],
              ),
              const Gap(16),
              SizedBox(
                height: 130,
                child: ListView.builder(
                    itemCount: images.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                images[index]["image"],
                                width: 88,
                                height: 88,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Gap(8),
                            text10Poppins(images[index]["title"]),
                          ],
                        ),
                      );
                    }),
              ),
              const Gap(20),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text14Poppins('Fotolavhalar', fontWeight: FontWeight.w500),
                          const Gap(4),
                          text12Poppins('Eksteryer'),
                        ],
                      ),
                    ),
                    // Vertical images
                    ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                          child: index % 2 == 0
                              ? Row(
                                  children: [Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset(ConstIcons.image))), const Gap(16), Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset(ConstIcons.image)))],
                                )
                              : ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset(ConstIcons.image)),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
