import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_box_shadows.dart';
import 'package:turizm_uz/core/res/const_colors.dart';
import 'package:turizm_uz/core/res/const_icons.dart';

class PaymentTypesPage extends StatefulWidget {
  const PaymentTypesPage({super.key});

  @override
  State<PaymentTypesPage> createState() => _PaymentTypesPageState();
}

class _PaymentTypesPageState extends State<PaymentTypesPage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> paymentOptions = [
    {
      'title': 'Standart',
      'description': '7 kun davomida TOP da turish',
      'price': '100,000 so’m',
    },
    {
      'title': 'Gold',
      'description': '10 kun davomida TOP da turish',
      'price': '200,000 so’m',
    },
    {
      'title': 'Premium',
      'description': '30 kun davomida TOP da turish',
      'price': '500,000 so’m',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: text16Poppins('To’lov'),
        actions: [SvgPicture.asset(ConstIcons.notification), const Gap(16)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(16),
            ...List.generate(paymentOptions.length, (index) {
              return PaymentOptionCard(
                title: paymentOptions[index]['title'],
                description: paymentOptions[index]['description'],
                price: paymentOptions[index]['price'],
                isSelected: _selectedIndex == index,
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              );
            }),
            const Gap(16),
          ],
        ),
      ),
    );
  }
}

class PaymentOptionCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentOptionCard({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.circular(8),
          boxShadow: ConstBoxShadows.boxShadowsForFinanceItem(
            dy: 3,
            blurRadius: 6,
            shadowColor: colorBlack,
            opacity: 0.06,
          ),
          border: Border.all(
            color: isSelected ? colorPrimary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SvgPicture.asset(isSelected ? ConstIcons.selectedRadio : ConstIcons.unSelectedRadio),
                const Gap(8),
                text16Poppins(title),
                const Spacer(),
                SvgPicture.asset(ConstIcons.infoCircle),
              ],
            ),
            const Gap(17),
            Row(
              children: [
                const Gap(24),
                Icon(
                  Icons.check,
                  color: colorPrimary,
                  size: 20,
                ),
                const Gap(8),
                text12Poppins(description, color: colorBlack),
              ],
            ),
            const Gap(8),
            Row(
              children: [
                const Gap(24),
                SvgPicture.asset(
                  ConstIcons.dollarMinimalistic,
                  width: 20,
                ),
                const Gap(8),
                text12Poppins(price, color: colorBlack),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
