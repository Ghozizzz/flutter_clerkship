import 'package:clerkship/ui/components/dialog/custom_alert_dialog.dart';
import 'package:clerkship/utils/dialog_helper.dart';
import 'package:flutter/foundation.dart';

import '../../main.dart';
import '../network/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final authService = getIt<AuthService>();

  void doLogin({
    required String email,
    required String password,
    required Function(bool isSuccess) onFinish,
  }) async {
    DialogHelper.showProgressDialog();
    final result = await authService.doLogin(email: email, password: password);
    DialogHelper.closeDialog();

    if (result.statusCode == 400) {
      DialogHelper.showMessageDialog(
        title: 'title',
        body: '',
        alertType: AlertType.sucecss,
      );
    } else {}

    onFinish(result.statusCode == 200);
  }
}
