import 'dart:math';

// import 'package:clerkship/ui/screens/dashboard_lecture/components/latest_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
// import '../../../data/shared_providers/notification_provider.dart';
import '../../../r.dart';
import '../../../utils/dialog_helper.dart';
import '../../../utils/nav_helper.dart';
import '../../components/commons/safe_statusbar.dart';
import 'components/main_menu_widget.dart';
import 'components/notification_bar.dart';
import 'components/user_data_widget.dart';

class DashboardLectureScreen extends StatelessWidget {
  const DashboardLectureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NavHelper.initNavHelper(context);
    DialogHelper.initDialogHelper(context);

    // final lastNotif = context.watch<NotificationProvider>().lastNotif;
    // final loadingNotif = context.watch<NotificationProvider>().isLoadingNotif;

    return SafeStatusBar(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 216.h,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                gradient: LinearGradient(
                  transform: GradientRotation(45 * (180 / pi)),
                  colors: [
                    Themes.lightPrimary,
                    Themes.primary,
                  ],
                ),
              ),
            ),
            Positioned(
              top: 26.h,
              right: 0,
              child: SvgPicture.asset(
                AssetImages.stetoscop,
                width: 165.w,
                height: 177.h,
              ),
            ),
            // if (loadingNotif)
            //   const Center(child: CircularProgressIndicator())
            // else
            // Expanded(
            // child:
            Column(
              children: [
                const NotificationBar(role: 1),
                const UserDataWidget().addMarginOnly(
                  top: 30.h,
                  left: 20.w,
                  right: 20.w,
                  bottom: 40.h,
                ),
                const MainMenuWidget(),
                // LatestNotification(
                //   lastNotif: lastNotif,
                // ),
                Container().addExpanded,
                SvgPicture.asset(
                  AssetImages.logoAlt,
                  width: 155.w,
                ).addMarginBottom(15.h),
              ],
            ),
            // )
          ],
        ),
      ),
    );
  }
}
