import 'package:farm_city/constants/constant.dart';
import 'package:farm_city/controllers/checkout_controller.dart';
import 'package:farm_city/controllers/user_controller.dart';
import 'package:farm_city/helpers/helpers.dart';
import 'package:farm_city/models/cart_item.dart';
import 'package:farm_city/widgets/error_widget.dart';
import 'package:farm_city/widgets/top_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DeliveryMethod extends StatefulWidget {
  final double subTotal;
  final List<CartItem> cartItems;
  const DeliveryMethod(
      {super.key, required this.subTotal, required this.cartItems});

  @override
  State<DeliveryMethod> createState() => _DeliveryMethodState();
}

class _DeliveryMethodState extends State<DeliveryMethod> {
  CheckOutController checkOutController = CheckOutController();

  @override
  void initState() {
    super.initState();
    checkOutController.subTotal = widget.subTotal;
    checkOutController.cartItems = widget.cartItems;
    // checkOutController.init(selected: deliveryAddress);
  }

  @override
  void dispose() {
    super.dispose();
    checkOutController.dispose();
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
        value: checkOutController,
        child: Consumer<CheckOutController>(builder: (_, model, child) {
          return Center(
            child: Container(
              width: size.width / 2,
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
                      : model.exception != null
                          ? AppErrorWidget(
                              retry: true,
                              exception: model.exception,
                            )
                          : ListView(
                              padding: const EdgeInsets.all(10),
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Divider(),
                                    Text(
                                      'Select payment method',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    RadioListTile(
                                        title: Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/airtel.svg',
                                              height: 40,
                                              width: 40,
                                              placeholderBuilder: (context) =>
                                                  const CircularProgressIndicator(),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Image.asset(
                                              'assets/mtn.png',
                                              height: 50,
                                              width: 50,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text('Cash On Delivery')
                                          ],
                                        ),
                                        value: 'mobile_money',
                                        groupValue: model.paymentMethod,
                                        toggleable: true,
                                        onChanged: (value) {
                                          setState(() {});
                                        }),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Delivery fee: ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                        const Text('2000'),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Total: ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                        Text(
                                          context
                                              .read<UserController>()
                                              .currencyFomatter
                                              .format(model.subTotal),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Subtotal: ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                        Text(
                                          context
                                              .read<UserController>()
                                              .currencyFomatter
                                              .format(model.total + 2000),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Divider(),
                                    TextFormField(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        cursorColor: Colors.black,
                                        onChanged: (String val) {
                                          model.instructions = val;
                                        },
                                        maxLines: 4,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          hintText:
                                              'Please type in your delivery address here ...',
                                          hintStyle: const TextStyle(
                                              color: Colors.black38),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                                width: 1.0,
                                                color: Constants.blackBG),
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: const BorderSide(
                                                  width: 1.0,
                                                  color: Color(0xffcacaca))),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                              width: 1.0,
                                            ),
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                padding:
                                                    MaterialStateProperty.all(
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14),
                                                ),
                                              ),
                                              onPressed: () {
                                                if (model.instructions ==
                                                    null) {
                                                  MethodHelpers
                                                      .showErrorBarWithNoActionButton(
                                                          "Please set your delivery address.");
                                                } else {
                                                  model.listenToPayment(
                                                      model.subTotal! + 2000,
                                                      model.instructions);
                                                }
                                              },
                                              child: const Text('Make Order')),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                  style: TextStyle(color: Colors.black)),
            ),
          );
        }),
      ),
    );
  }
}
