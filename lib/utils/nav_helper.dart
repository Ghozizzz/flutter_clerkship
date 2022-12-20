import 'package:flutter/material.dart';

class NavHelper {
  static void navigateRefresh(
    BuildContext context,
    Widget screen,
    String route,
  ) {
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute(builder: (context) => screen),
      ModalRoute.withName(route),
    );
  }

  static void navigateReplace(
    BuildContext context,
    Widget screen,
  ) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(builder: (context) {
        return screen;
      }),
    );
  }

  static void navigatePush(
    BuildContext context,
    Widget screen,
  ) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (context) {
        return screen;
      }),
    );
  }

  static Future<T?> navigatePushAsync<T>(
    BuildContext context,
    Widget screen,
  ) async {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(builder: (context) {
        return screen;
      }),
    );
  }
}
