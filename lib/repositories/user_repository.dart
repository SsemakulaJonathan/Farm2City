import 'package:dio_http/dio_http.dart';
import 'package:farm_city/constants/constant.dart';
import 'package:farm_city/models/access_token.dart';
import 'package:farm_city/models/user.dart';

class UserRepository {
  static Future<Map> login(
    String email,
    String password,
    String role,
  ) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseURL,
        connectTimeout: Constants.timeOut,
        method: 'POST',
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      var url;
      if (role == "seller") {
        url = 'login';
      } else {
        url = 'login/buyer';
      }
      final response = await dio
          .request(url, data: {'username': email, 'password': password});

      var results = {
        'user': User.fromJson(response.data['user']['data']),
        'access_token': AccessToken.fromJson(response.data['token'])
      };

      return results;
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> register(Map user, String role) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseURL,
        connectTimeout: Constants.timeOut,
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      if (role == "sender") {
        await dio.post('sellers', data: user);
      } else {
        await dio.post('buyers', data: user);
      }
    } catch (e) {
      rethrow;
    }
  }
}
