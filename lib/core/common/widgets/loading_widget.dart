import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';

import '../../res/const_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.isNotInternet = false});

  final bool isNotInternet;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        height: size.height,
        width: size.width,
        color: colorWhite.withOpacity(0.9),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: size.width * 0.12,
                  width: size.width * 0.12,
                  child: CircularProgressIndicator(
                    strokeWidth: size.width * 0.02,
                    color: colorPrimary,
                    backgroundColor: colorGreyF0,
                  )),
              const Gap(20),
              text16Poppins(isNotInternet ? "no_internet_check".tr() : 'malumotlar_yuklanyapti'.tr(), color: colorBlack, fontWeight: FontWeight.w400)
            ],
          ),
        ),
      ),
    );
  }
}
