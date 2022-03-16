import 'package:flutter/cupertino.dart';

class ScreenData {
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static bool get isMobile {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    var isMobile = true;
    if (data.size.shortestSide < 600) {
      isMobile = true;
    } else {
      isMobile = false;
    }
    return isMobile;
  }
}
