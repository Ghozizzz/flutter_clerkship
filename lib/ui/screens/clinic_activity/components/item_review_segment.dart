import 'package:flutter/material.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';

class ItemReviewSegment extends StatelessWidget {
  final String title;
  final String? value;
  final Widget? valueWidget;
  final EdgeInsets? padding;
  final bool isVerticalValue;

  const ItemReviewSegment({
    super.key,
    required this.title,
    this.value,
    this.valueWidget,
    this.padding,
    this.isVerticalValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: isVerticalValue
              ? const EdgeInsets.only(
                  top: 12,
                )
              : padding ?? const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Themes().black12,
              ).addFlexible,
              if (!isVerticalValue)
                valueWidget ??
                    Text(
                      value!,
                      style: Themes().black12?.withColor(Themes.black),
                      textAlign: TextAlign.end,
                    ).addFlexible,
            ],
          ),
        ),
        if (isVerticalValue)
          Padding(
            padding: padding ?? const EdgeInsets.symmetric(vertical: 20),
            child: valueWidget ??
                Text(
                  value!,
                  style: Themes().black12?.withColor(Themes.black),
                  textAlign: TextAlign.end,
                ),
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
