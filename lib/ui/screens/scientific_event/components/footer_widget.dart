import 'package:clerkship/ui/components/commons/primary_checkbox.dart';
import 'package:clerkship/utils/nav_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../components/buttons/primary_button.dart';
import '../../../components/commons/flat_card.dart';
import '../../reject_event/reject_event_screen.dart';
import '../providers/scientific_event_lecture_provider.dart';

class FooterWidget extends StatefulWidget {
  final Function(bool checkAll)? onTap;

  const FooterWidget({
    super.key,
    this.onTap,
  });

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  final checkAllController = CheckboxController(false);

  @override
  Widget build(BuildContext context) {
    final scientificEventProvider =
        context.watch<ScientificEventLectureProvider>();
    final events = scientificEventProvider.scientificEvents;

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
            onValueChange: (value) => widget.onTap?.call(value),
          ).addMarginBottom(12),
          Row(
            children: [
              PrimaryButton(
                onTap: () {
                  final checkedEvents =
                      events.where((element) => element.checked).toList();
                  NavHelper.navigatePush(RejectEventScreen(
                    data: checkedEvents,
                  ));
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
              // Container(width: 8.w),
              // PrimaryButton(
              //   onTap: () {},
              //   padding: EdgeInsets.all(14.w),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       SvgPicture.asset(
              //         AssetIcons.icCheck,
              //         color: Themes.white,
              //         width: 14.w,
              //       ).addMarginRight(8.w),
              //       Text(
              //         'Setujui Semua',
              //         style: Themes().whiteBold14,
              //       )
              //     ],
              //   ),
              // ).addExpanded,
            ],
          ),
        ],
      ),
    );
  }
}
