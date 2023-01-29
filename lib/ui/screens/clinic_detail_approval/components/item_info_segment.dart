import 'package:flutter/material.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';

class ItemInfoSegment extends StatelessWidget {
  final String title;
  final String? value;
  final Widget? valueWidget;
  final EdgeInsets? padding;

  const ItemInfoSegment({
    super.key,
    required this.title,
    this.value,
    this.valueWidget,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Themes().blackBold12?.withColor(Themes.hint),
              ).addFlexible,
              valueWidget ??
                  Text(
                    value!,
                    style:
                        Themes().blackBold12?.withFontWeight(FontWeight.w500),
                  ),
            ],
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
