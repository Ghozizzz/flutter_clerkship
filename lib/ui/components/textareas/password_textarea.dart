import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../buttons/ripple_button.dart';
import 'textarea.dart';

class PasswordTextarea extends StatefulWidget {
  final TextEditingController? controller;
  final bool visibilitButton;
  final String? hint;
  final String? label;
  final Color? color;
  final Color? iconColor;
  final TextStyle? textStyle;
  final BoxShadow? shadow;

  const PasswordTextarea({
    Key? key,
    this.hint,
    this.label,
    this.controller,
    this.visibilitButton = true,
    this.color,
    this.iconColor,
    this.textStyle,
    this.shadow,
  }) : super(key: key);

  @override
  State<PasswordTextarea> createState() => _PasswordTextareaState();
}

class _PasswordTextareaState extends State<PasswordTextarea> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return TextArea(
      shadow: widget.shadow,
      color: widget.color,
      autofillHints: const [AutofillHints.password],
      controller: widget.controller,
      secureInput: !visible,
      hint: widget.hint,
      label: widget.label,
      textStyle: widget.textStyle,
      endIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          RippleButton(
            padding: const EdgeInsets.all(12),
            onTap: () {
              setState(() {
                visible = !visible;
              });
            },
            child: Icon(
              visible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: 20.w,
              color: widget.iconColor ?? Themes.hint,
            ),
          ).addMarginLeft(4),
        ],
      ),
    );
  }
}
