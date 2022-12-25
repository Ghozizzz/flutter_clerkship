import 'package:flutter/material.dart';

class NavHelper {
  static late BuildContext buildContext;

  static void pop({dynamic data}) {
    Navigator.pop(buildContext, data);
  }

  static void initNavHelper(BuildContext context) {
    buildContext = context;
  }

  static void navigateRefresh(
    Widget screen,
    String route,
  ) {
    Navigator.pushAndRemoveUntil<void>(
      buildContext,
      MaterialPageRoute(builder: (context) => screen),
      ModalRoute.withName(route),
    );
  }

  static void navigateReplace(
    Widget screen,
  ) {
    Navigator.pushReplacement(
      buildContext,
      MaterialPageRoute<void>(builder: (context) {
        return screen;
      }),
    );
  }

  static void navigatePush(
    Widget screen,
  ) {
    Navigator.push<void>(
      buildContext,
      MaterialPageRoute(builder: (context) {
        return screen;
      }),
    );
  }

  static Future<T?> navigatePushAsync<T>(
    Widget screen,
  ) async {
    return Navigator.push<T>(
      buildContext,
      MaterialPageRoute(builder: (context) {
        return screen;
      }),
    );
  }
}
