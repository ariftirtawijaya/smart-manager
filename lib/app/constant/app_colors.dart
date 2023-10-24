import 'package:flutter/material.dart';

import 'dart:math';

const Color primaryColor = Color(0xFF42B0FF);
const Color secondaryColor = Color(0xFFFF9900);
const Color darkBlue = Color(0xFF1F4168);
const Color oceanBlue = Color(0xFF00D1FF);
const Color softRed = Color(0xFFFF6854);
const Color purple = Color(0xFF8674F5);
const Color red = Color(0xFFFF4444);
const Color green = Color(0xFF17D85C);
const Color black = Color(0xFF000000);
const Color grey1 = Color(0xFF949494);
const Color grey2 = Color(0xFFB5B5B5);
const Color grey3 = Color(0xFFD7D7D7);
const Color grey4 = Color(0xFFF2F2F2);
const Color grey5 = Color(0xFFF9F9F9);
const Color blueShade = Color(0xFF68C0FF);
const Color lightBlue = Color(0xFFAECAFF);
const Color lighBlue2 = Color(0xFFE9F0FF);
const Color lightGreen = Color(0xFFE8FBEF);
const Color lightOrange = Color(0xFFFFF7F0);

final MaterialColor primaryMaterialColor = generateMaterialColor(primaryColor);

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: _generateTintColor(color, 0.9),
    100: _generateTintColor(color, 0.8),
    200: _generateTintColor(color, 0.6),
    300: _generateTintColor(color, 0.4),
    400: _generateTintColor(color, 0.2),
    500: color,
    600: _generateShadeColor(color, 0.1),
    700: _generateShadeColor(color, 0.2),
    800: _generateShadeColor(color, 0.3),
    900: _generateShadeColor(color, 0.4),
  });
}

int _generateTintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color _generateTintColor(Color color, double factor) => Color.fromRGBO(
    _generateTintValue(color.red, factor),
    _generateTintValue(color.green, factor),
    _generateTintValue(color.blue, factor),
    1);

int _generateShadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color _generateShadeColor(Color color, double factor) => Color.fromRGBO(
    _generateShadeValue(color.red, factor),
    _generateShadeValue(color.green, factor),
    _generateShadeValue(color.blue, factor),
    1);
