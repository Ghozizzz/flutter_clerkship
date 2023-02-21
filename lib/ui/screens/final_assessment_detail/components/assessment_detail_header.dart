import 'package:clerkship/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../provider/final_assessment_detail_provider.dart';

class AssessmentDetailHeader extends StatelessWidget {
  const AssessmentDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final headerData = context.watch<FinalAssessmentDetailProvder>().headerData;

    return Container(
      padding: EdgeInsets.only(
        top: 20.w,
        left: 20.w,
        right: 20.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${headerData?.name}',
            style: Themes().primaryBold20,
          ),
          Text(
            '${headerData?.idHeader}',
            style: Themes().black10?.withColor(Themes.grey),
          ).addMarginOnly(
            top: 4,
            bottom: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetIcons.icOffice,
                width: 12.w,
                height: 12.w,
                color: Themes.grey,
              ).addMarginRight(8.w),
              Text(
                'Rumah Sakit Siloam',
                style: Themes().blackBold10,
              ),
            ],
          ).addSymmetricMargin(vertical: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetIcons.icCalendar,
                width: 12.w,
                height: 12.w,
                color: Themes.grey,
              ).addMarginRight(8.w),
              Text(
                '${headerData?.startDate?.formatDate('d MMMM yyyy')} - ${headerData?.endDate?.formatDate('d MMMM yyyy')}',
                style: Themes().blackBold10,
              ),
            ],
          ).addMarginBottom(12),
          Container(
            width: double.infinity,
            height: 1,
            color: Themes.stroke,
          ),
        ],
      ),
    );
  }
}
