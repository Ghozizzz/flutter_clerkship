import 'package:clerkship/ui/components/buttons/primary_button.dart';
import 'package:clerkship/ui/components/commons/primary_appbar.dart';
import 'package:clerkship/ui/components/commons/primary_checkbox.dart';
import 'package:clerkship/ui/components/textareas/otp_field.dart';
import 'package:clerkship/ui/components/textareas/password_textarea.dart';
import 'package:clerkship/ui/components/textareas/textarea.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

class TestComponent extends StatelessWidget {
  const TestComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const PrimaryAppBar(title: 'Test Appbar'),
          SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                PrimaryButton(
                  onTap: () {},
                  text: 'Primary Button',
                ),
                PrimaryButton(
                  enable: false,
                  onTap: () {},
                  text: 'Disabled Button',
                ).addMarginTop(24),
                const TextArea(
                  hint: 'General Textfield',
                ).addMarginTop(24),
                const PasswordTextarea(
                  hint: 'General Textfield',
                ).addMarginTop(24),
                const PrimaryCheckbox(
                  title: 'Test checkbox',
                ).addMarginTop(24),
                const OtpField().addMarginTop(24),
              ],
            ),
          ).addExpanded,
        ],
      ),
    );
  }
}
