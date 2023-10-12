import 'package:dio_http/dio_http.dart';
import 'package:farm_city/constants/constant.dart';
import 'package:farm_city/middleware/network_interceptor.dart';
import 'package:farm_city/models/cart.dart';
import 'package:farm_city/models/cart_item.dart';

class CartRepository {
  static Future<int> getCartCount() async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseURL,
        method: 'GET',
        connectTimeout: Constants.timeOut,
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);
    dio.interceptors.add(NetworkInterceptor(dio));

    try {
      final response = await dio.request(
        'buyer/cart/count',
      );

      return response.data['total'];
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> removeFromCart(Cart cart) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseURL,
        method: 'DELETE',
        connectTimeout: Constants.timeOut,
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);
    dio.interceptors.add(NetworkInterceptor(dio));

    try {
      await dio.request('buyer/cart/remove/${cart.productId}');
    } catch (err) {
      if (err is DioError) {
        print(err.requestOptions.path);
      }
      rethrow;
    }
  }

  static Future<void> updateCart(int productId, int quantity) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseURL,
        method: 'PUT',
        connectTimeout: Constants.timeOut,
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);
    dio.interceptors.add(NetworkInterceptor(dio));

    try {
      await dio.request('buyer/cart/update/$productId', data: {
        'quantity': quantity,
      });
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> addToCart(int productId, int quantity) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseURL,
        method: 'POST',
        connectTimeout: Constants.timeOut,
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);
    dio.interceptors.add(NetworkInterceptor(dio));

    try {
      await dio.request('buyer/addToCart',
          data: {"product_id": productId, "quantity": quantity});
    } catch (e, s) {
      print("akakak:$e");
      print("akakak:$s");
      rethrow;
    }
  }

  static Future<Cart> isExistInCart(productId) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseURL,
        method: 'POST',
        connectTimeout: Constants.timeOut,
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);
    dio.interceptors.add(NetworkInterceptor(dio));

    try {
      var response = await dio
          .request('buyer/check/cart', data: {'product_id': productId});

      return Cart(productId: productId, quantity: response.data['quantity']);
    } catch (_) {
      rethrow;
    }
  }

  static Future<List<CartItem>> getCart() async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseURL,
        method: 'GET',
        connectTimeout: Constants.timeOut,
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);
    dio.interceptors.add(NetworkInterceptor(dio));
    try {
      final response = await dio.request('buyer/cart');

      List<CartItem> items = [];
      for (Map item in response.data['data']) {
        items.add(CartItem.fromJson(item));
      }
      return items;
    } catch (_) {
      rethrow;
    }
  }
}
