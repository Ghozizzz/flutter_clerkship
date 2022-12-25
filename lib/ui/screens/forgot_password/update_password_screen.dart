import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../r.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import '../../components/textareas/password_textarea.dart';

class UpdatePasswordScreen extends StatelessWidget {
  UpdatePasswordScreen({super.key});

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AssetImages.logoAlt,
                          height: 42.h,
                        ),
                      ],
                    ).addMarginBottom(32.h),
                    Text(
                      'Password',
                      style: Themes().primaryBold12,
                    ).addMarginTop(32.h),
                    PasswordTextarea(
                      controller: passwordController,
                      hint: 'Your Password',
                    ).addMarginTop(8.h),
                    Text(
                      'Repeat New Password',
                      style: Themes().primaryBold12,
                    ).addMarginTop(32.h),
                    PasswordTextarea(
                      controller: confirmPasswordController,
                      hint: 'Your Password',
                    ).addMarginTop(8.h),
                  ],
                ).addAllPadding(20.w).addExpanded,
                MultiValueListenableBuilder(
                    valueListenables: [
                      passwordController,
                      confirmPasswordController,
                    ],
                    builder: (context, value, _) {
                      return PrimaryButton(
                        enable: isFormValid(),
                        onTap: () {},
                        text: 'Update',
                      ).addAllMargin(20.w);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isFormValid() {
    bool isPasswordValid = passwordController.text.length >= 6;
    bool isPasswordConfirmValid =
        passwordController.text == confirmPasswordController.text;

    return isPasswordValid && isPasswordConfirmValid;
  }
}
