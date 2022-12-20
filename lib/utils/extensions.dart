import 'tools.dart';

extension BoolExtension on bool {
  bool toggle() => !this;
}

extension DateExtension on DateTime {
  String formatDate(String format) {
    return Tools.formatDate(format: format, dateTime: this);
  }
}

class ExtensionHelper {}
