import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive/responsive.dart';

import '../../../config/themes.dart';

class OtpField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String value)? onComplete;

  const OtpField({
    super.key,
    this.controller,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260.w,
      child: PinCodeTextField(
        length: 4,
        appContext: context,
        onChanged: (tex) {},
        onCompleted: onComplete,
        autoFocus: false,
        controller: controller,
        keyboardType: TextInputType.number,
        animationType: AnimationType.scale,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        textStyle: Themes().black14,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          fieldHeight: 56,
          fieldWidth: 56,
          activeColor: Themes.stroke,
          inactiveColor: Themes.stroke,
          selectedColor: Themes.text,
          borderRadius: BorderRadius.circular(8),
          borderWidth: 1,
        ),
      ),
    );
  }
}
