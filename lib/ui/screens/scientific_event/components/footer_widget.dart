import 'package:clerkship/ui/components/commons/primary_checkbox.dart';
import 'package:clerkship/utils/nav_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../components/buttons/primary_button.dart';
import '../../../components/commons/flat_card.dart';
import '../../reject_event/reject_event_screen.dart';

class FooterWidget extends StatelessWidget {
  FooterWidget({super.key});

  final checkAllController = CheckboxController(false);

  @override
  Widget build(BuildContext context) {
    return FlatCard(
      shadow: Themes.softShadow,
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 12,
        bottom: 20.w,
      ),
      child: Column(
        children: [
          PrimaryCheckbox(
            controller: checkAllController,
            title: 'Select All',
            checkBoxSize: Size(20.w, 20.w),
            unCheckColor: Themes.hint,
            strokeWidth: 2,
          ).addMarginBottom(12),
          Row(
            children: [
              PrimaryButton(
                onTap: () {
                  NavHelper.navigatePush(RejectEventScreen());
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
        ],
      ),
    );
  }
}
