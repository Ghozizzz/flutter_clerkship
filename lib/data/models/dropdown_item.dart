import 'package:flutter/painting.dart';

class DropDownItem {
  String title;
  dynamic value;
  Color? color;
  bool selected;
  String other;
  int count;
  int flagDelete;
  int? id;

  DropDownItem({
    required this.title,
    required this.value,
    this.color,
    this.selected = false,
    this.other = '',
    this.count = 1,
    this.flagDelete = 0,
    this.id,
  });
}
