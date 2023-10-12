import 'package:farm_city/constants/constant.dart';
import 'package:farm_city/controllers/cart_controller.dart';
import 'package:farm_city/controllers/user_controller.dart';
import 'package:farm_city/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  const CartItemWidget({super.key, required this.cartItem});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(cartItem.product.largeThumbnail),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(width: 15),
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              ReCase(cartItem.product.productName).titleCase,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        context.read<UserController>().currencyFomatter.format(
                            context
                                .read<CartController>()
                                .calculateProductPrice(cartItem)),
                        style: const TextStyle(
                            fontSize: 20,
                            color: Constants.blackBG,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                )
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                    onPressed: () {
                      context.read<CartController>().removeFromCart(cartItem);
                    },
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          const BorderSide(color: Constants.blackBG)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                    ),
                    child: const Text('Remove')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        context
                            .read<CartController>()
                            .decrementQuantity(cartItem);
                      },
                      iconSize: 40,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text(cartItem.quantity.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.black)),
                    IconButton(
                      onPressed: () {
                        context
                            .read<CartController>()
                            .incrementQuantity(cartItem);
                      },
                      iconSize: 40,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      icon: const Icon(Icons.add_circle_outline),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
