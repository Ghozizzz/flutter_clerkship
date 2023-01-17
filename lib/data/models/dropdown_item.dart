import 'package:flutter/painting.dart';

class DropDownItem {
  String title;
  dynamic value;
  Color? color;
  bool selected;
  String other;
  int count;
  int flagDelete;

  DropDownItem({
    required this.title,
    required this.value,
    this.color,
    this.selected = false,
    this.other = '',
    this.count = 0,
    this.flagDelete = 0,
  });
}
