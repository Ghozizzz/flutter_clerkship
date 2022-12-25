import 'package:flutter/material.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';

class OtherInfoSegment extends StatelessWidget {
  final String title;
  final String? value;
  final Widget? valueWidget;

  const OtherInfoSegment({
    super.key,
    required this.title,
    this.value,
    this.valueWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Themes().blackBold12?.withColor(Themes.hint),
              ).addMarginBottom(8),
              valueWidget ??
                  Text(
                    value!,
                    style: Themes().black12,
                  ).addMarginBottom(20),
            ],
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
