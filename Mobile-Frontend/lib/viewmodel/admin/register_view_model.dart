// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';

import '../../service/auth_service.dart';
import '../../utility/common.dart';

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

  void register(BuildContext context) async {
    FormState form = registerFormKey.currentState!;
    form.save();

    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showErrorSnackBar(
          'Kindly fix all the errors before proceeding.', context);
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
          showSnackBar('Account created successfully.', context);
        }
      } catch (e) {
        loading = false;
        notifyListeners();
      }

      loading = false;
      notifyListeners();
    }
  }

  void setName(val) {
    name = val.toString();
    notifyListeners();
  }

  void setEmail(val) {
    email = val;
    notifyListeners();
  }

  void setType(val) {
    type = val;
    notifyListeners();
  }
}
