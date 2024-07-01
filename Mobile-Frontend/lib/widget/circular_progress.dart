import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: non_constant_identifier_names
Center CircularProgress(context, Color color, {double size = 50.0}) {
  return Center(
    child: SpinKitFadingCircle(
      size: size,
      color: color,
    ),
  );
}
