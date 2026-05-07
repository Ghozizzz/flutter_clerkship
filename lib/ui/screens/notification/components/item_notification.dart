import 'package:clerkship/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../data/network/entity/notification_response.dart';
import '../../../../data/shared_providers/user_provider.dart';
import '../../../../r.dart';
import '../../../components/buttons/ripple_button.dart';

class ItemNotification extends StatelessWidget {
  final Notifications notif;
  final VoidCallback? onTap;

  const ItemNotification({
    super.key,
    required this.notif,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final role = context.watch<UserProvider>().user.roleId;
    return RippleButton(
      border: Border.all(
          color: notif.notifType == 5 && role == 2
              ? Themes.orange
              : Themes.stroke),
      color:
          notif.isRead == 0 ? Themes.primary.withOpacity(0.15) : Themes.white,
      onTap: onTap,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                margin: EdgeInsets.only(right: 12.w),
                decoration: BoxDecoration(
                  color: Themes.primary.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: getIcon(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: notif.remarks!.toSpan(context),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ).addMarginBottom(2),
                  Text(
                    notif.totalDuration!,
                    style: Themes().black10?.withColor(Themes.hint),
                  ),
                ],
              ).addExpanded,
              if (notif.isRead == 0 && role == 1)
                Container(
                  margin: EdgeInsets.only(left: 12.w),
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Themes.primary,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  SvgPicture getIcon() {
    switch (notif.notifType!) {
      case 0:
        return SvgPicture.asset(
          AssetIcons.icHospital,
          width: 20.w,
          height: 20.w,
        );
      case 1:
        return SvgPicture.asset(
          AssetIcons.icNotifBook,
          width: 20.w,
          height: 20.w,
        );
      case 2:
        return SvgPicture.asset(
          AssetIcons.icVerified,
          width: 20.w,
          height: 20.w,
        );
      default:
        return SvgPicture.asset(
          AssetIcons.icAlert,
          width: 20.w,
          height: 20.w,
        );
    }
  }
}
