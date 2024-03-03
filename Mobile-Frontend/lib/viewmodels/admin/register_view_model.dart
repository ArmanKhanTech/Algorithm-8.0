// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../services/auth_service.dart';

class RegisterViewModel extends ChangeNotifier {
  GlobalKey<ScaffoldState> registerScaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  bool validate = false;
  bool loading = false;

  String? name, email, password, cPassword, type;

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode typeFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();
  FocusNode cPassFocusNode = FocusNode();

  AuthService auth = AuthService();

  register(BuildContext context) async {
    FormState form = registerFormKey.currentState!;
    form.save();
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showSnackBar('Kindly fix all the errors before proceeding.', context);
    } else {
      loading = true;
      notifyListeners();
      try {
        bool success = await auth.createUser(
          name: name,
          email: email,
          type: type,
        );
        if (success) {
          showSnackBarSuccess('Account created successfully.', context);
        }
      } catch (e) {
        loading = false;
        notifyListeners();
      }
      loading = false;
      notifyListeners();
    }
  }

  setName(val) {
    name = val.toString();
    notifyListeners();
  }

  setEmail(val) {
    email = val;
    notifyListeners();
  }

  setType(val) {
    type = val;
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

  showSnackBarSuccess(String msg, context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: msg,
      ),
    );
  }
}
