import 'dart:collection';
import 'package:farm_city/controllers/cart_controller.dart';
import 'package:farm_city/helpers/helpers.dart';
import 'package:farm_city/models/cart.dart';
import 'package:farm_city/models/cart_item.dart';
import 'package:farm_city/models/product.dart';
import 'package:farm_city/models/product_upload.dart';
import 'package:farm_city/repositories/cart_repositiry.dart';
import 'package:farm_city/repositories/product_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

class ProductController with ChangeNotifier {
  List<Product> products = [];
  List<CartItem> cartItems = [];
  bool isPestries = false;
  bool isFeatured = false;
  ProductUpload productUpload =
      ProductUpload(productName: '', price: 0, categoryId: 1, description: '');
  bool isAccessory = false;
  bool isIngredient = false;
  int quantity = 1;
  Product? product;
  bool isFavourite = false;
  int nextPage = 0;
  bool loadCart = false;
  bool isLoading = true;
  bool isLoadingMore = true;
  dynamic exception;
  RefreshController? refreshController;
  int perPage = 15;
  bool fetchByCate = false;
  int? cateId;
  void fetchMore() async {
    try {
      nextPage = nextPage + 1;

      List<Product> results = await ProductRepository.getProducts();

      if (results.length < perPage) {
        refreshController?.loadNoData();
      } else {
        refreshController?.loadComplete();
      }
      products.addAll(results);
    } catch (_) {
      nextPage = nextPage - 1;
      refreshController?.loadFailed();
    }

    notifyListeners();
  }

  incrementQuantity() {
    if (quantity <= 999) {
      ++quantity;
    }
    notifyListeners();
  }

  void addProductToCart(int productId, int quantity) async {
    loadCart = true;
    notifyListeners();
    try {
      Cart newCart = Cart(quantity: 0);
      newCart.quantity = quantity;
      newCart.productId = product?.id;
      // If product exist in the cart then increment quantity
      // var oldCart = await CartRepository.isExistInCart(newCart);
      // if (oldCart != null) {
      //   oldCart.quantity += quantity;
      //   // Update cart
      //   await CartRepository.updateCart(product!.id, oldCart.quantity);
      //   MethodHelpers.showSuccessWithNoActionButton(
      //       "This Product was added to cart",
      //       snackPosition: SnackPosition.TOP);
      // } else {
      // Add to cart
      await CartRepository.addToCart(productId, quantity);
      MethodHelpers.showSuccessWithNoActionButton(
          "This Product was added to cart",
          snackPosition: SnackPosition.TOP);
      // }
      //await Get.context?.read<CartController>().getCartCount();
    } catch (err) {
      MethodHelpers.dioErrorHandler(
        err,
      );
    }
    loadCart = false;
    notifyListeners();
  }

  decrementQuantity() {
    if (quantity > 1) {
      --quantity;
    }
    notifyListeners();
  }

  void fetch() async {
    if (isLoading == false) {
      isLoading = true;
      exception = null;
      notifyListeners();
    }
    try {
      products = [];
      List<Product> results = await ProductRepository.getProducts();

      if (results.length < perPage) {
        refreshController?.loadNoData();
      }

      products.addAll(results);
    } catch (e) {
      exception = e;
    }

    isLoading = false;
    notifyListeners();
  }

  void submit(ProductUpload productUpload, List<String> images) async {
    OverlayEntry loader = MethodHelpers.overlayLoader();
    try {
      Overlay.of(Get.overlayContext!).insert(loader);
      await ProductRepository.addProduct(productUpload, images);
      loader.remove();
      // Get.offNamed('/success',
      //     arguments: {'message': 'Product successfully created'});
    } catch (err) {
      loader.remove();
      MethodHelpers.dioErrorHandler(err);
    }
  }

  @override
  void dispose() {
    refreshController?.dispose();
    super.dispose();
  }
}
