import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/buttons.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_colors.dart';

class HotelFeaturesPage extends StatefulWidget {
  const HotelFeaturesPage({super.key, required this.onNext});

  final Function() onNext;

  @override
  State<HotelFeaturesPage> createState() => _HotelFeaturesPageState();
}

class _HotelFeaturesPageState extends State<HotelFeaturesPage> {
  Map<String, bool> facilities = {
    'Bar': false,
    'Bog‘': false,
    'Terassa': false,
    'Sauna': false,
    'Baseyn': false,
    'O‘yin maydonchasi': false,
    'WiFi': false,
    'Jakuzi': false,
    'Sport zal': false,
    'Chekish uchun maxsus joy': false,
    'Avtoturargoh': false,
    'Transport xizmati (aeroportdan yoki vokzaldan)': false,
  };

  Map<String, bool> diningOptions = {
    'Nonushta': false,
    'Tushlik': false,
    'Kechki ovqat': false,
    'Ovqatlanish o‘z hisobidan': false,
  };

  Map<String, bool> languages = {
    'O‘zbek tili': false,
    'Rus tili': false,
    'Ingliz tili': false,
    'Fransuz tili': false,
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text16Poppins('Mehmonxonadagi qulayliklar'),
          const Gap(24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    const Gap(24),
                    text14Poppins('Umumiy', color: colorBlack, fontWeight: FontWeight.w500),
                    const Gap(16),
                    ...facilities.keys.map((facility) {
                      return Transform.translate(
                        offset: const Offset(-10, 0),
                        child: CheckboxListTile(
                          title: Transform.translate(offset: const Offset(-20, 0), child: text12Poppins(facility)),
                          contentPadding: EdgeInsetsDirectional.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          value: facilities[facility],
                          dense: true,
                          activeColor: colorPrimary,
                          checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          side: BorderSide(width: 2, color: colorGreyCC),
                          onChanged: (bool? value) {
                            setState(() {
                              facilities[facility] = value!;
                            });
                          },
                        ),
                      );
                    }),
                    const Gap(24),
                    text14Poppins('Umumiy', color: colorBlack, fontWeight: FontWeight.w500),
                    const Gap(16),
                    ...diningOptions.keys.map((option) {
                      return Transform.translate(
                        offset: const Offset(-10, 0),
                        child: CheckboxListTile(
                          title: Transform.translate(offset: const Offset(-20, 0), child: text12Poppins(option)),
                          contentPadding: EdgeInsetsDirectional.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          value: diningOptions[option],
                          dense: true,
                          activeColor: colorPrimary,
                          checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          side: BorderSide(width: 2, color: colorGreyCC),
                          onChanged: (bool? value) {
                            setState(() {
                              diningOptions[option] = value!;
                            });
                          },
                        ),
                      );
                    }),
                    const Gap(24),
                    text14Poppins('Tillar', color: colorBlack, fontWeight: FontWeight.w500),
                    const Gap(16),
                    ...languages.keys.map((option) {
                      return Transform.translate(
                        offset: const Offset(-10, 0),
                        child: CheckboxListTile(
                          title: Transform.translate(offset: const Offset(-20, 0), child: text12Poppins(option)),
                          contentPadding: EdgeInsetsDirectional.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          value: languages[option],
                          dense: true,
                          activeColor: colorPrimary,
                          checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          side: BorderSide(width: 2, color: colorGreyCC),
                          onChanged: (bool? value) {
                            setState(() {
                              languages[option] = value!;
                            });
                          },
                        ),
                      );
                    }),
                  ],
                ),
                const Gap(24),
                defSecondaryButton('Davom etish', () {}),
                const Gap(16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
