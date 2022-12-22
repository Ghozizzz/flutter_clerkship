import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../components/buttons/ripple_button.dart';
import '../../../components/commons/flat_card.dart';

class ItemEvent extends StatelessWidget {
  const ItemEvent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RippleButton(
      onTap: () {},
      border: Border.all(color: Themes.stroke),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mini Referat',
              style: Themes().blackBold12?.withColor(Themes.black),
            ).addMarginBottom(8),
            Text(
              '18 September 2022',
              style: Themes().black12?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Themes.black,
                  ),
            ).addMarginBottom(12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetIcons.icProfile,
                  width: 12,
                  height: 12,
                ).addMarginRight(8),
                Text(
                  'dr. Budiman',
                  style: Themes().black10,
                ).addExpanded,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
