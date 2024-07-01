// ignore_for_file: use_build_context_synchronously
import 'package:algorithm/utility/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:algorithm/screen/home.dart';
import 'package:algorithm/service/auth_service.dart';
import 'package:algorithm/utility/regex.dart';
import 'package:algorithm/model/user_model.dart';
import 'package:algorithm/screen/error.dart';

import '../../utility/common.dart';

class LoginViewModel extends ChangeNotifier {
  GlobalKey<ScaffoldState> loginScaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  bool validate = false;
  bool loading = false;

  String? email, password;

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  AuthService authService = AuthService();

  UserModel? user;

  void loginUser(BuildContext context) async {
    FormState form = loginFormKey.currentState!;
    form.save();

    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showErrorSnackBar(
          "Please fix all the errors before continuing.", context);
    } else {
      await usersRef.where('email', isEqualTo: email).get().then((value) async {
        if (value.docs.isNotEmpty) {
          loading = true;
          notifyListeners();

          try {
            bool success = await authService.loginUser(
              email: email,
              password: password,
            );

            if (success) {
              Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(builder: (_) => const MainScreen()));
            }
          } catch (e) {
            loading = false;
            notifyListeners();
            showErrorSnackBar(
                authService.handleFirebaseAuthError(e.toString()), context);
          }
        } else {
          loading = false;
          notifyListeners();

          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const ErrorScreen(
                msg: 'User not found.',
              ),
            ),
          );
        }
      });
    }

    loading = false;
    notifyListeners();
  }

  void setEmail(val) {
    email = val;
    notifyListeners();
  }

  void setPassword(val) {
    password = val;
    notifyListeners();
  }

  void forgotPassword(BuildContext context) async {
    loading = true;
    notifyListeners();

    FormState form = loginFormKey.currentState!;
    form.save();

    if (Regex.validateEmail(email) != null) {
      showErrorSnackBar(
          'Please input a valid email to reset your password.', context);
    } else {
      try {
        await authService.forgotPassword(email!);
        showSnackBar(
            'Please check your email for instructions to reset your password.',
            context);
      } catch (e) {
        showErrorSnackBar(e.toString(), context);
      }
    }

    loading = false;
    notifyListeners();
  }
}
