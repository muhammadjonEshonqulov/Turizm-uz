import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/services/dio_helper.dart';
import '../../../core/utils/core_utils.dart';

Future<dynamic> login({required String username, required String password}) async {
  Dio dio = await DioSingleton().dioInstance;
  try {
    var response = await dio.post(
      'api/login',
      data: {
        "username": username,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      return {"code": 1, "data": response.data['data']};
    } else {
      return {"message": checkStatusAndHandleResponse};
    }
  } catch (e) {
    return {"message": '${'something_went_wrong'.tr()} ${e.toString()}'};
  }
}
