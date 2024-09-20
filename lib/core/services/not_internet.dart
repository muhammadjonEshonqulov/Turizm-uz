import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/services/src/style.dart';
import 'package:turizm_uz/core/services/src/widget.dart';

import '../common/widgets/loading_widget.dart';
import '../common/widgets/text_widgets.dart';
import '../res/const_colors.dart';
import '../res/const_icons.dart';
import '../utils/core_utils.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({super.key});

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  bool pressed = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: isLoading
          ? const LoadingWidget(isNotInternet: true)
          : Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ConstIcons.errorPageLogo,
                          width: 200,
                          height: 200,
                        ),
                        const Gap(40),
                        text16Poppins('no_internet_title'.tr()),
                        const Gap(20),
                        text14Poppins(
                          'no_internet_message'.tr(),
                          maxLines: 3,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Parent(
                    gesture: Gestures()
                      ..isTap((isTapped) => setState(() => pressed = isTapped))
                      ..onTap(() async {
                        setState(() {
                          isLoading = true;
                        });
                        await Future.delayed(const Duration(milliseconds: 2000));
                        setState(() {
                          isLoading = false;
                        });
                        var has = await checkNetwork();
                        if (has) {
                          if (context.mounted) Navigator.of(context).pop();
                        } else {
                          // navKey.currentState?.pushReplacement(CupertinoPageRoute(
                          //   builder: (_) => const NoInternet(),
                          // ));
                        }
                      }),
                    style: ParentStyle()
                      ..scale(pressed ? 0.95 : 1.0)
                      ..background.color(colorPrimary)
                      ..padding(all: 15)
                      ..borderRadius(all: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(ConstIcons.pajamasRetry, width: 20, height: 20),
                        const Gap(10),
                        text16Poppins('retry'.tr(), color: colorWhite, fontWeight: FontWeight.w600),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
