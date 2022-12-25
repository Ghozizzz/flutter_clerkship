import 'package:clerkship/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:widget_helper/widget_helper.dart';

import 'item_notification.dart';

class ItemGroupNotification extends StatelessWidget {
  const ItemGroupNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today',
          style: Themes().blackBold12?.withColor(Themes.hint),
        ).addSymmetricMargin(vertical: 10),
        Column(
          children: List.generate(
            4,
            (index) {
              final isRead = index.isEven;

              return ItemNotification(
                isRead: isRead,
              ).addMarginBottom(10);
            },
          ),
        )
      ],
    );
  }
}
