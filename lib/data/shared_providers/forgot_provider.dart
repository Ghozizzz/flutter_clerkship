import 'package:clerkship/ui/components/dialog/custom_alert_dialog.dart';
import 'package:clerkship/utils/dialog_helper.dart';
import 'package:clerkship/utils/nav_helper.dart';
import 'package:flutter/foundation.dart';

import '../../main.dart';
import '../../ui/screens/forgot_password/forgot_password_otp_screen.dart';
import '../../ui/screens/forgot_password/update_password_screen.dart';
import '../network/services/forgot_service.dart';

class ForgotProvider extends ChangeNotifier {
  final forgotService = getIt<ForgotService>();

  void doForgot({
    required String email,
  }) async {
    DialogHelper.showProgressDialog();
    final result = await forgotService.doForgot(email: email);
    DialogHelper.closeDialog();

    if (result.statusCode == 200) {
      NavHelper.navigateReplace(
        ForgotPasswordOtpScreen(id: result.data!.data!),
      );
    } else {
      DialogHelper.showMessageDialog(
        title: 'Error',
        body: result.data?.message,
        alertType: AlertType.success,
      );
    }
  }

  void doOtpCheck({
    required String email,
    required String otp,
  }) async {
    DialogHelper.showProgressDialog();
    final result = await forgotService.doOtpCheck(email: email, otp: otp);
    DialogHelper.closeDialog();

    if (result.statusCode == 200) {
      NavHelper.navigateReplace(UpdatePasswordScreen(id: result.data!.data!));
    } else {
      DialogHelper.showMessageDialog(
        title: 'Error',
        body: result.data?.message,
        alertType: AlertType.error,
      );
    }
  }

  void doResetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    DialogHelper.showProgressDialog();
    final result = await forgotService.doResetPassword(
        email: email, password: password, confirmPassword: confirmPassword);
    DialogHelper.closeDialog();

    if (result.statusCode == 200) {
      NavHelper.pop();
      DialogHelper.showMessageDialog(
        title: 'Success',
        body: result.data!.message.toString(),
        alertType: AlertType.error,
      );
    } else {
      DialogHelper.showMessageDialog(
        title: 'Error',
        body: result.data?.message,
        alertType: AlertType.error,
      );
    }
  }
}
