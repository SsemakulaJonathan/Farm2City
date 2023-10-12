import 'package:farm_city/constants/constant.dart';
import 'package:farm_city/controllers/user_controller.dart';
import 'package:farm_city/views/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:farm_city/models/product.dart';
import 'package:recase/recase.dart';

class ProductGridItemWidget extends StatelessWidget {
  final Product product;
  final bool showFavIcon;
  const ProductGridItemWidget(
      {required this.product, this.showFavIcon = false});
  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: 2,
        child: Container(
          width: 180,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Theme.of(context).accentColor.withOpacity(0.08),
            onTap: () {
              Get.to(
                ProductDetails(
                  product: product,
                ),
              );
            },
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(product.largeThumbnail),
                              fit: BoxFit.contain),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      color: const Color(0xffF3F3F3),
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ReCase(product.productName).titleCase,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
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
                if (showFavIcon)
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: 40,
                    height: 40,
                    child: MaterialButton(
                      elevation: 0,
                      padding: const EdgeInsets.all(0),
                      onPressed: () {},
                      color: Colors.white,
                      shape: const StadiumBorder(),
                      child: const Icon(
                        Icons.favorite_outline,
                        color: Constants.blackBG,
                        size: 24,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
