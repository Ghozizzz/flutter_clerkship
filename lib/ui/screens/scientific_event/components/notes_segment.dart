import 'dart:convert';

import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';

class NotesSegment extends StatefulWidget {
  final String title;
  final String body;

  const NotesSegment({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  State<NotesSegment> createState() => _NotesSegmentState();
}

class _NotesSegmentState extends State<NotesSegment> {
  late FleatherController controller =
      FleatherController(ParchmentDocument.fromJson(jsonDecode(widget.body)));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Themes().blackBold12?.withColor(Themes.hint),
          ).addMarginTop(20),
          FleatherEditor(
            controller: controller,
            readOnly: true,
            padding: EdgeInsets.zero,
            showCursor: false,
          ).addMarginOnly(
            top: 12,
            bottom: 8,
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Themes.stroke,
          ),
        ],
      ),
    );
  }
}
