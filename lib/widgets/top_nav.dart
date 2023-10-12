import 'package:farm_city/constants/constant.dart';
import 'package:farm_city/controllers/cart_controller.dart';
import 'package:farm_city/controllers/product_controller.dart';
import 'package:farm_city/controllers/user_controller.dart';
import 'package:farm_city/models/cart.dart';
import 'package:farm_city/views/cart.dart';
import 'package:farm_city/views/home_screen.dart';
import 'package:farm_city/views/login.dart';
import 'package:farm_city/views/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  CartController cartController = CartController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartController,
      child: Consumer<CartController>(
        builder: (_, model, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 50,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => {
                      Get.to(
                        const HomeScreen(),
                      )
                    },
                    child: const Center(
                      child: Text(DefaultStrings.home),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  const Text(
                    DefaultStrings.callUs,
                    style: TextStyle(color: Constants.blackBG),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  if (context.read<UserController>().isLoggedIn &&
                      context.read<UserController>().user!.role == "seller")
                    ElevatedButton(
                      onPressed: () => {
                        Get.offNamed('/add_product'),
                      },
                      child: const Center(
                        child: Text('Add Product'),
                      ),
                    ),
                  const SizedBox(
                    width: 50,
                  ),
                  if (context.read<UserController>().isLoggedIn)
                    IconButton(
                      onPressed: () => {
                        context.read<UserController>().logOut(),
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Constants.blackBG,
                      ),
                    ),
                  if (!context.read<UserController>().isLoggedIn)
                    ElevatedButton(
                      onPressed: () => {Get.to(const Login())},
                      child: const Center(
                        child: Text(DefaultStrings.signIn),
                      ),
                    ),
                  const SizedBox(
                    width: 50,
                  ),
                  if (context.read<UserController>().isLoggedIn)
                    Text(
                      context.read<UserController>().user!.firstName,
                      style: const TextStyle(color: Constants.blackBG),
                    ),
                  if (!context.read<UserController>().isLoggedIn)
                    ElevatedButton(
                      onPressed: () => {
                        Get.to(
                          const Register(),
                        )
                      },
                      child: const Center(
                        child: Text(DefaultStrings.getStarted),
                      ),
                    ),
                  const SizedBox(
                    width: 50,
                  ),
                  if (context.read<UserController>().isLoggedIn)
                    Stack(
                      children: [
                        const SizedBox(height: 40, width: 40),
                        Positioned(
                          bottom: 5,
                          child: IconButton(
                            onPressed: () => {Get.to(const CartScreen())},
                            icon: const Icon(
                              Icons.shopping_bag,
                              color: Constants.greenBG,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: const BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                            child: Center(
                              child: Text(
                                model.count.toString(),
                                style: const TextStyle(
                                    color: Constants.whiteBG, fontSize: 10),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
