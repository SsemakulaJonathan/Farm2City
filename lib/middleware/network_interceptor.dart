import 'package:dio_http/dio_http.dart';
import 'package:farm_city/controllers/user_controller.dart';
import 'package:farm_city/models/access_token.dart';
import 'package:farm_city/models/user.dart';
import 'package:get/get.dart' as get_object;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NetworkInterceptor extends Interceptor {
  Dio networkDio;
  int retry = -1;
  AccessToken? accessToken;
  int? userId;
  SharedPreferences? prefs;
  NetworkInterceptor(this.networkDio, {SharedPreferences? sharedPreferences}) {
    if (sharedPreferences == null) {
      accessToken = get_object.Get.context!.read<UserController>().accessToken;
    } else {
      accessToken = AccessToken.fromJson(
          jsonDecode(sharedPreferences.getString('token').toString()));
      userId = User.fromJson(
              jsonDecode(sharedPreferences.getString('user').toString()))
          .id;
      prefs = sharedPreferences;
    }
  }

  @override
  Future onRequest(RequestOptions options, handler) async {
    options.headers['Authorization'] = 'Bearer ${accessToken?.accessToken}';
    return handler.next(options);
  }

  @override
  Future onResponse(Response response, handler) async {
    return handler.next(response);
  }

  @override
  Future onError(DioError err, handler) async {
    if (err.response?.statusCode == 401) {
      retry++;

      if (retry == 1) {
        return handler.next(err);
      } else {
        try {
          networkDio.interceptors.requestLock.lock();
          networkDio.interceptors.responseLock.lock();
          RequestOptions requestOptions = err.requestOptions;
          networkDio.interceptors.requestLock.unlock();
          networkDio.interceptors.responseLock.unlock();
          //remaking the previous request with new token
          var response = await networkDio.fetch(requestOptions);
          return handler.resolve(response);
          // ignore: empty_catches
        } on Exception {}
      }
    } else {
      return handler.next(err);
    }
  }
}
