import 'dart:convert';

import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';

class ItemInfoSegment extends StatefulWidget {
  final String title;
  final String? value;
  final Widget? valueWidget;
  final EdgeInsets? padding;
  final bool isVerticalValue;
  final bool isRichTextValue;

  const ItemInfoSegment({
    super.key,
    required this.title,
    this.value,
    this.valueWidget,
    this.padding,
    this.isVerticalValue = false,
    this.isRichTextValue = false,
  });

  @override
  State<ItemInfoSegment> createState() => _ItemInfoSegmentState();
}

class _ItemInfoSegmentState extends State<ItemInfoSegment> {
  late final richTextController = FleatherController(
    ParchmentDocument.fromJson(jsonDecode(widget.value ?? '')),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: Themes().blackBold12?.withColor(Themes.hint),
              ).addFlexible,
              if (!widget.isVerticalValue)
                widget.valueWidget ??
                    Text(
                      widget.value!,
                      style:
                          Themes().blackBold12?.withFontWeight(FontWeight.w500),
                      textAlign: TextAlign.end,
                    ).addFlexible,
            ],
          ),
        ),
        if (widget.isVerticalValue && !widget.isRichTextValue)
          Padding(
            padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 20),
            child: widget.valueWidget ??
                Text(
                  widget.value!,
                  style: Themes().black12?.withColor(Themes.black),
                  textAlign: TextAlign.end,
                ),
          )
        else if (widget.isVerticalValue && widget.isRichTextValue)
          FleatherEditor(
            controller: richTextController,
            readOnly: true,
            padding: EdgeInsets.zero,
            showCursor: false,
          ),
        Container(
          width: double.infinity,
          height: 1,
          color: Themes.stroke,
        ),
      ],
    );
  }
}
