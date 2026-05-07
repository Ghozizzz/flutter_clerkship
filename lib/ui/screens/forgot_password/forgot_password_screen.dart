import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/shared_providers/forgot_provider.dart';
import '../../../utils/string_helper.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import '../../components/textareas/textarea.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final emailController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return SafeStatusBar(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: 100.hp - statusBarHeight,
            child: Column(
              children: [
                const PrimaryAppBar(title: 'Kembali'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: Themes().primaryBold20,
                    ),
                    Text(
                      'Enter your email to recieve a reset link',
                      style: Themes().black14,
                    ).addMarginTop(16.h),
                    TextArea(
                      controller: emailController,
                      hint: 'e.g example@mail.com',
                      inputType: TextInputType.emailAddress,
                    ).addMarginTop(16.h),
                  ],
                ).addAllPadding(20.w).addExpanded,
                ValueListenableBuilder(
                    valueListenable: emailController,
                    builder: (context, value, _) {
                      return PrimaryButton(
                        enable: StringHelper.isEmail(value.text),
                        onTap: () {
                          doForgot(context);
                        },
                        text: 'Send',
                      ).addAllMargin(20.w);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void doForgot(
    BuildContext context,
  ) async {
    context.read<ForgotProvider>().doForgot(
          email: emailController.text,
        );
  }
}
