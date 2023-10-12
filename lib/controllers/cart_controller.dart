import 'package:farm_city/helpers/helpers.dart';
import 'package:farm_city/models/cart.dart';
import 'package:farm_city/models/cart_item.dart';
import 'package:farm_city/repositories/cart_repositiry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CartController with ChangeNotifier {
  int count = 0;
  bool isLoading = true;
  double subTotal = 0.0;
  List<CartItem> cartItems = [];
  dynamic exception;
  Future<void> getCartCount() async {
    try {
      count = await CartRepository.getCartCount();
    } catch (_) {}
    notifyListeners();
  }

  void getUserCart() async {
    if (isLoading == false) {
      isLoading = true;
      notifyListeners();
    }
    try {
      cartItems = [];
      List<CartItem> results = await CartRepository.getCart();
      cartItems.addAll(results);
      calculateSubtotal();
    } catch (e) {
      print(e);
      //cartItems = null;
      exception = e;
    }

    isLoading = false;
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) async {
    OverlayEntry loader = MethodHelpers.overlayLoader();
    try {
      Cart cart =
          Cart(productId: cartItem.productId, quantity: cartItem.quantity);
      Overlay.of(Get.overlayContext!).insert(loader);
      await CartRepository.removeFromCart(cart);
      cartItems.removeWhere((element) => element == cartItem);
      calculateSubtotal();
      Get.context?.read<CartController>().getCartCount();
    } catch (err) {
      MethodHelpers.dioErrorHandler(
        err,
      );
    }
    loader.remove();
    notifyListeners();
  }

  void incrementQuantity(CartItem cartItem) {
    if (cartItem.quantity <= 99) {
      ++cartItem.quantity;
      calculateSubtotal();
      try {
        CartRepository.updateCart(cartItem.productId, cartItem.quantity);
        Get.context?.read<CartController>().getCartCount();
      } catch (err) {
        MethodHelpers.dioErrorHandler(
          err,
        );
      }
      notifyListeners();
    }
  }

  void decrementQuantity(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      --cartItem.quantity;
      calculateSubtotal();
      try {
        CartRepository.updateCart(cartItem.productId, cartItem.quantity);
        Get.context?.read<CartController>().getCartCount();
      } catch (err) {
        MethodHelpers.dioErrorHandler(
          err,
        );
      }
      notifyListeners();
    }
  }

// We assume each variation has a final price which the user will pay.
  void calculateSubtotal() async {
    subTotal = 0;
    for (var e in cartItems) {
      int cartPrice = 0;
      // cartPrice = e.product.price;

      cartPrice = e.product.price;

      cartPrice *= e.quantity;
      subTotal += cartPrice;
    }
  }

// We assume each variation has a final price which the user will pay.
  int calculateProductPrice(CartItem cartItem) {
    int price = 0;
    price = cartItem.product.price;

    return price * cartItem.quantity;
  }
}
