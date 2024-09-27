import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:turizm_uz/core/res/const_colors.dart';

import '../common/widgets/text_widgets.dart';

abstract class CoreUtils {
  const CoreUtils();

  static void showSnackBar(
    BuildContext context, {
    required String message,
    Color? backgroundColour,
  }) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final snackBar = SnackBar(
        backgroundColor: backgroundColour ?? colorPrimary,
        behavior: SnackBarBehavior.floating,
        content: text14Poppins(message),
        duration: _calculateDuration(message),
      );

      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    });
  }

  static Duration _calculateDuration(String message) {
    const int averageWPM = 200;

    const int averageWordLength = 5;

    const int millisecondsPerWord = (60 * 1000) ~/ averageWPM;
    const int millisecondsPerCharacter = millisecondsPerWord ~/ averageWordLength;

    final int durationInMilliseconds = message.length * millisecondsPerCharacter;

    const int maxDurationMilliseconds = 5000;
    final int finalDuration = durationInMilliseconds.clamp(1000, maxDurationMilliseconds);

    return Duration(milliseconds: finalDuration);
  }

  static void postFrameCall(VoidCallback callback) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
}

void printWarning(String text) {
  if (kDebugMode) {
    print('\x1B[33m$text\x1B[0m');
  }
}

void printError(String text) {
  if (kDebugMode) {
    print('\x1B[31m$text\x1B[0m');
  }
}

void printNormal(String text) {
  if (kDebugMode) {
    print('\x1B[34m$text\x1B[0m');
  }
}

void printGreen(String text) {
  if (kDebugMode) {
    print('\x1B[32m$text\x1B[0m');
  }
}

String formatName(String input) {
  if (input.isEmpty) return '';
  List<String> parts = input.split(' ');

  List<String> formattedParts = parts.map((part) {
    if (part.isEmpty) return part;
    return part[0].toUpperCase() + part.substring(1).toLowerCase();
  }).toList();

  return formattedParts.join(' ');
}

Future<void> setStatusBarColor({required Color color}) async {
  // if (Platform.isIOS) {
  //   await FlutterStatusbarcolor.setStatusBarColor(color);
  //   if (useWhiteForeground(color)) {
  //     FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  //   } else {
  //     FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  //   }
  // } else {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: color,
      systemNavigationBarColor: color,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  // }
}

Future<bool> checkNetwork() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult != ConnectivityResult.none;
}

String formatDate(DateTime dateTime) {
  DateFormat formatter = DateFormat('dd.MM.yyyy');
  String formattedDate = formatter.format(dateTime);
  return formattedDate;
}

String checkStatusAndHandleResponse(Response<dynamic> response) {
  return (response.statusCode == 422)
      ? response.data['message']
      : (response.statusCode == 401)
          ? 'unauthorized_error'.tr()
          : (response.statusCode == 500)
              ? 'internal_server_error'.tr()
              : '${response.statusCode} error';
}
