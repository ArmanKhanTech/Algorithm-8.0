import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:algorithm/screens/auth/login.dart';
import 'package:algorithm/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 2),
      () async {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(
          builder: (_) => StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ((BuildContext context, snapshot) {
              if (snapshot.hasData) {
                return const MainScreen();
              } else {
                return const LoginScreen();
              }
            }),
          ),
        ));
      },
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(bottom: 75),
              child: Lottie.asset(
                "assets/lottie/splash.json",
                repeat: true,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                fit: BoxFit.fill,
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 75),
            child: Center(
              child: Image.asset("assets/images/logo.png",
                  width: 200, height: 200),
            ),
          ),
          const Positioned(
            bottom: 30,
            child: Text(
              "Algorithm 8.0",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFFEA580C),
              ),
            ),
          )
        ],
      ),
    );
  }
}
