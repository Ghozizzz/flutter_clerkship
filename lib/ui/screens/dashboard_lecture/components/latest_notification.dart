import 'package:clerkship/config/themes.dart';
import 'package:clerkship/data/network/entity/notification_response.dart';
import 'package:clerkship/data/shared_providers/notification_provider.dart';
import 'package:clerkship/ui/screens/notification/components/item_notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../utils/nav_helper.dart';
import '../../notification/notification_screen.dart';

class LatestNotification extends StatelessWidget {
  final Notifications lastNotif;
  const LatestNotification({super.key, required this.lastNotif});

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
        ItemNotification(
          notif: lastNotif,
          onTap: () {
            context.read<NotificationProvider>().getNotification(role: 1);
            NavHelper.navigatePush(const NotificationScreen());
          },
        ),
      ],
    ).addSymmetricMargin(
      horizontal: 20.w,
    );
  }
}
