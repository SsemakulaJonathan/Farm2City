import 'dart:io';

import 'package:dio_http/dio_http.dart';
import 'package:farm_city/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MethodHelpers {
  static void showErrorBarWithNoActionButton(String message,
      {SnackPosition snackPosition = SnackPosition.BOTTOM}) {
    Get.showSnackbar(GetBar(
      message: message,
      duration: const Duration(seconds: Constants.flushbarDuration),
      isDismissible: true,
      snackPosition: snackPosition,
      margin: const EdgeInsets.only(left: 10, right: 10),
      backgroundColor: const Color(0xffBA5965),
    ));
  }

  static void showSuccessWithNoActionButton(String message,
      {SnackPosition snackPosition = SnackPosition.BOTTOM}) {
    Get.showSnackbar(GetBar(
      message: message,
      duration: const Duration(seconds: Constants.flushbarDuration),
      isDismissible: true,
      snackPosition: snackPosition,
      margin: const EdgeInsets.only(left: 10, right: 10),
      backgroundColor: Colors.green,
    ));
  }

  static OverlayEntry overlayLoader() {
    OverlayEntry loader = OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      return Positioned(
        height: size.height,
        width: size.width,
        top: 0,
        left: 0,
        child: Material(
          color: Constants.whiteBG.withOpacity(0.85),
          child: Lottie.asset('assets/loading.json'),
        ),
      );
    });
    return loader;
  }

//method to execute a url in the broswer
  static openUrl(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw Exception();
      }
    } catch (_) {
      MethodHelpers.showErrorBarWithNoActionButton(
          "Couldn't load this page due to unexpected error");
    }
  }

  static void dioErrorHandler(dynamic err, {bool isAcctBassed = false}) {
    try {
      if (err is DioError) {
        switch (err.type) {
          case DioErrorType.connectTimeout:
            MethodHelpers.showErrorBarWithNoActionButton(
                "Network Connection timedout");
            break;
          case DioErrorType.sendTimeout:
            MethodHelpers.showErrorBarWithNoActionButton(
                "Network Connection timedout");
            break;
          case DioErrorType.receiveTimeout:
            MethodHelpers.showErrorBarWithNoActionButton(
                "Server Response Connection timedout");
            break;
          case DioErrorType.response:
            var response = err.response?.data;
            if (err.response!.statusCode == 401) {
              if (response != null && response['message'] != null) {
                MethodHelpers.showErrorBarWithNoActionButton(
                    response['message']);
              } else {
                MethodHelpers.showErrorBarWithNoActionButton(
                    "Oops, an error occured while processing your request");
              }
            } else if (err.response!.statusCode == 400 ||
                err.response!.statusCode == 404 ||
                err.response!.statusCode == 422) {
              if (response != null && response['errors'] != null) {
                Map data = response['errors'];

                List<dynamic> values = data.entries.first.value;

                MethodHelpers.showErrorBarWithNoActionButton(values[0]);
              } else {
                if (response != null && response['message'] != null) {
                  MethodHelpers.showErrorBarWithNoActionButton(
                      response['message']);
                } else {
                  MethodHelpers.showErrorBarWithNoActionButton(
                      "Oops, an error occured while processing your request");
                }
              }
            } else if (err.response!.statusCode == 409) {
              if (isAcctBassed) {
                MethodHelpers.showErrorBarWithNoActionButton(
                    "User with the same email already exists. Please proceed to login instead");
              } else {
                MethodHelpers.showErrorBarWithNoActionButton(
                    response['message']);
              }
            } else {
              MethodHelpers.showErrorBarWithNoActionButton(
                  "Oops, an Unknown error occured.");
            }
            break;
          case DioErrorType.cancel:
            MethodHelpers.showErrorBarWithNoActionButton(
                "Connection was cancelled");
            break;
          case DioErrorType.other:
            if (err.error is SocketException) {
              MethodHelpers.showErrorBarWithNoActionButton(
                  "No internet connection detected");
            } else {
              MethodHelpers.showErrorBarWithNoActionButton(
                  "Oops, an Unknown error occured.");
            }
            break;
        }
        return;
      } else {
        MethodHelpers.showErrorBarWithNoActionButton(
            "Oops, an Unknown error occured.");
      }
    } catch (_) {
      MethodHelpers.showErrorBarWithNoActionButton(
          "Oops, failed processing your request. Please retry");
    }
  }
}
