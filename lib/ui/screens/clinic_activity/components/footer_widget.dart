import 'package:clerkship/ui/screens/reject_activity/reject_activity_screen.dart';
import 'package:clerkship/utils/nav_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../components/buttons/primary_button.dart';
import '../../../components/commons/flat_card.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlatCard(
      shadow: Themes.softShadow,
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          PrimaryButton(
            onTap: () {
              NavHelper.navigatePush(RejectActivityScreen());
            },
            color: Themes.red,
            padding: EdgeInsets.all(14.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetIcons.icClose,
                  color: Themes.white,
                  width: 14.w,
                ).addMarginRight(8.w),
                Text(
                  'Tolak Semua',
                  style: Themes().whiteBold14,
                )
              ],
            ),
          ).addExpanded,
          Container(width: 8.w),
          PrimaryButton(
            onTap: () {},
            padding: EdgeInsets.all(14.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetIcons.icCheck,
                  color: Themes.white,
                  width: 14.w,
                ).addMarginRight(8.w),
                Text(
                  'Setujui Semua',
                  style: Themes().whiteBold14,
                )
              ],
            ),
          ).addExpanded,
        ],
      ),
    );
  }
}
