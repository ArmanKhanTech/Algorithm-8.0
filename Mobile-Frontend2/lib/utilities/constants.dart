import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static const String appName = 'Algorithm';

  static const Color orange = Color(0xFFEA580C);

  static const Color darkPrimary = Color.fromARGB(255, 0, 0, 0);
  static const Color darkAccent = Color.fromARGB(255, 255, 255, 255);
  static const Color darkBG = Color.fromARGB(255, 0, 0, 0);

  static ThemeData theme = ThemeData(
    iconTheme: const IconThemeData(color: Colors.white),
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBG,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: darkAccent,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      elevation: 0,
      color: darkBG,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: darkBG,
      iconTheme: const IconThemeData(color: Colors.white),
      toolbarTextStyle: GoogleFonts.nunitoSans(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
      ),
      titleTextStyle: GoogleFonts.nunitoSans(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: null,
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: darkAccent,
    )
        .copyWith(
          secondary: darkAccent,
          brightness: Brightness.dark,
        )
        .copyWith(background: darkBG),
  );
}
