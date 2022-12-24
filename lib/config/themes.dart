import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static const text = Color(0xff5A7180);
  static const black = Color(0xff0F1B41);
  static const content = Color(0xff4A4A4A);
  static const primary = Color(0xff006950);
  static const darkPrimary = Color(0xff006950);
  static const lightPrimary = Color(0xff00AD84);
  static const secondary = Color(0xffFF9E2C);
  static const abu = Color(0xffADB3BC);
  static const background = Color(0xFFF9F9F9);
  static const hint = Color(0xffCACACA);
  static const hotpink = Color(0xffFC5A95);
  static const pink = Color(0xffEA9898);
  static const disable = Color(0xff777777);

  static const blue = Color(0xff74BCFF);
  static const reddish = Color(0xffFF576B);
  static const cyan = Color(0xff0CEAE2);
  static const orange = Color(0xFFFF8E24);
  static const brown = Color(0xFF865308);
  static const purple = Color(0xff874EDC);
  static const blueGrey = Color(0xffA9C8F2);
  static const magenta = Color(0xffE92B96);
  static const red = Color(0xffE70000);
  static const yellow = Color(0xffF4BD34);
  static const lightGrey = Color(0xffEEF0F5);
  static const grey = Color(0xFFADAAAA);
  static const green = Color(0xff52C41A);
  static const checkbox = Color(0xff00A67E);
  static const greyBg = Color(0xffFAFAFA);
  static const stroke = Color(0xffEEEEEE);
  static const fill = Color(0x126B779A);
  static const line = Color(0xFFE1E1E1);
  static const white = Color(0xffffffff);
  static const transparent = Color(0x00ffffff);

  static BoxShadow emptyShadow = BoxShadow(
    offset: const Offset(0, 0),
    spreadRadius: 0,
    blurRadius: 0,
    color: const Color(0xff7090B0).withOpacity(0),
  );

  static BoxShadow dropShadow = BoxShadow(
    offset: const Offset(0, 5),
    spreadRadius: 0,
    blurRadius: 10,
    color: const Color(0xff7090B0).withOpacity(0.1),
  );
  static BoxShadow softShadow = BoxShadow(
    offset: const Offset(0, 0),
    spreadRadius: 6,
    blurRadius: 20,
    color: const Color(0xff7090B0).withOpacity(0.14),
  );

  static MaterialColor primaryMaterialColor = const MaterialColor(
    0xff2979FF,
    <int, Color>{
      50: Color(0xff006950),
      100: Color(0xff006950),
      200: Color(0xff006950),
      300: Color(0xff006950),
      400: Color(0xff006950),
      500: Color(0xff006950),
      600: Color(0xff006950),
      700: Color(0xff006950),
      800: Color(0xff006950),
      900: Color(0xff006950),
    },
  );

  TextStyle? white18;
  TextStyle? white16;
  TextStyle? white14;
  TextStyle? white12;
  TextStyle? white10;

  TextStyle? whiteBold32;
  TextStyle? whiteBold28;
  TextStyle? whiteBold26;
  TextStyle? whiteBold24;
  TextStyle? whiteBold22;
  TextStyle? whiteBold20;
  TextStyle? whiteBold18;
  TextStyle? whiteBold16;
  TextStyle? whiteBold14;
  TextStyle? whiteBold12;

  TextStyle? black10;
  TextStyle? black12;
  TextStyle? black14;
  TextStyle? black16;
  TextStyle? black18;
  TextStyle? black20;
  TextStyle? black24;

  TextStyle? blackBold10;
  TextStyle? blackBold12;
  TextStyle? blackBold14;
  TextStyle? blackBold16;
  TextStyle? blackBold18;
  TextStyle? blackBold20;
  TextStyle? blackBold22;
  TextStyle? blackBold24;
  TextStyle? blackBold26;

  TextStyle? gray10;
  TextStyle? gray12;
  TextStyle? gray14;
  TextStyle? gray16;

  TextStyle? primary12;
  TextStyle? primary14;
  TextStyle? primaryBold20;
  TextStyle? primaryBold22;
  TextStyle? primaryBold24;
  TextStyle? primaryBold18;
  TextStyle? primaryBold16;
  TextStyle? primaryBold14;
  TextStyle? primaryBold12;

  TextStyle textStyle({
    double size = 14,
    Color? color,
    FontWeight? fontWeight,
    double? height,
  }) {
    return GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: height != null ? height / size : null,
      fontSize: size,
      color: color ?? Themes.text,
      fontWeight: fontWeight,
    );
  }

  Themes({bool withLineHeight = false}) {
    primary12 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 12,
      color: Themes.darkPrimary,
    );

    primary14 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 14,
      color: Themes.darkPrimary,
    );

    primaryBold12 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 12,
      color: Themes.darkPrimary,
      fontWeight: FontWeight.bold,
    );

    primaryBold16 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 16,
      color: Themes.darkPrimary,
      fontWeight: FontWeight.bold,
    );

    primaryBold14 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 14,
      color: Themes.darkPrimary,
      fontWeight: FontWeight.bold,
    );

    primaryBold20 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 20,
      color: Themes.darkPrimary,
      fontWeight: FontWeight.bold,
    );

    primaryBold22 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 22,
      color: Themes.darkPrimary,
      fontWeight: FontWeight.bold,
    );

    primaryBold24 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 24,
      color: Themes.darkPrimary,
      fontWeight: FontWeight.bold,
    );

    primaryBold18 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 18,
      color: Themes.darkPrimary,
      fontWeight: FontWeight.bold,
    );

    blackBold20 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 20,
      color: Themes.text,
      fontWeight: FontWeight.bold,
    );

    blackBold24 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 24,
      color: Themes.text,
      fontWeight: FontWeight.bold,
    );

    blackBold22 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 22,
      color: Themes.text,
      fontWeight: FontWeight.bold,
    );

    blackBold26 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 26,
      color: Themes.text,
      fontWeight: FontWeight.bold,
    );

    black16 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 16,
      color: Themes.text,
    );

    black18 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 18,
      color: Themes.text,
    );

    black20 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 20,
      color: Themes.text,
    );

    black24 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 24,
      color: Themes.text,
    );

    blackBold18 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 18,
      color: Themes.text,
      fontWeight: FontWeight.bold,
    );

    blackBold16 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 16,
      color: Themes.text,
      fontWeight: FontWeight.bold,
    );

    blackBold10 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 10,
      color: Themes.text,
      fontWeight: FontWeight.bold,
    );

    blackBold12 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 12,
      color: Themes.text,
      fontWeight: FontWeight.bold,
    );

    blackBold14 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 14,
      color: Themes.text,
      fontWeight: FontWeight.bold,
    );

    gray12 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 12,
      color: Themes.abu,
    );

    gray10 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 10,
      color: Themes.abu,
    );

    black10 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 10,
      color: Themes.text,
    );

    black12 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 12,
      color: Themes.text,
    );

    white18 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 18,
      color: Colors.white,
    );

    white16 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 16,
      color: Colors.white,
    );

    white14 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 14,
      color: Colors.white,
    );

    white12 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 12,
      color: Colors.white,
    );

    white10 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.2 : null,
      fontSize: 10,
      color: Colors.white,
    );

    gray14 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 14,
      color: Themes.abu,
    );

    gray16 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 16,
      color: Themes.abu,
    );

    black14 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 14,
      color: Themes.text,
    );

    whiteBold20 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    whiteBold18 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    whiteBold16 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    whiteBold12 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 12,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    whiteBold14 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    whiteBold32 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      fontSize: 32,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    whiteBold28 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      fontSize: 28,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    whiteBold26 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      fontSize: 26,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    whiteBold24 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 24,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    whiteBold22 ??= GoogleFonts.poppins(
      letterSpacing: 0.75,
      height: withLineHeight ? 1.5 : 1.2,
      fontSize: 22,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }
}

extension AddDecoration on TextStyle {
  TextStyle withUnderline({
    double width = 1,
    Color? lineColor,
    double offset = 1,
    bool visible = true,
  }) {
    return visible
        ? copyWith(
            decoration: TextDecoration.underline,
            shadows: [
              Shadow(
                color: lineColor ?? Colors.black,
                offset: Offset(0, -offset),
              ),
            ],
            color: Colors.transparent,
            decorationThickness: width,
            decorationColor: color,
          )
        : copyWith();
  }

  TextStyle lineThrough() {
    return copyWith(
      decoration: TextDecoration.lineThrough,
    );
  }

  TextStyle boldText() {
    return copyWith(
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle withColor(Color? color) {
    return copyWith(
      color: color,
    );
  }

  TextStyle withSize(double? size) {
    return copyWith(
      fontSize: size,
    );
  }

  TextStyle withFontWeight(FontWeight? fontWeight) {
    return copyWith(
      fontWeight: fontWeight,
    );
  }
}

extension TextHelper on String {
  Text get text12 => Text(this, style: Themes().black12);
  Text get text14 => Text(this, style: Themes().black14);
  Text get text16 => Text(this, style: Themes().black16);
  Text get text18 => Text(this, style: Themes().black18);

  Text get textBold12 => Text(this, style: Themes().blackBold12);
  Text get textBold14 => Text(this, style: Themes().blackBold14);
  Text get textBold16 => Text(this, style: Themes().blackBold16);
  Text get textBold18 => Text(this, style: Themes().blackBold18);
  Text get textBold20 => Text(this, style: Themes().blackBold20);
  Text get textBold22 => Text(this, style: Themes().blackBold22);
  Text get textBold24 => Text(this, style: Themes().blackBold24);
  Text get textBold26 => Text(this, style: Themes().blackBold26);
}
