import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/themes.dart';
import 'ripple_button.dart';

class WhiteButton extends StatefulWidget {
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

  const WhiteButton({
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
  State<WhiteButton> createState() => _WhiteButtonState();
}

class _WhiteButtonState extends State<WhiteButton> {
  late Color textColor;
  late EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    textColor = widget.textColor ?? Colors.white;
    padding = widget.padding ?? const EdgeInsets.all(18);

    return Stack(
      children: [
        RippleButton(
          shadow: Themes.dropShadow,
          radius: widget.radius,
          lightButton: true,
          text: widget.text,
          padding: EdgeInsets.zero,
          color: Colors.white,
          onTap: widget.enable ? widget.onTap : null,
          loading: widget.loading,
          child: Padding(
            padding: padding,
            child: widget.child ??
                Center(
                  child: Text(
                    widget.loading ? '' : (widget.text ?? ''),
                    style: widget.buttonTextStyle ??
                        GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Themes.primary,
                          fontWeight: FontWeight.w500,
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
