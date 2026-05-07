import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/shared_providers/forgot_provider.dart';
import '../../../r.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import '../../components/textareas/otp_field.dart';

class ForgotPasswordOtpScreen extends StatelessWidget {
  final String id;
  ForgotPasswordOtpScreen({super.key, required this.id});

  final otpController = TextEditingController();

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
                    SvgPicture.asset(
                      AssetImages.logoAlt,
                      height: 42.h,
                    ).addMarginBottom(20.h),
                    Text(
                      '2-step Verification',
                      style: Themes().primaryBold20,
                    ),
                    Text(
                      'We sent a verification code to your email.\nEnter the code from $id \nin the field below.',
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
                          doOtpCheck(context);
                          // NavHelper.navigatePush(UpdatePasswordScreen());
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

  void doOtpCheck(
    BuildContext context,
  ) async {
    context.read<ForgotProvider>().doOtpCheck(
          email: id,
          otp: otpController.text,
        );
  }
}
