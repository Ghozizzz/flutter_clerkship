import 'package:clerkship/config/themes.dart';
import 'package:clerkship/data/network/entity/clinic_lecture_response.dart';
import 'package:clerkship/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:widget_helper/widget_helper.dart';

import 'item_clinic_activity.dart';

class ItemGroupClinicActivity extends StatelessWidget {
  final bool rated;
  final ClinicActivityData clinicActivities;

  const ItemGroupClinicActivity({
    super.key,
    this.rated = false,
    required this.clinicActivities,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          clinicActivities.tanggal?.formatDate('dd MMMM yyyy') ?? '',
          style: Themes().blackBold14?.withColor(Themes.black),
        ).addMarginBottom(14),
        Column(
          children: (clinicActivities.data ?? []).map((data) {
            return ItemClinicActivity(
              data: data,
              rated: rated,
            ).addMarginBottom(20);
          }).toList(),
        ),
      ],
    );
  }
}
