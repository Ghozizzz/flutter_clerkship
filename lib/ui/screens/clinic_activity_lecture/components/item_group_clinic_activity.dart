import 'package:clerkship/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:widget_helper/widget_helper.dart';

import 'item_clinic_activity.dart';

class ItemGroupClinicActivity extends StatelessWidget {
  const ItemGroupClinicActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '10 Agustus 2022',
          style: Themes().blackBold14?.withColor(Themes.black),
        ).addMarginBottom(14),
        Column(
          children: List.generate(
            2,
            (index) => ItemClinicActivity().addMarginBottom(20),
          ),
        ),
      ],
    );
  }
}
