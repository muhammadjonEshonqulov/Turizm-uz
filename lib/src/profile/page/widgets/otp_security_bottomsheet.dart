import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/common/widgets/buttons.dart';
import '../../../../core/common/widgets/text_widgets.dart';
import '../../../../core/res/const_colors.dart';
import '../../../../core/services/chuck.dart';
import 'change_password_bottom_sheet.dart';

class OtpSecurityBottomSheet extends StatefulWidget {
  const OtpSecurityBottomSheet({super.key});

  @override
  State<OtpSecurityBottomSheet> createState() => _OtpSecurityBottomSheetState();
}

class _OtpSecurityBottomSheetState extends State<OtpSecurityBottomSheet> {
  var key = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers = List.generate(6, (index) => TextEditingController());
  int countCode = 0;
  int _remainingTime = 60;
  Timer? _timer;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: text16Poppins('Bir martalik kodni kiriting', textAlign: TextAlign.center)),
                    IconButton(
                        onPressed: () {
                          navKey.currentState?.pop();
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
                Gap(32),
                text14Poppins('Sizning telefon raqamingizga kod yuborildi', color: colorGreyA9),
                Gap(32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return _otpTextField(context, index);
                  }),
                ),
                Gap(32),
                InkWell(
                  onTap: _remainingTime > 0
                      ? null
                      : () {
                          _timer?.cancel();
                          _remainingTime = 60;
                          _startTimer();
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: text14Poppins(
                      _remainingTime > 0 ? formatTime(_remainingTime) : "Qayta kod olish",
                    ),
                  ),
                ),
                Gap(32),
                defSecondaryButton('Tasdiqlash', () {
                  if (key.currentState?.validate() == true) {
                    navKey.currentState?.pop();
                    showModalBottomSheet(
                      backgroundColor: colorWhite,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => const ChangePasswordBottomSheet(),
                    );
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _otpTextField(BuildContext context, int index) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 8,
      height: MediaQuery.of(context).size.width / 8,
      child: TextField(
        controller: _otpControllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1, color: colorGreyE5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1, color: colorPrimary),
          ),
        ),
        onChanged: (value) {
          countCode = 0;
          for (var action in _otpControllers) {
            if (action.value.text.isNotEmpty) {
              countCode++;
            }
          }

          if (value.length == 1 && index < 5) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }

          if (countCode == 6) {
            FocusScope.of(context).unfocus();
          }
        },
      ),
    );
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$remainingSeconds";
  }
}
