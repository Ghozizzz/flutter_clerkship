import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../utils/nav_helper.dart';
import '../../../components/buttons/ripple_button.dart';
import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../components/commons/flat_card.dart';
import '../../survey/survey_add_screen.dart';

class ItemAssessment extends StatelessWidget {
  final int id;
  final String namaDepartment;
  final String tanggal;
  final int flagSurvey;

  const ItemAssessment(
      {super.key,
      required this.id,
      required this.namaDepartment,
      required this.tanggal,
      required this.flagSurvey});

  @override
  Widget build(BuildContext context) {
    String statusTxt;
    Color color;
    switch (flagSurvey) {
      case 0:
        statusTxt = 'Belum Dinilai';
        color = Themes.yellow;
        break;
      case 1:
        statusTxt = 'Dinilai';
        color = Themes.green;
        break;
      case 2:
        statusTxt = 'Waiting';
        color = Themes.yellow;
        break;
      default:
        statusTxt = 'Proses';
        color = Themes.blue;
        break;
    }
    return RippleButton(
      onTap: () {
        NavHelper.navigatePush(
            SurveyAddScreen(id: id.toString(), flagSurvey: flagSurvey));
      },
      child: Column(
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            namaDepartment,
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
                            tanggal,
                            style: Themes().blackBold10,
                          ),
                        ],
                      ).addMarginBottom(12),
                    ],
                  ),
                  FlatCard(
                    borderRadius: BorderRadius.circular(4),
                    padding: EdgeInsets.symmetric(
                      vertical: 6.w,
                      horizontal: 8.w,
                    ),
                    color: color.withOpacity(0.2),
                    child: Text(
                      statusTxt,
                      style: Themes().blackBold10?.withColor(color),
                    ),
                  ).addMarginBottom(10),
                ],
              ),
              if (flagSurvey != 1)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetIcons.icAlert,
                      width: 12.w,
                      height: 12.w,
                      color: const Color(0xFF1890FF),
                    ).addMarginRight(8.w),
                    Text(
                      'Silahkan isi survey untuk dapat melihat nilai akhir',
                      style: Themes().blackBold10?.withColor(Themes.blue),
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
        ],
      ),
    );
  }
}
