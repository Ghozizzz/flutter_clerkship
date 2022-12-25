import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../utils/nav_helper.dart';
import '../../../utils/string_helper.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import '../../components/textareas/textarea.dart';
import 'forgot_password_otp_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final emailController = TextEditingController(text: 'dummmy@gmail.com');

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
                          NavHelper.navigatePush(ForgotPasswordOtpScreen());
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
}
