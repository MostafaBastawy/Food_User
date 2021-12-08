import 'package:dio/dio.dart';
import 'package:food_user_interface/shared/constants.dart';

class DioHelper {
  static Dio dio = Dio();
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.stripe.com/v1/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'Authorization': secretKey,
      'Content-type': 'application/x-www-form-urlencoded'
    };
    return await dio.post(
      url,
      data: data,
    );
  }
}
