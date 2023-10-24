import 'package:flutter/widgets.dart';

export './app_colors.dart';
export './app_images.dart';
export './app_strings.dart';

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
