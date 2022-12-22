import 'package:clerkship/config/themes.dart';
import 'package:clerkship/ui/components/buttons/primary_button.dart';
import 'package:clerkship/ui/components/commons/primary_appbar.dart';
import 'package:clerkship/ui/components/commons/safe_statusbar.dart';
import 'package:clerkship/ui/components/textareas/otp_field.dart';
import 'package:clerkship/ui/screens/forgot_password/update_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../r.dart';
import '../../../utils/nav_helper.dart';

class ForgotPasswordOtpScreen extends StatelessWidget {
  ForgotPasswordOtpScreen({super.key});

  final otpController = TextEditingController();

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
                    SvgPicture.asset(
                      AssetImages.logoAlt,
                      height: 42.h,
                    ).addMarginBottom(20.h),
                    Text(
                      '2-step Verification',
                      style: Themes().primaryBold20,
                    ),
                    Text(
                      'We sent a verification code to your email.\nEnter the code from the email\nin the field below.',
                      textAlign: TextAlign.center,
                      style: Themes().black14,
                    ).addMarginTop(16.h),
                    OtpField(
                      controller: otpController,
                    ).addMarginTop(16.h),
                  ],
                ).addAllPadding(20.w).addExpanded,
                ValueListenableBuilder(
                    valueListenable: otpController,
                    builder: (context, value, _) {
                      return PrimaryButton(
                        enable: value.text.length == 4,
                        onTap: () {
                          NavHelper.navigatePush(UpdatePasswordScreen());
                        },
                        text: 'Confirm My Account',
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
