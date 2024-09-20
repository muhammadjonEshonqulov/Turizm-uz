import 'package:chuck_interceptor/chuck.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../res/const_colors.dart';

final navKey = GlobalKey<NavigatorState>();

final Chuck chuck = Chuck(
  showNotification: true,
  showInspectorOnShake: false,
  darkTheme: false,
  navigatorKey: navKey,
);

final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: colorPrimary),
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: colorWhite,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: colorBackground,
      surfaceTintColor: colorWhite,
      elevation: 0,
      actionsIconTheme: IconThemeData(
        color: colorPrimary,
        size: 24,
      ),
      iconTheme: IconThemeData(
        color: colorPrimary,
        size: 24,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: colorPrimary,
        systemNavigationBarColor: colorPrimary,
      ),
    ));

