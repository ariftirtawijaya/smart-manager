import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:sizer/sizer.dart';
import 'package:smart_manager/app/constant/app_constant.dart';

final ThemeData appThemeData = ThemeData(
  useMaterial3: false,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    // titleTextStyle: size16width500.copyWith(color: Colors.white),
  ),
  fontFamily: GoogleFonts.montserrat().fontFamily,
  primarySwatch: primaryMaterialColor,
  brightness: Brightness.light,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: darkBlue),
    bodyMedium: TextStyle(color: darkBlue),
    bodySmall: TextStyle(color: darkBlue),
    labelLarge: TextStyle(color: darkBlue),
    displayLarge: TextStyle(color: darkBlue),
    displayMedium: TextStyle(color: darkBlue),
    displaySmall: TextStyle(color: darkBlue),
    headlineMedium: TextStyle(color: darkBlue),
    headlineSmall: TextStyle(color: darkBlue),
    titleLarge: TextStyle(color: darkBlue),
    headlineLarge: TextStyle(color: darkBlue),
    labelMedium: TextStyle(color: darkBlue),
    labelSmall: TextStyle(color: darkBlue),
    titleMedium: TextStyle(color: darkBlue),
    titleSmall: TextStyle(color: darkBlue),
  ),

  // textButtonTheme: TextButtonThemeData(
  //   style: TextButton.styleFrom(
  //     // backgroundColor: primaryColor,
  //     foregroundColor: primaryColor,
  //     textStyle: TextStyle(
  //       fontFamily: GoogleFonts.montserrat().fontFamily,
  //       // fontSize: 16,
  //       color: shade,
  //     ),
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(16.0),
  //       ),
  //     ),
  //   ),
  // ),
  // outlinedButtonTheme: OutlinedButtonThemeData(
  //   style: OutlinedButton.styleFrom(
  //       minimumSize: const Size(400, 48),
  //       textStyle: TextStyle(
  //         fontFamily: GoogleFonts.montserrat().fontFamily,
  //         fontSize: 16,
  //         color: shade,
  //       ),
  //       side: const BorderSide(
  //         width: 1,
  //         color: primaryColor,
  //       ),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
  // ),
  dropdownMenuTheme: const DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    filled: false,
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        borderSide: BorderSide(color: Colors.transparent, width: 1)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
      borderSide: BorderSide(color: Colors.transparent, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        borderSide: BorderSide(color: Colors.transparent, width: 1)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        borderSide: BorderSide(color: Colors.transparent, width: 1)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        borderSide: BorderSide(color: Colors.transparent, width: 1)),
    contentPadding: EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 16),
  )),
  inputDecorationTheme: const InputDecorationTheme(
    isDense: true,
    filled: false,
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        borderSide: BorderSide(color: Colors.transparent, width: 1)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
      borderSide: BorderSide(color: Colors.transparent, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        borderSide: BorderSide(color: Colors.transparent, width: 1)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        borderSide: BorderSide(color: Colors.transparent, width: 1)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        borderSide: BorderSide(color: Colors.transparent, width: 1)),
    contentPadding: EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 16),
  ),
  // dialogTheme: DialogTheme(
  //     contentTextStyle: size16width400.copyWith(
  //         fontFamily: GoogleFonts.montserrat().fontFamily)),
  // dropdownMenuTheme: DropdownMenuThemeData(
  //     inputDecorationTheme: InputDecorationTheme(
  //   fillColor: shade,
  //   filled: true,
  //   labelStyle: size14width400,
  //   hintStyle: size14width400.copyWith(color: bodyTextColor),
  //   border: const OutlineInputBorder(
  //       borderRadius: BorderRadius.all(Radius.circular(16)),
  //       borderSide: BorderSide(color: bodyTextColor, width: 1)),
  //   enabledBorder: const OutlineInputBorder(
  //       borderRadius: BorderRadius.all(Radius.circular(16)),
  //       borderSide: BorderSide(color: bodyTextColor, width: 1)),
  //   focusedErrorBorder: const OutlineInputBorder(
  //       borderRadius: BorderRadius.all(Radius.circular(16)),
  //       borderSide: BorderSide(color: bodyTextColor, width: 1)),
  //   focusedBorder: const OutlineInputBorder(
  //       borderRadius: BorderRadius.all(Radius.circular(16)),
  //       borderSide: BorderSide(color: primaryColor, width: 1)),
  //   activeIndicatorBorder: const BorderSide(color: primaryColor, width: 1),
  //   contentPadding: const EdgeInsets.all(20),
  // )),
  // floatingActionButtonTheme: FloatingActionButtonThemeData(
  //   foregroundColor: shade,
  //   backgroundColor: primaryColor,
  //   extendedTextStyle: TextStyle(
  //     fontFamily: GoogleFonts.montserrat().fontFamily,
  //     fontSize: 16,
  //     color: shade,
  //   ),
  // ),
);
