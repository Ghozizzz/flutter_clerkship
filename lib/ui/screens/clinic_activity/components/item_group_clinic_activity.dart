import 'package:clerkship/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../data/network/entity/clinic_doctor_response.dart';
import 'item_clinic_activity.dart';

class ItemGroupClinicActivity extends StatelessWidget {
  final bool rated;
  final ClinicDoctorTglData data;

  const ItemGroupClinicActivity({
    super.key,
    required this.data,
    this.rated = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          DateFormat('dd MMMM yyyy').format(data.tanggal!),
          style: Themes().blackBold14?.withColor(Themes.black),
        ).addMarginBottom(14),
        Column(
          children: List.generate(
            data.data!.length,
            (index) => ItemClinicActivity(
              data: data.data!,
              rated: rated,
            ).addMarginBottom(20),
          ),
        ),
      ],
    );
  }
}
