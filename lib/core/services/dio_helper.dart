import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:turizm_uz/core/utils/core_utils.dart';

import 'chuck.dart';
import 'not_internet.dart';

class DioSingleton {
  static final DioSingleton _singleton = DioSingleton._internal();
  late Dio _dio;

  factory DioSingleton() {
    return _singleton;
  }

  DioSingleton._internal() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 35),
        receiveTimeout: const Duration(seconds: 35),
        sendTimeout: const Duration(seconds: 35),
        baseUrl: 'https://kasbiy-talim.uz/services/platon-core/api/',
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Basic $basicToken',
          'Authorization': 'Basic ZC54YW1kYW1vdjpkLnhhbWRhbW92ITEyMw==',
          'device-id': '1',
        },
      ),
    );

    _dio.interceptors.addAll([
      InterceptorsWrapper(
        onError: (DioException error, handler) {
          return handler.next(error);
        },
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          printGreen("===REQUEST=====> ${options.uri.toString()}\n===>[Query Parameters]===> ${options.queryParameters}\n===>[Request Data]===> ${options.data}\n===>[Method]===> ${options.method}\n===>[Request Headers]===> ${options.headers}");
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          printGreen("\n===RESPONSE===>[StatusCode]===> ${response.statusCode}\n===>[Url]===> ${response.realUri}\n===>[StatusMessage]===> ${response.statusMessage}\n===>[Response Data]===> ${response.data}");

          return handler.next(response);
        },
      ),
      LogInterceptor(
        logPrint: (o) => debugPrint(o.toString()),
      ),
      if (kDebugMode) chuck.getDioInterceptor(),
    ]);
  }

  Future<Dio> get dioInstance async {
    var has = await checkNetwork();
    if (!has) {
      navKey.currentState?.push(
        CupertinoPageRoute(builder: (_) => const NoInternet()),
      );
    }
    return _dio;
  }
}
