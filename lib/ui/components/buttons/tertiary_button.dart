import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/themes.dart';
import 'ripple_button.dart';

class TertiaryButton extends StatefulWidget {
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

  const TertiaryButton({
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
  State<TertiaryButton> createState() => _TertiaryButtonState();
}

class _TertiaryButtonState extends State<TertiaryButton> {
  late Color textColor;
  late EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    textColor = widget.textColor ?? Colors.white;
    padding = widget.padding ?? const EdgeInsets.all(18);

    return Stack(
      children: [
        RippleButton(
          radius: widget.radius,
          lightButton: true,
          text: widget.text,
          padding: EdgeInsets.zero,
          color: Colors.white,
          border: Border.all(
            color: Themes.darkPrimary,
          ),
          onTap: widget.enable ? widget.onTap : null,
          loading: widget.loading,
          shadow: Themes.dropShadow,
          child: Padding(
            padding: padding,
            child: widget.child ??
                Center(
                  child: Text(
                    widget.loading ? '' : (widget.text ?? ''),
                    style: widget.buttonTextStyle ??
                        GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Themes.darkPrimary,
                          fontWeight: FontWeight.w400,
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
