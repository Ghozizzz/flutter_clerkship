import 'package:flutter/painting.dart';

class DropDownItem {
  String title;
  dynamic value;
  Color? color;
  bool selected;

  DropDownItem({
    required this.title,
    required this.value,
    this.color,
    this.selected = false,
  });
}
