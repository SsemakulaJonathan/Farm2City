import 'package:farm_city/constants/constant.dart';
import 'package:flutter/material.dart';

class AccountCreated extends StatelessWidget {
  const AccountCreated({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Constants.greenBG),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green)),
            child: const Icon(
              Icons.email_outlined,
              color: Colors.green,
              size: 32,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Account has been created.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Proceed to login')),
              )
            ],
          )
        ],
      ),
    );
  }
}
