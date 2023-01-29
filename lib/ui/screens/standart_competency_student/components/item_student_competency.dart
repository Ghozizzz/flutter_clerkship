import 'package:clerkship/utils/nav_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../components/buttons/ripple_button.dart';
import '../../standard_competency_lecture/standard_competency_lecture_screen.dart';

class ItemStudentCompetency extends StatelessWidget {
  const ItemStudentCompetency({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RippleButton(
      onTap: () {
        NavHelper.navigatePush(const StandardCompetencyLectureScreen());
      },
      border: Border.all(color: Themes.stroke),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bhima Saputra',
                style: Themes().blackBold12?.withColor(Themes.black),
              ).addMarginBottom(8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    AssetIcons.icCalendar,
                    width: 12.w,
                  ).addMarginRight(8.w),
                  Text(
                    '10 August 2022',
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
