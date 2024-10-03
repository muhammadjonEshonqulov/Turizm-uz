import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/buttons.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import '../../../core/res/const_colors.dart';
import '../../registration/page/widgets.dart';

class OwnInfoPage extends StatefulWidget {
  const OwnInfoPage({super.key});

  @override
  State<OwnInfoPage> createState() => _OwnInfoPageState();
}

class _OwnInfoPageState extends State<OwnInfoPage> {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBackButton(context),
                const Gap(16),
                text16Poppins('Shaxsiy ma’lumotlar'),
                const Gap(24),

                // Name and Surname Section
                _buildEditableField(
                  title: 'Ism va familiya',
                  value: 'Obidov Zafarjon',
                  onEdit: () {
                    _showEditModal(
                      context,
                      title: 'Ism va familiya o’zgartirish',
                      hint: 'Ism va familiya',
                    );
                  },
                ),
                const Gap(16),

                // Email Section
                _buildEditableField(
                  title: 'E-mail',
                  value: 'zafar******@gmail.com',
                  onEdit: () {
                    _showEditModal(
                      context,
                      title: 'E-mail o’zgartirish',
                      hint: 'E-mail',
                    );
                  },
                ),
                const Gap(16),

                // Phone Section
                _buildEditableField(
                  title: 'Telefon raqami',
                  value: '+998 (33) 656-35-36',
                  onEdit: () {
                    _showEditModal(
                      context,
                      title: 'Telefon raqami o’zgartirish',
                      hint: 'Telefon raqami',
                      isPhoneField: true,
                    );
                  },
                ),
                const Gap(16),

                // Address Section
                _buildEditableField(
                  title: 'Manzil',
                  value: 'Ma’lumot yo’q',
                  onEdit: () {
                    _showEditModal(
                      context,
                      title: 'Manzil qo’shish',
                      hint: 'Manzil',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Back Button Widget
  Widget _buildBackButton(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-8, 0),
      child: IconButton(
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
    );
  }

  // Widget for each editable field
  Widget _buildEditableField({
    required String title,
    required String value,
    required VoidCallback onEdit,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              text14Poppins(title),
              const Spacer(),
              InkWell(
                onTap: onEdit,
                child: text12Poppins('O’zgartirish', color: colorPrimary),
              ),
            ],
          ),
          const Gap(4),
          text12Poppins(value, color: colorGrey7F),
          const Gap(8),
          Divider(color: colorGreyF2, height: 1),
        ],
      ),
    );
  }

  // Reusable method to show the bottom modal for editing fields
  void _showEditModal(
      BuildContext context, {
        required String title,
        required String hint,
        bool isPhoneField = false,
      }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorWhite,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: text16Poppins(title, textAlign: TextAlign.center),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const Gap(32),
                    isPhoneField
                        ? phone(nameController, (n) {})
                        : textField(
                      nameController,
                      hint,
                          (value) {},
                      isUnderlined: true,
                      isRequired: true,
                      errorText: 'Ushbu qator to’ldirilishi shart',
                    ),
                    const Gap(32),
                    defSecondaryButton('O’zgartirish', () {
                      if (_formKey.currentState?.validate() == true) {
                        // Handle form submission
                      }
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
