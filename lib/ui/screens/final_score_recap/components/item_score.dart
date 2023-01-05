import 'package:flutter/material.dart';

import '../../../../config/themes.dart';

class ItemScore extends StatelessWidget {
  const ItemScore({
    super.key,
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
              'Presentasi Kasus I',
              style: Themes().blackBold14?.withColor(Themes.black),
            ),
            Text(
              '5%',
              style: Themes().black12,
            )
          ],
        ),
        Text(
          'A',
          style: Themes().blackBold14?.withColor(Themes.black),
        ),
      ],
    );
  }
}
