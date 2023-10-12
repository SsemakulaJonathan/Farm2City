import 'package:farm_city/constants/constant.dart';
import 'package:farm_city/controllers/checkout_controller.dart';
import 'package:farm_city/controllers/user_controller.dart';
import 'package:farm_city/views/home_screen.dart';
import 'package:farm_city/widgets/top_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OrderSuccess extends StatelessWidget {
  final CheckOutController checkOutController;
  const OrderSuccess({super.key, required this.checkOutController});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.whiteBG,
        title: NavBar(),
      ),
      body: Center(
        child: SizedBox(
          width: size.width / 2,
          child: WillPopScope(
            onWillPop: () => Future.value(false),
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Constants.blackBG)),
                  padding: const EdgeInsets.all(20),
                  child: SvgPicture.asset(
                    'assets/check.svg',
                    height: 40,
                    placeholderBuilder: (context) =>
                        const CircularProgressIndicator(),
                    color: Constants.blackBG,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Your order was successfully received',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .merge(const TextStyle(fontWeight: FontWeight.w300)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.15),
                            offset: const Offset(0, -2),
                            blurRadius: 5.0)
                      ]),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          children: List.generate(
                              checkOutController.cartItems!.length,
                              (index) => Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          checkOutController.cartItems![index]
                                              .product.productName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                      Text(
                                          'x${checkOutController.cartItems![index].quantity}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(color: Colors.white))
                                    ],
                                  )),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      child: MaterialButton(
                        elevation: 0,
                        onPressed: () {
                          Get.to(
                            const HomeScreen(),
                          );
                        },
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        color: Theme.of(context).accentColor,
                        shape: const StadiumBorder(),
                        child: const Text(
                          'Done',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
