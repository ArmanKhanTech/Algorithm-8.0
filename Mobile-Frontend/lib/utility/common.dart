import 'package:algorithm/utility/constants.dart';

import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

InputBorder border(BuildContext context, String whichPage) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide(
      color: whichPage == "login" ? Constants.orange : Colors.blue,
      width: .5,
    ),
  );
}

InputBorder focusBorder(BuildContext context, String whichPage) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide(
      color: whichPage == "login" ? Constants.orange : Colors.blue,
      width: 1.0,
    ),
  );
}

void showSnackBar(String msg, context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.success(
      message: msg,
    ),
  );
}

void showErrorSnackBar(String msg, context) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.error(
      message: msg,
    ),
  );
}
