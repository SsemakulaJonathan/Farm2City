import 'package:farm_city/constants/constant.dart';
import 'package:farm_city/controllers/product_controller.dart';
import 'package:farm_city/widgets/product_grid_widget.dart';
import 'package:farm_city/widgets/product_list_item_widget.dart';
import 'package:farm_city/widgets/top_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Products extends StatefulWidget {
  const Products({super.key});
  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ProductController productController = ProductController();
  String layout = 'grid';
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.whiteBG,
          title: NavBar(),
        ),
        body: ChangeNotifierProvider.value(
          value: productController,
          child: Consumer<ProductController>(builder: (_, model, child) {
            return Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: DefaultTextStyle.merge(
                  child: model.isLoading
                      ? Center(
                          child: LottieBuilder.asset(
                          'assets/loading.json',
                          height: 200,
                          width: 200,
                          animate: true,
                          repeat: true,
                        ))
                      : model.products == null
                          ? const Text(
                              'Error Occured',
                              style: TextStyle(color: Colors.red),
                            )
                          : model.products.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: const Center(
                                        child: Text(
                                          'Products will appear here.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : SmartRefresher(
                                  controller: model.refreshController!,
                                  enablePullDown: false,
                                  enablePullUp: true,
                                  physics: const BouncingScrollPhysics(),
                                  onLoading: () => model.fetchMore(),
                                  footer:
                                      CustomFooter(builder: (context, mode) {
                                    if (mode == LoadStatus.idle) {
                                      return Container();
                                    } else if (mode == LoadStatus.loading) {
                                      return Center(
                                        child: LottieBuilder.asset(
                                          'assets/loading.json',
                                          height: 100,
                                          animate: true,
                                          repeat: true,
                                        ),
                                      );
                                    } else if (mode == LoadStatus.failed) {
                                      return GestureDetector(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const <Widget>[
                                              Icon(
                                                Icons.error,
                                                color: Colors.red,
                                              ),
                                              SizedBox(width: 20),
                                              Text(
                                                'Retry',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.black),
                                              )
                                            ]),
                                        onTap: () {
                                          model.fetchMore();
                                        },
                                      );
                                    } else if (mode == LoadStatus.canLoading) {
                                      return Container();
                                    } else {
                                      return Container();
                                    }
                                  }),
                                  child: CustomScrollView(
                                    slivers: [
                                      SliverPadding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 10),
                                          sliver: SliverToBoxAdapter(
                                            child: ListTile(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0),
                                              title: const Text(
                                                'Layout',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        layout = 'list';
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .format_list_bulleted,
                                                      color: layout == 'list'
                                                          ? Theme.of(context)
                                                              .accentColor
                                                          : Theme.of(context)
                                                              .focusColor,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        layout = 'grid';
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.apps,
                                                      color: layout == 'grid'
                                                          ? Theme.of(context)
                                                              .accentColor
                                                          : Theme.of(context)
                                                              .focusColor,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                      const SliverToBoxAdapter(
                                        child: SizedBox(
                                          height: 15,
                                        ),
                                      ),
                                      if (layout == 'grid')
                                        SliverToBoxAdapter(
                                          child: StaggeredGrid.extent(
                                              maxCrossAxisExtent: 100,
                                              mainAxisSpacing: 8,
                                              crossAxisSpacing: 8,
                                              children: List.generate(
                                                  model.products.length,
                                                  (index) {
                                                return ProductGridItemWidget(
                                                  product:
                                                      model.products[index],
                                                );
                                              })),
                                        ),
                                      if (layout != 'grid')
                                        SliverToBoxAdapter(
                                          child: ListView.separated(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            primary: false,
                                            itemCount: model.products.length,
                                            separatorBuilder: (context, index) {
                                              return const SizedBox(height: 10);
                                            },
                                            itemBuilder: (context, index) {
                                              return ProductListItemWidget(
                                                product: model.products[index],
                                              );
                                            },
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                  style: TextStyle(color: Colors.black)),
            );
          }),
        ));
  }
}
