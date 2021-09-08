import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playas/src/widgets/components.dart';

import 'storage-manager.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      backgroundColor: const Color(0xFF212121),
      accentColor: Colors.white,
      accentIconTheme: IconThemeData(color: Colors.black),
      dividerColor: Colors.black12,
      textTheme: TextTheme(
        bodyText2: GoogleFonts.sourceCodePro(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          letterSpacing: 0.3,
          color: Colors.white,
        ),
        bodyText1: GoogleFonts.dancingScript(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        headline1: GoogleFonts.courgette(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.lightGreenAccent)),
        hintStyle: TextStyle(fontSize: 12.0, color: Colors.white),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
      ));

  final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      //primarySwatch: Colors.white,
      primaryColor: colorPrimary,
      accentColor: colorSecond,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      accentIconTheme: IconThemeData(color: Colors.white),
      dividerColor: Colors.white54,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(colorPrimary),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        )),
      )),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.black),
        errorStyle: TextStyle(color: Colors.red, fontSize: 12),
        hintStyle: TextStyle(fontSize: 12.0, color: Colors.black),
      ),
      textTheme: TextTheme(
        headline1: GoogleFonts.sourceCodePro(
          //LA USO: tramites_pages
          fontSize: 20,
          color: colorPrimary,
          fontWeight: FontWeight.bold,
        ),
        headline2: GoogleFonts.sourceCodePro(
          //LA USO: tramites_pages
          fontSize: 16,
          color: Colors.black,
        ),
        headline3: GoogleFonts.sourceCodePro(
          fontSize: 25,
          color: colorPrimary,
          fontWeight: FontWeight.bold,
        ),
        bodyText2: GoogleFonts.sourceCodePro(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          letterSpacing: 0.3,
          color: colorPrimary,
        ),
        bodyText1: GoogleFonts.sourceCodePro(
          fontSize: 25,
          color: colorPrimary,
          fontWeight: FontWeight.bold,
        ),
        headline5: GoogleFonts.sourceCodePro(
          fontSize: 12,
          color: colorPrimary,
          fontWeight: FontWeight.bold,
        ),
        headline6: GoogleFonts.sourceCodePro(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        titleTextStyle: GoogleFonts.sourceCodePro(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          letterSpacing: 0.1,
          color: Colors.black,
        ),
      ));

  ThemeData? _themeData;

  ThemeData? getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
