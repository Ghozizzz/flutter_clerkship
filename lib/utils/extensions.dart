import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../config/themes.dart';
import 'tools.dart';

extension BoolExtension on bool {
  bool toggle() => !this;
}

extension DateExtension on DateTime {
  String formatDate(String format) {
    return Tools.formatDate(format: format, dateTime: this);
  }
}

extension HtmlString on String {
  InlineSpan toSpan(BuildContext context, {TextStyle? textStyle}) {
    return HTML.toTextSpan(
      context,
      this,
      overrideStyle: {
        'p': textStyle ?? Themes(withLineHeight: true).black12!,
      },
    );
  }
}

class ExtensionHelper {}
