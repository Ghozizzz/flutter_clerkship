import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';

import '../../../../config/themes.dart';
import '../../../../data/shared_providers/auth_provider.dart';
import '../../../../data/shared_providers/notification_provider.dart';
import '../../../../r.dart';
import '../../../../utils/nav_helper.dart';
import '../../../components/buttons/ripple_button.dart';
import '../../notification/notification_screen.dart';

class NotificationBar extends StatelessWidget {
  final int role;
  const NotificationBar({
    Key? key,
    required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final jumlahNotif = context.watch<NotificationProvider>().jumlahNotif;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          children: [
            RippleButton(
              onTap: () {
                context
                    .read<NotificationProvider>()
                    .getNotification(role: role);
                context.read<NotificationProvider>().readNotification();
                NavHelper.navigatePush(const NotificationScreen());
              },
              child: SvgPicture.asset(
                AssetIcons.icNotification,
                height: 18.h,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 12.w,
                left: 22.w,
              ),
              width: 15.w,
              height: 15.w,
              decoration: BoxDecoration(
                color: Themes.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  (jumlahNotif < 100) ? jumlahNotif.toString() : '99+',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        RippleButton(
          onTap: () {
            context.read<AuthProvider>().doLogout();
          },
          child: const Icon(
            Icons.logout_rounded,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
