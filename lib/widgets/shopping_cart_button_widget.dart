import 'package:farm_city/controllers/cart_controller.dart';
import 'package:farm_city/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ShoppingCartButtonWidget extends StatelessWidget {
  final Color iconColor;
  final Color labelColor;
  const ShoppingCartButtonWidget({
    required this.iconColor,
    required this.labelColor,
    Key? key,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(builder: (_, model, child) {
      return MaterialButton(
        elevation: 0,
        onPressed: () {
          if (context.read<UserController>().isLoggedIn) {
            Get.toNamed('/cart');
          } else {
            Get.toNamed('/login', arguments: {'go_to': '/cart'});
          }
        },
        color: Colors.transparent,
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: <Widget>[
            Icon(
              Icons.shopping_cart_outlined,
              color: iconColor,
              size: 28,
            ),
            Container(
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: labelColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              constraints: const BoxConstraints(
                  minWidth: 15, maxWidth: 15, minHeight: 15, maxHeight: 15),
              child: Text(
                model.count.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption!.merge(
                      const TextStyle(color: Colors.white, fontSize: 14),
                    ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
