import 'package:clerkship/ui/components/commons/animated_item.dart';
import 'package:clerkship/ui/screens/global_rating/components/item_answer.dart';
import 'package:flutter/material.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';

class ItemAnswerGroup extends StatelessWidget {
  const ItemAnswerGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'A. Professional Behaviours',
          style: Themes().blackBold14?.withColor(Themes.black),
        ).addMarginBottom(12),
        Column(
          children: List.generate(
            4,
            (index) => const AnimatedItem(child: ItemAnswer()),
          ),
        )
      ],
    );
  }
}
