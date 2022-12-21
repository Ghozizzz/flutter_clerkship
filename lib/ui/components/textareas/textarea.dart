import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive/responsive.dart';

import '../../../config/themes.dart';
import '../commons/flat_card.dart';

class TextArea extends StatefulWidget {
  final String? hint;
  final String? label;
  final Widget? icon;
  final Widget? endIcon;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatter;
  final bool secureInput;
  final int? maxLenght;
  final int maxLine;
  final Function(String value)? onKeyUp;
  final Function(String value)? onChangedText;
  final Function(String value)? onSubmitText;
  final VoidCallback? onClearText;
  final double? width;
  final double? height;
  final TextCapitalization textCapitalization;
  final MainAxisAlignment mainAxisAlignment;
  final Color? color;
  final bool enable;
  final bool error;
  final String errorMessage;
  final bool autoFocus;
  final TextAlign textAlign;
  final double? radius;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final bool isDense;
  final Border? border;
  final List<String>? autofillHints;
  final BoxShadow? shadow;

  const TextArea({
    Key? key,
    this.padding,
    this.radius,
    this.hint,
    this.label,
    this.icon,
    this.endIcon,
    this.controller,
    this.inputType,
    this.secureInput = false,
    this.inputFormatter,
    this.maxLenght,
    this.maxLine = 1,
    this.onChangedText,
    this.width,
    this.height,
    this.onKeyUp,
    this.onSubmitText,
    this.onClearText,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.color,
    this.enable = true,
    this.error = false,
    this.autoFocus = false,
    this.errorMessage = '',
    this.textAlign = TextAlign.start,
    this.textStyle,
    this.hintTextStyle,
    this.isDense = true,
    this.border,
    this.autofillHints,
    this.shadow,
  }) : super(key: key);

  @override
  State<TextArea> createState() => _TextAreaState();
}

class _TextAreaState extends State<TextArea> {
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      if (widget.onKeyUp != null) widget.onKeyUp!(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Themes.primary.withOpacity(0.3),
        ),
      ),
      child: FlatCard(
        border: Border.all(
          color: Themes.stroke,
        ),
        color: widget.color ?? Themes.white,
        shadow: widget.shadow,
        padding: EdgeInsets.zero,
        child: TextField(
          autofillHints: widget.autofillHints ?? [],
          textAlign: widget.textAlign,
          autofocus: widget.autoFocus,
          enabled: widget.enable,
          minLines: 1,
          maxLines: widget.maxLine,
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.textInputAction,
          onSubmitted: (value) {
            if (widget.onSubmitText != null) {
              widget.onSubmitText!(value);
            }
          },
          onChanged: (value) {
            if (widget.onChangedText != null) {
              widget.onChangedText!(value);
            }

            if (widget.onKeyUp != null) {
              _onSearchChanged(value);
            }
          },
          obscureText: widget.secureInput,
          controller: widget.controller,
          keyboardType: widget.inputType,
          style: widget.textStyle ??
              GoogleFonts.montserrat(
                fontSize: 14,
                color: Colors.black,
              ),
          inputFormatters: widget.inputFormatter,
          maxLength: widget.maxLenght,
          cursorColor: Themes.primary,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            errorText: widget.error ? widget.errorMessage : null,
            isDense: widget.isDense,
            contentPadding: widget.padding ??
                EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16,
                ),
            hintText: widget.hint,
            hintStyle: widget.hintTextStyle ??
                GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Themes.hint,
                ),
            suffixIcon: widget.endIcon,
          ),
        ),
      ),
    );
  }
}
