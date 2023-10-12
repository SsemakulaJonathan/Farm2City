import 'dart:async';

import 'package:farm_city/constants/constant.dart';
import 'package:farm_city/controllers/product_controller.dart';
import 'package:farm_city/views/product_details.dart';
import 'package:farm_city/views/products.dart';
import 'package:farm_city/widgets/top_nav.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ProductController productController = ProductController();
  @override
  void initState() {
    super.initState();
    productController.refreshController = refreshController;
    productController.fetch();
  }

  @override
  void dispose() {
    super.dispose();
    productController.dispose();
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
        value: productController,
        child: Consumer<ProductController>(
          builder: (_, model, child) {
            if (model.isLoading) {
              return Center(
                  child: LottieBuilder.asset(
                'assets/loading.json',
                height: 200,
                width: 200,
                animate: true,
                repeat: true,
              ));
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: size.height / 2,
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: size.width / 2.5,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(Constants.image2),
                              ),
                            ),
                          ),
                          Container(
                            width: size.width / 2,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(Constants.image1),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          DefaultStrings.featuredProducts,
                          style: TextStyle(
                            color: Constants.blackBG,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => {Get.to(const Products())},
                          child: const Center(
                            child: Text('See All'),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (model.products.isEmpty)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: const Center(
                              child: Text(
                                'Featured Products will appear here.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25, color: Constants.blackBG),
                              ),
                            ),
                          )
                        ],
                      ),
                    if (model.products.isNotEmpty)
                      SizedBox(
                        height: size.height / 1.6,
                        width: size.width,
                        child: SizedBox(
                            child: CarouselSlider.builder(
                          itemCount: model.products.length,
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                          ),
                          itemBuilder: (context, index, realIdx) {
                            var data = model.products[index];
                            return Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Column(
                                  crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        SizedBox(
                                          height: size.height / 3,
                                          child: Center(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              child: Image.network(
                                                data.largeThumbnail,
                                                fit: BoxFit.cover,
                                                width: size.width - 50,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.productName,
                                          style: const TextStyle(
                                            color: Constants.blackBG,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          data.description,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Constants.blackBG,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "${DefaultStrings.currency}: ${data.price.toString()}",
                                          style: const TextStyle(
                                            color: Constants.blackBG,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: ElevatedButton(
                                            onPressed: () => {
                                              Get.to(
                                                ProductDetails(
                                                  product: data,
                                                ),
                                              )
                                            },
                                            child: const Center(
                                              child: Text(
                                                DefaultStrings.viewDetails,
                                                style: TextStyle(
                                                  color: Constants.whiteBG,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Container(height: 500, width: size.width, color: Colors.red)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
