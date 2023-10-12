import 'dart:async';
import 'package:dio_http/dio_http.dart';
import 'package:farm_city/helpers/helpers.dart';
import 'package:farm_city/models/cart_item.dart';
import 'package:farm_city/repositories/checkout_repository.dart';
import 'package:farm_city/views/order_success.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutController with ChangeNotifier {
  bool isLoading = false;
  double? subTotal;
  String? instructions;
  String? paymentMode;
  String paymentMethod = 'mobile_money';
  String deliveryMethod = 'home_delivery';
  List<CartItem>? cartItems;
  String? phoneNumber;
  double total = 0;
  int? deliveryCost;
  dynamic exception;
  Timer? timer;

  void listenToPayment(amount, delivery) async {
    try {
      Get.bottomSheet(
          Container(
            color: Colors.white,
            height: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Processing order',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 25,
                ),
                CircularProgressIndicator()
              ],
            ),
          ),
          enableDrag: false,
          isDismissible: false);
      timer = Timer.periodic(const Duration(seconds: 7), (timer) async {
        Map res = await CheckOutRepository.makeOrder(amount, delivery);

        if (res['message'] == "Order Added successfully") {
          Get.close(1);
          timer.cancel();
          Get.to(() => OrderSuccess(checkOutController: this));
        }
      });
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 422) {
          timer!.cancel();
          Get.close(1);
          MethodHelpers.showErrorBarWithNoActionButton(
              e.response!.data['message']);
        }
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
