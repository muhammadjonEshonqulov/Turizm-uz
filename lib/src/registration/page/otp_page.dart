import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/buttons.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/common/widgets/un_focus_widget.dart';
import 'package:turizm_uz/core/res/const_colors.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _otpControllers = List.generate(6, (index) => TextEditingController());

  int _remainingTime = 60;
  int countCode = 0;
  Timer? _timer;
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
            borderSide: BorderSide(width: 2, color: colorGreyCC),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 2, color: colorPrimary),
          ),
        ),
        onChanged: (value) {
          countCode = 0;
          for (var action in _otpControllers) {
            if (action.value.text.isNotEmpty) {
              countCode++;
            }
          }

          log('_otpControllers count $countCode');
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

  @override
  void initState() {
    super.initState();
    _startTimer();
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

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$remainingSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OnUnFocusTap(
        child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: disabledPriButton(
              'submit'.tr(),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(100),
                  textPoppins('otp'.tr(), 24, fontWeight: FontWeight.w700),
                  const Gap(50),
                  text14Poppins('otp_message'.tr(), textAlign: TextAlign.center, color: colorGreyA9),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return _otpTextField(context, index);
                    }),
                  ),
                  const Gap(20),
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
                  const Gap(70)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
