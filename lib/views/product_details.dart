import 'package:farm_city/constants/constant.dart';
import 'package:farm_city/controllers/product_controller.dart';
import 'package:farm_city/controllers/user_controller.dart';
import 'package:farm_city/models/product.dart';
import 'package:farm_city/widgets/top_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductController productController = ProductController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.whiteBG,
        title: NavBar(),
      ),
      body: ChangeNotifierProvider.value(
        value: productController,
        child: Consumer<ProductController>(builder: (_, model, child) {
          return Column(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  color: Constants.greyBG,
                  width: size.width / 1.2,
                  height: 80,
                  child: Row(children: [
                    const Text(DefaultStrings.home),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('/'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.product.productName,
                      style: const TextStyle(color: Constants.greenBG),
                    )
                  ]),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: SizedBox(
                  width: size.width / 1.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 300,
                        width: size.width / 2.3,
                        decoration: BoxDecoration(
                          border: Border.all(color: Constants.blackBG),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.product.largeThumbnail),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 350,
                        width: size.width / 2.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.productName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.grey,
                              height: 1,
                              width: size.width / 2.6,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(DefaultStrings.noReviews)
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${DefaultStrings.currency}: ${widget.product.price.toString()}",
                              style: const TextStyle(color: Constants.greenBG),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Constants.greenBG,
                              height: 5,
                              width: size.width / 2.6,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 130,
                              width: size.width / 2.6,
                              child: Text(
                                widget.product.description,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {
                                        model.decrementQuantity();
                                      },
                                      iconSize: 40,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      icon: const Icon(
                                          Icons.remove_circle_outline),
                                    ),
                                    Text(
                                      model.quantity.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(color: Colors.black),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        model.incrementQuantity();
                                      },
                                      iconSize: 40,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      icon:
                                          const Icon(Icons.add_circle_outline),
                                    )
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (context
                                        .read<UserController>()
                                        .isLoggedIn) {
                                      model.addProductToCart(
                                          widget.product.id, 1);
                                    } else {
                                      Get.toNamed(
                                        '/login',
                                      );
                                    }
                                  },
                                  child: const Center(
                                    child: Text(DefaultStrings.addToCart),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
