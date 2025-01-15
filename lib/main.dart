import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as prov;
import 'package:provider/provider.dart';
import 'package:turizm_uz/core/res/const_colors.dart';
import 'package:turizm_uz/core/services/text_scaler.dart';
import 'package:turizm_uz/src/splash/page/splash_page.dart';

import 'core/services/chuck.dart';
import 'core/services/lang_service.dart';
import 'core/utils/core_utils.dart';
import 'src/delete.dart';

void main() {
  runApp(
    prov.MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TextScalerProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('uz', 'UZ'), Locale('en', 'US'), // American English
          Locale('en', 'UK'), // British English
          Locale('ru', 'RU'),
        ],
        path: 'assets/lang',
        saveLocale: true,
        assetLoader: JsonAssetLoader(),
        fallbackLocale: const Locale('uz', 'UZ'),
        startLocale: const Locale("uz", "UZ"),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textScaler = Provider.of<TextScalerProvider>(context).textScalerValue;

    // setStatusBarColor(color: colorPrimary);

    return MaterialApp(
      title: 'Online-Diller',
      debugShowCheckedModeBanner: false,
      navigatorKey: navKey,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: theme,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(textScaler),
          ),
          child: child!,
        );
      },
      // home: const SplashScreen(),
      home: const SplashPage(),
    );
  }
}
