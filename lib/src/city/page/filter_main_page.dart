import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/buttons.dart';
import 'package:turizm_uz/core/res/const_colors.dart';

import '../../../core/common/widgets/text_widgets.dart';
import '../../../core/services/chuck.dart';

class FilterBottomSheet extends StatefulWidget {
  FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int typeId = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text16Poppins('Filtrlash', color: colorBlack),
              IconButton(
                  onPressed: () {
                    navKey.currentState?.pop();
                  },
                  icon: const Icon(Icons.close)),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(16),
                  _buildPriceRange(),
                  Divider(
                    color: colorGreyF2,
                    thickness: 1,
                  ),
                  _buildSectionTitle('Turi'),
                  _buildTypeSelection(),
                  Divider(
                    color: colorGreyF2,
                    thickness: 1,
                  ),
                  _buildSectionTitle('Reyting'),
                  _buildRatingSelection(),
                  Divider(
                    color: colorGreyF2,
                    thickness: 1,
                  ),
                  _buildSectionTitle('Qulayliklar'),
                  _buildFacilitySelection(),
                  Divider(
                    color: colorGreyF2,
                    thickness: 1,
                  ),
                  _buildSectionTitle('Ovaqatlanish'),
                  _buildMealOptions(),
                  Divider(
                    color: colorGreyF2,
                    thickness: 1,
                  ),
                  _buildSectionTitle('To\'lov turi'),
                  _buildPaymentTypes(),
                  Divider(
                    color: colorGreyF2,
                    thickness: 1,
                  ),
                  _buildSectionTitle('Til'),
                  _buildLanguageSelection(),
                  Divider(
                    color: colorGreyF2,
                    thickness: 1,
                  ),
                  defSecondaryButton('20 ta natijani ko’rsatish', () {}),
                  const Gap(4),
                  ghostSecondaryButton('Filtrni tozalash', () {}),
                  const Gap(16)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  RangeValues _currentRangeValues = RangeValues(100000, 900000);

  Widget _buildPriceRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text14Poppins('Narx oralig’i'),
        const Gap(8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 1,
            rangeThumbShape: const RoundRangeSliderThumbShape(enabledThumbRadius: 10.0),
          ),
          child: RangeSlider(
            values: _currentRangeValues,
            min: 100000,
            max: 900000,
            inactiveColor: colorGreyF2,
            activeColor: colorPrimary,
            labels: RangeLabels(
              '${_currentRangeValues.start.toInt()} UZS',
              '${_currentRangeValues.end.toInt()} UZS',
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(border: Border.all(width: 1, color: colorGreyF2), borderRadius: BorderRadius.circular(100)), child: text12Poppins('${_currentRangeValues.start.toInt()} UZS')),
              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(border: Border.all(width: 1, color: colorGreyF2), borderRadius: BorderRadius.circular(100)), child: text12Poppins('${_currentRangeValues.end.toInt()} UZS')),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildSectionTitle(String title) {
  return text14Poppins(title, color: colorBlack);
}

Widget _buildTypeSelection() {
  // Map<int, String> data = {0: 'Mehmonxona', 1: 'Hovli', 2: 'Hostel', 3: 'Oilaviy mehmon uyi'};

  // return SizedBox(
  //   height: 200,
  //   child: ListView.builder(
  //       itemCount: data.length,
  //       scrollDirection: Axis.horizontal,
  //       shrinkWrap: true,
  //       itemBuilder: (_, index) {
  //         return Chip(
  //           label: text12Poppins(data[index] ?? '-'),
  //           backgroundColor: colorBackground,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(100),
  //             side: BorderSide(width: 1, color: colorGreyF2),
  //           ),
  //         );
  //       }),
  // );
  return Wrap(spacing: 8, children: [
    // Chip(
    //   label: text12Poppins(value),
    //   backgroundColor: colorBackground,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(100),
    //     side: BorderSide(width: 1, color: colorGreyF2),
    //   ),
    // ),
    Chip(
      label: text12Poppins('Mehmonxona'),
      backgroundColor: colorBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorPrimary)),
    ),
    Chip(
      label: text12Poppins('Hovli'),
      backgroundColor: colorBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorGreyF2)),
    ),
    Chip(
      label: text12Poppins('Hostel'),
      backgroundColor: colorBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorGreyF2)),
    ),
    Chip(
      label: text12Poppins('Oilaviy mehmon uyi'),
      backgroundColor: colorBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorGreyF2)),
    ),
  ]);
}

Widget _buildRatingSelection() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () {},
          icon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(border: Border.all(width: 1, color: index == 4 ? colorPrimary : colorGreyF2), borderRadius: BorderRadius.circular(100)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                text12Poppins('${index + 1}'),
                const Gap(4),
                Icon(
                  Icons.star,
                  color: colorWarning,
                  size: 16,
                ),
              ],
            ),
          ),
        );
      }).reversed.toList(),
    ),
  );
}

Widget _buildFacilitySelection() {
  return Wrap(
    spacing: 8.0,
    children: [
      Chip(
        label: text12Poppins('Kir mashina'),
        backgroundColor: colorBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorPrimary)),
      ),
      Chip(
        label: text12Poppins('Konditsioner'),
        backgroundColor: colorBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorGreyF2)),
      ),
      Chip(
        label: text12Poppins('Oshxona'),
        backgroundColor: colorBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorGreyF2)),
      ),
      Chip(
        label: text12Poppins('Televizor'),
        backgroundColor: colorBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorGreyF2)),
      ),
      Chip(
        label: text12Poppins('WiFi'),
        backgroundColor: colorBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorGreyF2)),
      ),
      Chip(
        label: text12Poppins('Dazmol'),
        backgroundColor: colorBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorGreyF2)),
      ),
    ],
  );
}

Widget _buildMealOptions() {
  return Wrap(
    spacing: 8.0,
    children: [
      Chip(
        label: text12Poppins('Nonushta'),
        backgroundColor: colorBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorPrimary)),
      ),
      Chip(
        label: text12Poppins('Tushlik'),
        backgroundColor: colorBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorGreyF2)),
      ),
      Chip(
        label: text12Poppins('Kechki ovqat'),
        backgroundColor: colorBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorGreyF2)),
      ),
    ],
  );
}

Widget _buildPaymentTypes() {
  return Wrap(
    spacing: 8.0,
    children: [
      Chip(
        label: text12Poppins('Karta orqali'),
        backgroundColor: colorBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorPrimary)),
      ),
      Chip(
        label: text12Poppins('Naqd pul'),
        backgroundColor: colorBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorGreyF2)),
      ),
    ],
  );
}

Widget _buildLanguageSelection() {
  return Wrap(
    spacing: 8.0,
    children: [
      Chip(
        label: text12Poppins('O\'zbek'),
        backgroundColor: colorBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorGreyF2)),
      ),
      Chip(
        label: text12Poppins('Inglis'),
        backgroundColor: colorBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorPrimary)),
      ),
      Chip(
        label: text12Poppins('Rus'),
        backgroundColor: colorBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorGreyF2)),
      ),
      Chip(
        label: text12Poppins('Fransuz'),
        backgroundColor: colorBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorGreyF2)),
      ),
      Chip(
        label: text12Poppins('Nemis'),
        backgroundColor: colorBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorGreyF2)),
      ),
      Chip(
        label: text12Poppins('Qozoq'),
        backgroundColor: colorBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorGreyF2)),
      ),
      Chip(
        label: text12Poppins('Tojik'),
        backgroundColor: colorBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(width: 1, color: colorGreyF2)),
      ),
    ],
  );
}
