import 'package:dio_http/dio_http.dart';
import 'package:farm_city/constants/constant.dart';
import 'package:farm_city/middleware/network_interceptor.dart';

class CheckOutRepository {
  static Future<Map> makeOrder(amount, delivery) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseURL,
        connectTimeout: Constants.timeOut,
        method: 'POST',
        responseType: ResponseType.json);

    try {
      Dio dio = Dio(baseOptions);
      dio.interceptors.add(NetworkInterceptor(dio));

      var response = await dio.request(
        'buyer/order',
        data: {
          'total_amount': amount,
          'delivery_address': delivery,
        },
      );

      return response.data;
    } catch (_) {
      rethrow;
    }
  }
}
