import 'dart:convert';
import 'dart:io';

import 'package:dio_http/dio_http.dart';
import 'package:farm_city/constants/constant.dart';
import 'package:farm_city/middleware/network_interceptor.dart';
import 'package:farm_city/models/product.dart';
import 'package:farm_city/models/product_upload.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class ProductRepository {
  static Future<List<Product>> getProducts() async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseURL,
        method: 'GET',
        connectTimeout: Constants.timeOut,
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request(
        'products/all',
      );

      List<Product> products = [];
      for (Map product in response.data) {
        products.add(Product.fromJson(product));
      }
      return products;
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> addProduct(
      ProductUpload productUpload, List<String> images) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseURL,
        connectTimeout: Constants.timeOut,
        method: 'POST',
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);
    dio.interceptors.add(NetworkInterceptor(dio));

    try {
      List<MultipartFile> files = [];

      for (String path in images) {
        MultipartFile multipartFile = await MultipartFile.fromFile(path,
            contentType: basename(path).contains("jpg") ||
                    basename(path).contains("jpeg")
                ? MediaType("image", "jpeg")
                : MediaType("image", "png"),
            filename: basename(path));
        files.add(multipartFile);
      }
      Map<String, dynamic> res = {'product_images': files};
      res.addAll(jsonDecode(jsonEncode(productUpload)));
      var data = FormData.fromMap(res, ListFormat.multiCompatible);
      await dio.post('products', data: data);
      for (String path in images) {
        File file = File(path);
        try {
          file.delete();
        } catch (_) {}
      }
    } catch (_) {
      rethrow;
    }
  }
}
