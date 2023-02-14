import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../data/network/entity/scientifc_event_participant_response.dart';
import '../buttons/ripple_button.dart';
import '../../../utils/extensions.dart';

class ItemStudent extends StatelessWidget {
  final VoidCallback onTap;
  final ScientificEventParticipant participant;

  const ItemStudent({
    super.key,
    required this.participant,
    required this.onTap,
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
                '${participant.namaStudent}',
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
                    participant.tanggal?.formatDate('dd MMMM yyyy') ?? '',
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
