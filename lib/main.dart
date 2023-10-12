import 'package:farm_city/controllers/product_controller.dart';
import 'package:farm_city/controllers/user_controller.dart';
import 'package:farm_city/views/account_created.dart';
import 'package:farm_city/views/add_product.dart';
import 'package:farm_city/views/cart.dart';
import 'package:farm_city/views/delivery_method.dart';
import 'package:farm_city/views/home_screen.dart';
import 'package:farm_city/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // runApp(const MyApp());
  runApp(const Center(
      child: Text(
    'Currently website is Disconnected',
    style: TextStyle(color: Colors.red),
  )));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserController userController = UserController();

  @override
  void initState() {
    super.initState();
    userController.init();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: userController),
        ChangeNotifierProvider(create: (_) => ProductController()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Farm City',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: null,
        routes: <String, WidgetBuilder>{
          '/': (_) => const HomeScreen(),
          '/account_created': (_) => const AccountCreated(),
          '/add_product': (_) => const AddProduct(),
          '/login': (_) => const Login(),
          '/cart': (_) => const CartScreen(),
        },
      ),
    );
  }
}
