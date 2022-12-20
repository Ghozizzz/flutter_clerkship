import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Tools {
  static void onViewCreated(VoidCallback onViewCreated) {
    WidgetsBinding.instance.addPostFrameCallback((_) => onViewCreated());
  }

  static void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static changeStatusbarIconColor({
    bool darkIcon = true,
    Color statusBarColor = Colors.transparent,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: darkIcon ? Brightness.dark : Brightness.light,
      ),
    );
  }

  static String formatDate({
    required String format,
    required DateTime dateTime,
  }) {
    initializeDateFormatting(Platform.localeName, null);
    return DateFormat(
      format,
      Platform.localeName,
    ).format(dateTime);
  }
}
