import 'package:clerkship/config/themes.dart';
import 'package:clerkship/ui/components/buttons/primary_button.dart';
import 'package:clerkship/ui/components/commons/primary_appbar.dart';
import 'package:clerkship/ui/components/commons/safe_statusbar.dart';
import 'package:clerkship/ui/components/textareas/textarea.dart';
import 'package:clerkship/utils/string_helper.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return SafeStatusBar(
      lightIcon: true,
      statusBarColor: Themes.primary,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            height: 100.hp - statusBarHeight,
            child: Column(
              children: [
                const PrimaryAppBar(title: 'Back'),
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
                        onTap: () {},
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
