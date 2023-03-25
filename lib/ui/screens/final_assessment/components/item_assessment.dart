import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../components/commons/flat_card.dart';
import 'item_rating.dart';

class ItemAssessment extends StatelessWidget {
  const ItemAssessment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpandablePanel(
          expanded: Column(
            children: [
              Column(
                children: List.generate(
                  3,
                  (index) => ItemRating(
                    isGlobalRating: index != 2,
                    onTap: () {
                      // NavHelper.navigatePush(
                      //   const FinalScoreRecapScreen(),
                      // );
                    },
                  ).addMarginBottom(12),
                ),
              ).addMarginOnly(
                top: 16,
                bottom: 4,
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Themes.stroke,
              ),
            ],
          ),
          collapsed: Container(),
          theme: const ExpandableThemeData(
            hasIcon: false,
          ),
          header: Column(
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
                            'Ilmu Penyakit Dalam',
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
                            '5 Mei 2022 - 10 Agustus 2022',
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
                    color: Themes.blue.withOpacity(0.2),
                    child: Text(
                      'Proses',
                      style: Themes().blackBold10?.withColor(Themes.blue),
                    ),
                  ).addMarginBottom(10),
                ],
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Themes.stroke,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
