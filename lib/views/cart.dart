import 'package:farm_city/constants/constant.dart';
import 'package:farm_city/controllers/cart_controller.dart';
import 'package:farm_city/controllers/user_controller.dart';
import 'package:farm_city/views/delivery_method.dart';
import 'package:farm_city/widgets/cart_item_widget.dart';
import 'package:farm_city/widgets/empty_cart_widget.dart';
import 'package:farm_city/widgets/error_widget.dart';
import 'package:farm_city/widgets/top_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartController cartController = CartController();

  @override
  void initState() {
    super.initState();
    cartController.getUserCart();
  }

  @override
  void dispose() {
    super.dispose();
    cartController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.whiteBG,
        title: NavBar(),
      ),
      body: ChangeNotifierProvider.value(
        value: cartController,
        child: Consumer<CartController>(
          builder: (_, model, child) {
            if (model.isLoading) {
              return Center(
                child: LottieBuilder.asset(
                  'assets/loading.json',
                  height: 200,
                  width: 200,
                  animate: true,
                  repeat: true,
                ),
              );
            }
            if (!model.isLoading && model.cartItems == null) {
              return AppErrorWidget(
                retry: true,
                exception: model.exception,
              );
            }

            if (!model.isLoading && model.cartItems.isEmpty) {
              return const EmptyCartWidget();
            }

            return Center(
              child: SizedBox(
                height: size.height / 2,
                width: size.width / 2,
                child: ListView.separated(
                    itemBuilder: (ctx, index) {
                      if (index <= model.cartItems.length - 1) {
                        return CartItemWidget(
                          cartItem: model.cartItems[index],
                        );
                      } else {
                        return Column(
                          children: [
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Subtotal: ',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  context
                                      .read<UserController>()
                                      .currencyFomatter
                                      .format(model.subTotal),
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Delivery Fee: ',
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Text(
                                      '2000',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(DeliveryMethod(
                                      subTotal: model.subTotal,
                                      cartItems: model.cartItems,
                                    ));
                                  },
                                  child: const Text(
                                    'Checkout',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            )
                          ],
                        );
                      }
                    },
                    separatorBuilder: (ctx, index) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                    itemCount: model.cartItems.length + 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
