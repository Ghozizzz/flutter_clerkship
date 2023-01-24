import 'package:clerkship/data/shared_providers/auth_provider.dart';
import 'package:clerkship/ui/screens/dashboard/dashboard_student_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/shared_providers/user_provider.dart';
import '../../../r.dart';
import '../../../utils/dialog_helper.dart';
import '../../../utils/nav_helper.dart';
import '../../../utils/string_helper.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/commons/primary_checkbox.dart';
import '../../components/commons/safe_statusbar.dart';
import '../../components/textareas/password_textarea.dart';
import '../../components/textareas/textarea.dart';
import '../forgot_password/forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController(text: 'testing@gmail.com');
  final passwordController = TextEditingController(text: '12345678');
  final checkboxController = CheckboxController(false);

  @override
  Widget build(BuildContext context) {
    NavHelper.initNavHelper(context);
    DialogHelper.initDialogHelper(context);

    return SafeStatusBar(
      child: Scaffold(
        body: Column(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset(
                            AssetImages.logoAlt,
                            height: 42.h,
                          ).addMarginBottom(12.h),
                          Text(
                            'CLERKSHIP LOGBOOK',
                            style: Themes().black14?.copyWith(letterSpacing: 3),
                          ),
                        ],
                      ),
                    ],
                  ).addMarginTop(46),
                  Text(
                    'Welcome, Back',
                    style: Themes().primaryBold24,
                  ).addMarginTop(64.h),
                  Text(
                    'Please log back into your account',
                    style: Themes().black14,
                  ).addMarginTop(4.h),
                  Text(
                    'Email Address',
                    style: Themes().primaryBold12,
                  ).addMarginTop(24.h),
                  TextArea(
                    controller: emailController,
                    hint: 'e.g example@mail.com',
                    inputType: TextInputType.emailAddress,
                  ).addMarginTop(8.h),
                  Text(
                    'Password',
                    style: Themes().primaryBold12,
                  ).addMarginTop(32.h),
                  PasswordTextarea(
                    controller: passwordController,
                    hint: 'Your Password',
                  ).addMarginTop(8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryCheckbox(
                        controller: checkboxController,
                        title: 'Keep me Sign in',
                      ),
                      Text(
                        'Forgot Password',
                        style: Themes()
                            .blackBold12
                            ?.withColor(const Color(0xff5A7180)),
                      ).onTap(() {
                        NavHelper.navigatePush(ForgotPasswordScreen());
                      }),
                    ],
                  ).addMarginTop(38.h)
                ],
              ),
            ).addExpanded,
            MultiValueListenableBuilder(
              valueListenables: [
                emailController,
                passwordController,
              ],
              builder: (context, _, __) {
                return PrimaryButton(
                  enable: isFormValid(),
                  onTap: () {
                    context.read<AuthProvider>().doLogin(
                          email: emailController.text,
                          password: passwordController.text,
                          onFinish: (success) {
                            if (success) {
                              context.read<UserProvider>().getCurrentUser();

                              NavHelper.navigateReplace(
                                const DashboardStudentScreen(),
                              );
                            }
                          },
                        );
                  },
                  text: 'Sign In',
                ).addAllMargin(20.w);
              },
            ),
          ],
        ),
      ),
    );
  }

  bool isFormValid() {
    bool isEmailValid = StringHelper.isEmail(emailController.text);
    bool isPasswordValid = passwordController.text.length >= 6;

    return isEmailValid && isPasswordValid;
  }
}
