import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:turizm_uz/core/services/chuck.dart';

import 'not_internet.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();

  factory ConnectivityService() => _instance;

  ConnectivityService._internal();

  void startMonitoring() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _handleConnectivityChange(result);
    });
  }

  void _handleConnectivityChange(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      _showNoInternetPage();
    } else {
      _closeNoInternetPage();
    }
  }

  void _showNoInternetPage() {
    if (!isNoInternetPageOpen()) {
      log('_showNoInternetPage');
      navKey.currentState?.push(
        CupertinoPageRoute(
          builder: (_) => const NoInternet(),
        ),
      );
    }
  }

  bool isNoInternetPageOpen() {
    return navKey.currentState?.canPop() == true && navKey.currentState?.context != null && ModalRoute.of(navKey.currentState!.context)?.settings.name == '/no-internet';
  }

  void _closeNoInternetPage() {
    if (isNoInternetPageOpen()) {
      navKey.currentState?.pop();
    }
  }
}

class MyAppNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    ConnectivityService().startMonitoring();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    ConnectivityService().startMonitoring();
  }
}
