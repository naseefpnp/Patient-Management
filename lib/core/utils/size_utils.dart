import 'package:flutter/material.dart';

class SizeUtils {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double scaleWidth;
  static late double scaleHeight;
  static late double textScaleFactor;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    scaleWidth = screenWidth / 375;
    scaleHeight = screenHeight / 812;
    textScaleFactor = scaleWidth;
  }

  static double w(double width) => width * scaleWidth;
  static double h(double height) => height * scaleHeight;
  static double sp(double fontSize) => fontSize * textScaleFactor;
}
