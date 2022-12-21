import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive/responsive.dart';

import '../../../config/themes.dart';
import 'ripple_button.dart';

class SecondaryButton extends StatefulWidget {
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

  const SecondaryButton({
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
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  late Color textColor;
  late EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    textColor = widget.textColor ?? Colors.white;
    padding = widget.padding ?? EdgeInsets.all(15.w);

    return Stack(
      children: [
        RippleButton(
          color: Themes.lightPrimary,
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
                    style: widget.buttonTextStyle ??
                        GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
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
