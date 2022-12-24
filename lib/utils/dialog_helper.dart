import 'package:clerkship/config/themes.dart';
import 'package:clerkship/ui/components/modal/modal_confirmation.dart';
import 'package:flutter/material.dart';

import '../ui/components/dialog/custom_progress_dialog.dart';

class DialogHelper {
  static late BuildContext context;

  static void closeDialog() {
    Navigator.pop(context);
  }

  static void initDialogHelper(BuildContext buildContext) {
    context = buildContext;
  }

  static void showModalConfirmation({
    required String title,
    required String message,
    String positiveText = 'Ok',
    String negativeText = 'Batal',
    VoidCallback? onPositiveTap,
    VoidCallback? onNegativeTap,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Themes.transparent,
      builder: ((context) {
        return ModalConfirmation(
          title: title,
          message: message,
          positiveText: positiveText,
          negativeText: negativeText,
          onPositiveTap: onPositiveTap,
          onNegativeTap: onNegativeTap,
        );
      }),
    );
  }

  static void showProgressDialog({
    String? title,
    String? message,
  }) {
    return showCustomDialog(
      dismissable: false,
      builder: (dialogContext) => CustomProgressDialog(
        title: title ?? 'Loading',
        message: message ?? 'Tunggu Sebentar...',
      ),
    );
  }

  static void showCustomDialog({
    Widget Function(BuildContext context)? builder,
    Widget? child,
    bool dismissable = true,
  }) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.translate(
          offset: Offset(0, 100 - (a1.value * 100)),
          child: Opacity(
            opacity: a1.value,
            child: child ?? Builder(builder: builder!),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) => Container(),
    );
  }

  static Future<T?> showAsyncCustomDialog<T>({
    Widget Function(BuildContext context)? builder,
    Widget? child,
    bool dismissable = true,
  }) async {
    return showDialog<T>(
      barrierDismissible: dismissable,
      context: context,
      builder: (dialogContext) => child ?? builder!(dialogContext),
    );
  }

  // static void showMessageDialog({
  //   String? title = "There's something wrong",
  //   String? body,
  // }) {
  //   showCustomDialog(
  //     child: CustomAlertDialog(
  //       title: title ?? '',
  //       message: body ?? '',
  //     ),
  //   );
  // }

  // static void showMessage(
  //   String title,
  //   String message, {
  //   VoidCallback? onConfirm,
  //   MessageType messageType = MessageType.dialog,
  // }) {
  //   switch (messageType) {
  //     case MessageType.dialog:
  //       DialogHelper.showCustomDialog(
  //         child: CustomAlertDialog(
  //           title: title,
  //           message: message,
  //           onConfirm: onConfirm,
  //         ),
  //       );
  //       break;
  //     case MessageType.toast:
  //       Fluttertoast.showToast(msg: title);
  //       break;
  //     default:
  //       DialogHelper.showCustomDialog(
  //         child: CustomAlertDialog(
  //           title: title,
  //           message: message,
  //           onConfirm: onConfirm,
  //         ),
  //       );
  //       break;
  //   }
  // }
}
