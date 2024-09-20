

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/core_utils.dart';


class LogBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      printWarning("\n${"~" * 20}${bloc.runtimeType} => Changed => =from= ${change.currentState.runtimeType} =to= ${change.nextState.runtimeType}${"~" * 20}");
    }
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      printGreen("\n${"~" * 20}${bloc.runtimeType} closed${"~" * 20}");
    }
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      printGreen("\n${"~" * 20}${bloc.runtimeType} created ${"~" * 20}");
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      printNormal('\n${"~" * 20}Event${"~" * 20} ${event.runtimeType}');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      printError('\n${"~" * 20}Error${"~" * 20} $error');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // if (kDebugMode) {
    //   print("${"~" * 20}$bloc------$transition${"~" * 20}");
    // }
  }
}

/// ssl
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (cert, host, port) => true;
  }
}