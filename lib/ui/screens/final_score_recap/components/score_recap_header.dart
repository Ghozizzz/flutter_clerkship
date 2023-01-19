import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';

class ScoreRecapHeader extends StatelessWidget {
  const ScoreRecapHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
            'Rekapitulasi Nilai Akhir',
            style: Themes().primaryBold20,
          ).addMarginBottom(24),
          Container(
            width: double.infinity,
            height: 1,
            color: Themes.stroke,
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
