import 'package:clerkship/ui/components/dialog/custom_alert_dialog.dart';
import 'package:clerkship/utils/dialog_helper.dart';
import 'package:clerkship/utils/nav_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/constant.dart';
import '../../main.dart';
import '../../ui/screens/login/login_screen.dart';
import '../network/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final authService = getIt<AuthService>();
  SharedPreferences? prefs;

  void doLogin({
    required String email,
    required String password,
    required Function(bool isSuccess) onFinish,
  }) async {
    prefs ??= await SharedPreferences.getInstance();

    DialogHelper.showProgressDialog();
    final result = await authService.doLogin(email: email, password: password);
    DialogHelper.closeDialog();

    if (result.statusCode == 200) {
      if (result.data?.token != null) {
        prefs?.setString(Constant.token, result.data!.token!);
      }
      onFinish(true);
    } else {
      DialogHelper.showMessageDialog(
        title: 'Error',
        body: result.data?.message,
        alertType: AlertType.sucecss,
      );
    }
  }

  void doLogout() async {
    prefs ??= await SharedPreferences.getInstance();

    DialogHelper.showProgressDialog();
    final result = await authService.doLogout();
    DialogHelper.closeDialog();

    if (result.statusCode == 200) {
      prefs?.remove(Constant.token);
      NavHelper.navigateReplace(LoginScreen());
    } else {
      DialogHelper.showMessageDialog(
        title: 'Error',
        body: result.data?.message,
        alertType: AlertType.error,
      );
    }
  }

  Future<bool> isLogged() async {
    prefs ??= await SharedPreferences.getInstance();
    final token = prefs?.getString(Constant.token);

    return token != null;
  }
}
