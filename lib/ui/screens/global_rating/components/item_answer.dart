import 'package:clerkship/config/themes.dart';
import 'package:clerkship/data/network/entity/scoring_detail_response.dart';
import 'package:clerkship/ui/components/commons/flat_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

class ItemAnswer extends StatelessWidget {
  final Answer answer;
  const ItemAnswer({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reliable work habits with responsibility toward pts & staff, punctuality & attendance',
          style: Themes().blackBold12?.withColor(Themes.black),
        ).addMarginBottom(12),
        FlatCard(
          width: double.infinity,
          border: Border.all(color: Themes.stroke),
          padding: EdgeInsets.all(14.w),
          child: Text(
            'Unusually reliable in all areas of patient care',
            style: Themes().black12,
          ),
        ).addMarginBottom(12),
      ],
    );
  }
}
