import 'package:clerkship/data/network/entity/scoring_response.dart';
import 'package:clerkship/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../components/buttons/ripple_button.dart';

class ItemStudentAssessment extends StatelessWidget {
  final VoidCallback onTap;
  final ScoringData data;

  const ItemStudentAssessment({
    super.key,
    required this.onTap,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return RippleButton(
      onTap: onTap,
      border: Border.all(color: Themes.stroke),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${data.name}',
                style: Themes().blackBold12?.withColor(Themes.black),
              ).addMarginBottom(8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    AssetIcons.icOffice,
                    width: 12.w,
                    color: Themes.grey,
                  ).addMarginRight(8.w),
                  Text(
                    '${data.namaRs}',
                    style: Themes().black10,
                  ),
                ],
              ).addMarginBottom(4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    AssetIcons.icCalendar,
                    width: 12.w,
                    color: Themes.grey,
                  ).addMarginRight(8.w),
                  Text(
                    '${data.startDate?.formatDate('d MMMM yyyy')} - ${data.endDate?.formatDate('d MMMM yyyy')}',
                    style: Themes().black10,
                  ),
                ],
              ),
            ],
          ),
          SvgPicture.asset(
            AssetIcons.icChevronRight,
            height: 24.w,
          )
        ],
      ),
    );
  }
}
