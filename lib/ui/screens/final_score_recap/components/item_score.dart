import 'package:clerkship/data/network/services/scoring_recap_response.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes.dart';

class ItemScore extends StatelessWidget {
  final Detail data;

  const ItemScore({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.namaKeterangan ?? '',
              style: Themes().blackBold14?.withColor(Themes.black),
            ),
            Text(
              '${data.percentage}%',
              style: Themes().black12,
            )
          ],
        ),
        Text(
          data.nilai ?? '',
          style: Themes().blackBold14?.withColor(Themes.black),
        ),
      ],
    );
  }
}
