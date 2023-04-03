import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../data/network/entity/clinic_detail_response.dart';

class BulletList extends StatelessWidget {
  final String title;
  final bool withCount;
  final List<ClinicDetailItem> listData;
  const BulletList({
    super.key,
    required this.title,
    this.listData = const [],
    this.withCount = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Themes().blackBold12?.withColor(Themes.hint),
              ),
              if (withCount)
                Text(
                  'Jumlah',
                  style: Themes().blackBold12?.withColor(Themes.hint),
                ),
            ],
          ).addMarginTop(20),
          Column(
            children: List.generate(
              listData.length,
              (index) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 68.wp,
                    child: Text(
                      '• ${listData[index].namaItem}',
                      style: Themes().black12,
                    ),
                  ),
                  if (withCount)
                    Text(
                      '${listData[index].counter}',
                      style: Themes().black12,
                    ),
                ],
              ).addMarginBottom(12),
            ),
          ).addMarginOnly(
            top: 12,
            bottom: 8,
          ),
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
