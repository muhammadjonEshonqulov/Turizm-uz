import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/buttons.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_colors.dart';
import 'package:turizm_uz/core/res/const_icons.dart';
import 'package:turizm_uz/core/services/chuck.dart';
import 'package:turizm_uz/src/add_business/page/galery_page.dart';

class UploadPhotosPage extends StatefulWidget {
  const UploadPhotosPage({super.key});

  @override
  State<UploadPhotosPage> createState() => _UploadPhotosPageState();
}

class _UploadPhotosPageState extends State<UploadPhotosPage> {
  Widget _buildUploadSection({
    required String title,
    required String subtitle,
    required String formatInfo,
    required String buttonText,
    required bool showAddMoreButton,
    required int uploadedImageCount,
    required List<Widget> imageWidgets,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textPoppinsRequired(title, 14, color: colorBlack, fontWeight: FontWeight.w400),
        const Gap(8),
        Container(
          decoration: BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  text12Poppins('$uploadedImageCount ta rasm yuklandi', color: colorPrimary),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        // navKey.currentState?.push(CupertinoPageRoute(builder: (_) => const GalleryPage()));
                        showGeneralDialog(context: context, pageBuilder:  (context, animation1, animation2) {
                          return const GalleryPage();
                        });
                      },
                      child: SvgPicture.asset(ConstIcons.eye, width: 18)),
                ],
              ),
              const Gap(10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(children: imageWidgets),
                    if (showAddMoreButton) _buildAddImageButton(),
                  ],
                ),
              ),
              const Gap(8),
              text12Poppins(formatInfo, color: colorGreyA9),
              if (errorText != null) ...[
                const Gap(8),
                text12Poppins(errorText, color: colorRed),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddImageButton() {
    return SizedBox(
      height: 80,
      width: 80,
      child: DottedBorder(
        dashPattern: const [8, 8],
        borderType: BorderType.Rect,
        color: colorGreyF2,
        strokeCap: StrokeCap.butt,
        strokeWidth: 1,
        child: Center(
          child: IconButton(
            highlightColor: colorPrimary.withOpacity(0.2),
            onPressed: () {},
            icon: Icon(Icons.add_circle, color: colorGreyF2, size: 30),
          ),
        ),
      ),
    );
  }

  Widget _buildImageWidget(String asset, {bool isMainImage = false}) {
    return Container(
      height: 100,
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(2),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: isMainImage ? colorPrimary : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: isMainImage
          ? Column(
              children: [
                if (isMainImage) text10Poppins('Asosiy rasm', color: colorWhite),
                Image.asset(
                  asset,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(1.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  ConstIcons.image1,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text16Poppins('Mehmonxona rasmlarini yuklang', color: colorBlack),
          const Gap(24),
          textPoppinsRequired('Mehmonxona promo videosi', 14, color: colorBlack, fontWeight: FontWeight.w400),
          const Gap(8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    text12Poppins('Promo video', color: colorGreen),
                    const Spacer(),
                    SvgPicture.asset(ConstIcons.eye, width: 18),
                  ],
                ),
                const Gap(8),
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: DottedBorder(
                    dashPattern: const [8, 8],
                    borderType: BorderType.Rect,
                    color: colorGreen,
                    strokeCap: StrokeCap.butt,
                    strokeWidth: 1,
                    child: Center(
                      child: IconButton(
                        highlightColor: colorPrimary.withOpacity(0.2),
                        onPressed: () {},
                        icon: Icon(Icons.add_circle, color: colorGreyF2, size: 30),
                      ),
                    ),
                  ),
                ),
                const Gap(8),
                text12Poppins('Formatlar - MP4, AVI', color: colorGreyA9),
              ],
            ),
          ),
          const Gap(16),
          _buildUploadSection(
            title: 'Tashqi ko’rinish (eksteryer)',
            subtitle: '3 ta rasm yuklandi',
            formatInfo: 'Formatlar - JPG, PNG, BMP, HEIC',
            buttonText: 'Yana 1 ta rasm yuklashingiz kerak',
            showAddMoreButton: true,
            uploadedImageCount: 3,
            imageWidgets: List.generate(3, (index) {
              return _buildImageWidget(
                index == 0 ? ConstIcons.image : ConstIcons.image1,
                isMainImage: index == 0,
              );
            }),
            errorText: 'Yana 1 ta rasm yuklashingiz kerak',
          ),
          const Gap(16),
          _buildUploadSection(
            title: 'Xonalar',
            subtitle: '4 ta rasm yuklandi',
            formatInfo: 'Formatlar - JPG, PNG, BMP, HEIC',
            buttonText: 'Ajoyib, barcha rasmlar yuklandi',
            showAddMoreButton: false,
            uploadedImageCount: 4,
            imageWidgets: List.generate(3, (index) {
              return _buildImageWidget(
                index == 0 ? ConstIcons.image : ConstIcons.image1,
                isMainImage: index == 0,
              );
            }),
          ),
          const Gap(16),
          _buildUploadSection(
            title: 'Taomlar',
            subtitle: '4 ta rasm yuklandi',
            formatInfo: 'Formatlar - JPG, PNG, BMP, HEIC',
            buttonText: 'Ajoyib, barcha rasmlar yuklandi',
            showAddMoreButton: false,
            uploadedImageCount: 4,
            imageWidgets: List.generate(3, (index) {
              return _buildImageWidget(
                index == 0 ? ConstIcons.image : ConstIcons.image1,
                isMainImage: index == 0,
              );
            }),
          ),
          const Gap(16),
          _buildUploadSection(
            title: 'Bar',
            subtitle: '4 ta rasm yuklandi',
            formatInfo: 'Formatlar - JPG, PNG, BMP, HEIC',
            buttonText: 'Ajoyib, barcha rasmlar yuklandi',
            showAddMoreButton: false,
            uploadedImageCount: 4,
            imageWidgets: List.generate(3, (index) {
              return _buildImageWidget(
                index == 0 ? ConstIcons.image : ConstIcons.image1,
                isMainImage: index == 0,
              );
            }),
          ),
          const Gap(24),
          defSecondaryButton('Yakunlash', () {}),
        ],
      ),
    );
  }
}
