import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(231, 76, 74, .1),
  100: Color.fromRGBO(231, 76, 74, .2),
  200: Color.fromRGBO(231, 76, 74, .3),
  300: Color.fromRGBO(231, 76, 74, .4),
  400: Color.fromRGBO(231, 76, 74, .5),
  500: Color.fromRGBO(231, 76, 74, .6),
  600: Color.fromRGBO(231, 76, 74, .7),
  700: Color.fromRGBO(231, 76, 74, .8),
  800: Color.fromRGBO(231, 76, 74, .9),
  900: Color.fromRGBO(231, 76, 74, 1),
};

MaterialColor colorCustom = MaterialColor(0xffE74c4a, color);

ThemeData defaultTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xFFECF0F1),
  primaryColor: Color(0xffE74c4a),
  primarySwatch: colorCustom,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xffE74c4a),
    foregroundColor: Color(0xFFECF0F1),
  ),
  cursorColor: Color(0xffE74c4a),
  accentColor: Color(0xffE74c4a),
  shadowColor: Color(0xAAe74c4a),
  appBarTheme: AppBarTheme(
    shadowColor: Color(0xAAe74c4a),
    foregroundColor: Color(0xFFECF0F1),
    actionsIconTheme: IconThemeData(
      color: Color(0xFFECF0F1),
    ),
    elevation: 10,
    iconTheme: IconThemeData(
      color: Color(0xFFECF0F1),
    ),
    centerTitle: false,
  ),
  iconTheme: IconThemeData(
    color: Color(0xFFE74c4a),
  ),
  textTheme: TextTheme(
    bodyText1: GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Color(0xFFE74c4a),
    ),
    headline1: GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Color(0xCC828282),
    ),
    headline4: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color(0xCC828282),
    ),
    headline2: GoogleFonts.roboto(
      fontSize: 10,
      fontWeight: FontWeight.w300,
      color: Color(0xAA828282),
    ),
    headline3: GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: Color(0xFFE74c4a),
    ),
    subtitle1: GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Color(0xFFECF0F1),
    ),
    subtitle2: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: Color(0xFFECF0F1),
    ),
    headline5: GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.w800,
      color: Color(0xFF828282),
    ),
  ),
  backgroundColor: Color(0xFFECF0F1),
  tabBarTheme: TabBarTheme(
    indicator: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFECF0F1), width: 3))),
    unselectedLabelStyle: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: Color(0x00ECF0F1),
    ),
    unselectedLabelColor: Color(0x55ECF0F1),
    labelColor: Color(0xFFECF0F1),
  ),
);
