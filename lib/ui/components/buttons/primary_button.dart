import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';

import '../../../config/themes.dart';
import 'ripple_button.dart';

class PrimaryButton extends StatefulWidget {
  final String? text;
  final VoidCallback? onTap;
  final Color? textColor;
  final Widget? child;
  final EdgeInsets? padding;
  final double radius;
  final bool enable;
  final TextStyle? buttonTextStyle;
  final bool loading;
  final LinearGradient? gradientColor;

  const PrimaryButton({
    Key? key,
    this.text,
    this.onTap,
    this.gradientColor,
    this.textColor,
    this.child,
    this.padding,
    this.radius = 8,
    this.enable = true,
    this.buttonTextStyle,
    this.loading = false,
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  late Color textColor;
  late EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    textColor = widget.textColor ?? Colors.white;
    padding = widget.padding ?? EdgeInsets.all(15.w);

    return Stack(
      children: [
        RippleButton(
          color: Themes.primary,
          shadow: Themes.dropShadow,
          disableColor: Themes.disable,
          radius: widget.radius,
          lightButton: true,
          text: widget.text,
          padding: EdgeInsets.zero,
          onTap: widget.enable ? widget.onTap : null,
          loading: widget.loading,
          child: Padding(
            padding: padding,
            child: widget.child ??
                Center(
                  child: Text(
                    widget.loading ? '' : (widget.text ?? ''),
                    style: widget.buttonTextStyle ?? Themes().whiteBold14,
                  ),
                ),
          ),
        ),
        if (widget.loading)
          Positioned.fill(
            child: Center(
              child: IgnorePointer(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.white.withOpacity(0.14),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
