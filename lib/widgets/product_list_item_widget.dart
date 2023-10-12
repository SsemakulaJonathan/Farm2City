import 'package:farm_city/constants/constant.dart';
import 'package:farm_city/controllers/user_controller.dart';
import 'package:farm_city/models/product.dart';
import 'package:farm_city/views/product_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/src/provider.dart';
import 'package:recase/recase.dart';

class ProductListItemWidget extends StatelessWidget {
  final Product product;
  final bool showFavIcon;
  const ProductListItemWidget(
      {required this.product, this.showFavIcon = false});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Get.to(
          ProductDetails(
            product: product,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(product.largeThumbnail),
                    fit: BoxFit.contain),
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
                          ReCase(product.productName).titleCase,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    context
                        .read<UserController>()
                        .currencyFomatter
                        .format(product.price),
                    style: const TextStyle(
                        fontSize: 20,
                        color: Constants.blackBG,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
