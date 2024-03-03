// ignore_for_file: use_build_context_synchronously
import 'package:algorithm/utilities/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'package:algorithm/screens/home.dart';
import 'package:algorithm/services/auth_service.dart';
import 'package:algorithm/utilities/regex.dart';
import 'package:algorithm/models/user_model.dart';
import 'package:algorithm/screens/error.dart';

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

  loginUser(BuildContext context) async {
    FormState form = loginFormKey.currentState!;
    form.save();
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showSnackBar("Please fix all the errors before continuing.", context);
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
            showSnackBar(
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

  setEmail(val) {
    email = val;
    notifyListeners();
  }

  setPassword(val) {
    password = val;
    notifyListeners();
  }

  forgotPassword(BuildContext context) async {
    loading = true;
    notifyListeners();
    FormState form = loginFormKey.currentState!;
    form.save();
    if (Regex.validateEmail(email) != null) {
      showSnackBar(
          'Please input a valid email to reset your password.', context);
    } else {
      try {
        await authService.forgotPassword(email!);
        showSnackBar(
            'Please check your email for instructions to reset your password.',
            context);
      } catch (e) {
        showSnackBar(e.toString(), context);
      }
    }
    loading = false;
    notifyListeners();
  }

  showSnackBar(String msg, context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: msg,
      ),
    );
  }
}
