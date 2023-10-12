import 'package:farm_city/constants/constant.dart';
import 'package:farm_city/controllers/user_controller.dart';
import 'package:farm_city/helpers/helpers.dart';
import 'package:farm_city/widgets/top_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Map user = {};
  String? gender;
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
                        DefaultStrings.createAccount,
                        style: TextStyle(
                          color: Constants.blackBG,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(DefaultStrings.details),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.grey,
                        height: 1,
                        width: size.width / 1.2,
                      ),
                      const SizedBox(height: 20),
                      const Text('First Name'),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: size.width / 2,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onSaved: (val) {
                            user['firstname'] = val!.trim();
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Firstname is required';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'First name',
                              prefixIcon: Icon(Icons.person)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Last Name'),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: size.width / 2,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onSaved: (val) {
                            user['lastname'] = val!.trim();
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Lastname is required';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Last name',
                              prefixIcon: Icon(Icons.person)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Phone number'),
                      SizedBox(
                        width: size.width / 2,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onSaved: (val) {
                            user['phone_number'] = val!.trim();
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Phone number is required';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Phone number',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
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
                      const Text('Confirm Password'),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: size.width / 2,
                        child: TextFormField(
                          obscureText: obsecureConfirmPassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (val) {
                            confirmPassword = val;
                          },
                          onSaved: (val) {
                            user['confirm_password'] = val!.trim();
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Field is required';
                            } else if (val != password) {
                              return 'Passwords don\'t match';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            suffixIcon: GestureDetector(
                              child: obsecureConfirmPassword
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              onTap: () {
                                setState(() {
                                  obsecureConfirmPassword =
                                      !obsecureConfirmPassword;
                                });
                              },
                            ),
                            hintText: 'Confirm Password',
                            prefixIcon: const Icon(Icons.lock),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RadioListTile(
                        title: const Text("Buyer"),
                        value: "buyer",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                            user['role'] = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: const Text("Seller"),
                        value: "seller",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                            user['role'] = value.toString();
                          });
                        },
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
                                if (gender == null)
                                  {
                                    MethodHelpers
                                        .showErrorBarWithNoActionButton(
                                            'Select your role'),
                                  }
                                else
                                  {
                                    context
                                        .read<UserController>()
                                        .signUp(user, user['role'])
                                  }
                              }
                          },
                          child: const Center(
                            child: Text(DefaultStrings.register),
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
