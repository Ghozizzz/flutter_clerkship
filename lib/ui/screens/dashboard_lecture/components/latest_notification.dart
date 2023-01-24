import 'package:clerkship/config/themes.dart';
import 'package:clerkship/ui/screens/notification/components/item_notification.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

class LatestNotification extends StatelessWidget {
  const LatestNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notifikasi',
          style: Themes().gray12?.boldText(),
        ).addMarginOnly(
          top: 16,
          bottom: 10,
        ),
        const ItemNotification(),
      ],
    ).addSymmetricMargin(
      horizontal: 20.w,
    );
  }
}
