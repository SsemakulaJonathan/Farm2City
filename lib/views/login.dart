import 'package:farm_city/constants/constant.dart';
import 'package:farm_city/controllers/user_controller.dart';
import 'package:farm_city/helpers/helpers.dart';
import 'package:farm_city/widgets/top_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Map user = {};
  String? role;
  String? password;
  String? confirmPassword;
  bool obsecurePassword = true;
  bool obsecureConfirmPassword = true;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.whiteBG,
        title: NavBar(),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.only(left: 20),
              color: Constants.greyBG,
              width: size.width / 1.2,
              height: 80,
              child: Row(children: const [
                Text(DefaultStrings.home),
                SizedBox(
                  width: 10,
                ),
                Text('/'),
                SizedBox(
                  width: 10,
                ),
                Text(
                  DefaultStrings.createAccount,
                  style: TextStyle(color: Constants.greenBG),
                )
              ]),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: SizedBox(
                  width: size.width / 1.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        DefaultStrings.login,
                        style: TextStyle(
                          color: Constants.blackBG,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.grey,
                        height: 1,
                        width: size.width / 1.2,
                      ),
                      const SizedBox(height: 10),
                      const Text('Email'),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: size.width / 2,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onSaved: (val) {
                            user['email'] = val!.trim();
                          },
                          validator: (val) {
                            if (isEmail(val!.trim())) {
                              return null;
                            } else {
                              return 'Valid email required';
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Email address',
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Password'),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: size.width / 2,
                        child: TextFormField(
                          obscureText: obsecurePassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onSaved: (val) {
                            user['password'] = val!.trim();
                          },
                          onChanged: (val) {
                            password = val;
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Password is required';
                            } else if (val.length < 5) {
                              return 'Minimum length is 5';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            suffixIcon: GestureDetector(
                              child: obsecurePassword
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              onTap: () {
                                setState(() {
                                  obsecurePassword = !obsecurePassword;
                                });
                              },
                            ),
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: RadioListTile(
                              title: const Text("Buyer"),
                              value: "buyer",
                              groupValue: role,
                              onChanged: (value) {
                                setState(() {
                                  role = value.toString();
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: RadioListTile(
                              title: const Text("Seller"),
                              value: "seller",
                              groupValue: role,
                              onChanged: (value) {
                                setState(() {
                                  role = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () => {
                            if (formkey.currentState!.validate())
                              {
                                formkey.currentState!.save(),
                                if (role == null)
                                  {
                                    MethodHelpers
                                        .showErrorBarWithNoActionButton(
                                            'Select your role'),
                                  }
                                else
                                  {
                                    context.read<UserController>().login(
                                          user['email'],
                                          user['password'],
                                          role.toString(),
                                        ),
                                  }
                              }
                          },
                          child: const Center(
                            child: Text(DefaultStrings.login),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 400,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
