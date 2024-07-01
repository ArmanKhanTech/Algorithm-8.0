import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorScreen extends StatelessWidget {
  final String msg;

  const ErrorScreen(
      {super.key, this.msg = 'An error occurred. Please try again.'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Lottie.asset(
            "assets/lottie/error.json",
            repeat: true,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Text(
            msg,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ],
      )),
    );
  }
}
