import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../components/commons/animated_item.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import 'components/item_group_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeStatusBar(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PrimaryAppBar(title: 'Kembali'),
            Text(
              'Notifikasi',
              style: Themes().blackBold20?.withColor(Themes.content),
            ).addMarginOnly(
              top: 12,
              left: 20.w,
            ),
            ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 20.w,
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                return AnimatedItem(
                  index: index,
                  child: const ItemGroupNotification(),
                );
              },
            ).addExpanded,
          ],
        ),
      ),
    );
  }
}
