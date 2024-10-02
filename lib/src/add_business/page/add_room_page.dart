import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/buttons.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_colors.dart';
import 'package:turizm_uz/src/registration/page/widgets.dart';

import '../../../core/res/const_icons.dart';
import '../../../core/utils/core_utils.dart';

class AddRoomPage extends StatefulWidget {
  const AddRoomPage({super.key, required this.onNext});

  final Function() onNext;

  @override
  State<AddRoomPage> createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  bool isExpanded = false;
  String? selectedRoomType;
  TextEditingController priceController = TextEditingController();

  List<String> roomTypes = ['Standart', 'Yarim lyuks', 'Lyuks', 'Oilaviy xona', 'Umumiy xona'];

  Map<String, bool> facilities = {
    'Bir yoki ikki kishilik yotoq': true,
    'Yuvinish xonasi‘': true,
    'Oshxona': true,
    'Konditsioner': true,
    'Televizor': true,
  };

  Map<String, bool> additionalFacilities = {
    'Nonushta': true,
    'Tozalash xizmatlari': true,
    'Transport xizmatlari': true,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text16Poppins('Xona qo’shish'),
                const Gap(24),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          text12Poppins((selectedRoomType != null && isExpanded == false) ? selectedRoomType! : 'Xona turini tanlang ', color: selectedRoomType != null && isExpanded == false ? colorDefTex : colorGreyA9),
                          if (!(selectedRoomType != null && isExpanded == false)) text12Poppins('*', color: colorRed),
                          const Spacer(),
                          Transform.translate(
                            offset: const Offset(8, 0),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              icon: Icon(
                                isExpanded == true ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                                size: 24,
                                color: colorGreyA9,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: selectedRoomType == null ? colorGreyA9 : colorPrimary,
                        height: 1,
                        width: double.infinity,
                      ),
                      if (isExpanded)
                        Column(
                          children: roomTypes.map((roomType) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedRoomType = roomType;
                                  isExpanded = false;
                                });
                              },
                              child: Transform.translate(
                                offset: const Offset(-10, 0),
                                child: ListTile(
                                  title: Transform.translate(
                                    offset: const Offset(-20, 0),
                                    child: text12Poppins(roomType),
                                  ),
                                  contentPadding: EdgeInsetsDirectional.zero,
                                  leading: Radio<String>(
                                    value: roomType,
                                    groupValue: selectedRoomType,
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedRoomType = value;
                                      });
                                    },
                                    activeColor: colorPrimary,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      if (selectedRoomType != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(16),
                            textField(priceController, 'Narx (so’mda) ', (v) {}, isRequired: true, isUnderlined: true, keyboardType: TextInputType.number, formatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              ThousandsSeparatorInputFormatter(),
                              NoLeadingZeroInputFormatter(),
                            ]),
                            Gap(16),
                            Row(
                              children: [
                                SvgPicture.asset(ConstIcons.groups, height: 20),
                                const Gap(8),
                                text14Poppins('Odam soni'),
                                const Spacer(),
                                SvgPicture.asset(ConstIcons.minusCircle, width: 16),
                                const Gap(8),
                                text16Poppins('2'),
                                const Gap(8),
                                SvgPicture.asset(ConstIcons.addCircle, width: 16),
                              ],
                            ),
                            const Gap(8),
                            Row(
                              children: [
                                SvgPicture.asset(ConstIcons.lamp, height: 20),
                                const Gap(8),
                                text14Poppins('Xuddi shunday xona'),
                                const Spacer(),
                                SvgPicture.asset(ConstIcons.minusCircle, width: 16),
                                const Gap(8),
                                text16Poppins('2'),
                                const Gap(8),
                                SvgPicture.asset(ConstIcons.addCircle, width: 16),
                              ],
                            ),
                            const Gap(24),
                            text14Poppins('Qulayliklar', fontWeight: FontWeight.w500, color: colorBlack),
                            const Gap(8),
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
                            text14Poppins('Qo’shimcha', fontWeight: FontWeight.w500, color: colorBlack),
                            const Gap(8),
                            ...additionalFacilities.keys.map((facility) {
                              return Transform.translate(
                                offset: const Offset(-10, 0),
                                child: CheckboxListTile(
                                  title: Transform.translate(offset: const Offset(-20, 0), child: text12Poppins(facility)),
                                  contentPadding: EdgeInsetsDirectional.zero,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  value: additionalFacilities[facility],
                                  dense: true,
                                  activeColor: colorPrimary,
                                  checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  side: BorderSide(width: 2, color: colorGreyCC),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      additionalFacilities[facility] = value!;
                                    });
                                  },
                                ),
                              );
                            })
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Gap(8),
        defSecondaryButton('Qo’shish', () {})
      ],
    );
  }
}
