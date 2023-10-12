import 'dart:convert';

import 'package:farm_city/helpers/helpers.dart';
import 'package:farm_city/models/access_token.dart';
import 'package:farm_city/models/user.dart';
import 'package:farm_city/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends ChangeNotifier {
  User? user;
  bool isLoggedIn = false;
  AccessToken? accessToken;
  NumberFormat currencyFomatter = NumberFormat.currency(
    decimalDigits: 0,
    symbol: "UGX ",
  );
  SharedPreferences? sharedPreferences;
  Future<dynamic> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences!.getString('user') != null) {
      user = User.fromJson(
        jsonDecode(
          sharedPreferences!.getString('user').toString(),
        ),
      );

      accessToken = AccessToken.fromJson(
        jsonDecode(
          sharedPreferences!.getString('token').toString(),
        ),
      );

      isLoggedIn = true;
    }
  }

  void saveToken(AccessToken accessToken) {
    this.accessToken = accessToken;
    sharedPreferences!.setString('token', jsonEncode(accessToken));
  }

  void login(String email, String password, String role) async {
    OverlayEntry loader = MethodHelpers.overlayLoader();
    try {
      Overlay.of(Get.overlayContext!).insert(loader);

      Map<dynamic, dynamic> res =
          await UserRepository.login(email, password, role);
      isLoggedIn = true;
      user = res['user'];
      accessToken = res['access_token'];
      sharedPreferences!.setString('user', jsonEncode(user));
      sharedPreferences!.setString('token', jsonEncode(accessToken));
      loader.remove();
      Get.offNamed('/');
    } catch (err) {
      loader.remove();
      MethodHelpers.dioErrorHandler(err, isAcctBassed: true);
    }

    notifyListeners();
  }

  void signUp(Map user, role) async {
    OverlayEntry loader = MethodHelpers.overlayLoader();
    try {
      Overlay.of(Get.overlayContext!).insert(loader);

      await UserRepository.register(user, role);

      loader.remove();
      Get.offNamed('/account_created');
    } catch (err) {
      loader.remove();
      MethodHelpers.dioErrorHandler(err, isAcctBassed: true);
    }

    notifyListeners();
  }

  void logOut() async {
    await sharedPreferences!.remove('user');
    await sharedPreferences!.remove('token');
    user = null;
    accessToken = null;
    isLoggedIn = false;
    Get.offNamed('/login');
    notifyListeners();
  }
}
