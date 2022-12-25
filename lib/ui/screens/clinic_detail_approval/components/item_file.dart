import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../components/buttons/ripple_button.dart';
import '../../../components/commons/flat_card.dart';

class ItemFile extends StatelessWidget {
  const ItemFile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlatCard(
      border: Border.all(color: Themes.stroke),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Document.docx',
            style: Themes().black12?.withUnderline(offset: 2),
          ).addMarginLeft(12.w),
          RippleButton(
            onTap: () {},
            child: SvgPicture.asset(
              AssetIcons.icDownload,
              color: Themes.primary,
              width: 20.w,
              height: 20.w,
            ),
          ),
        ],
      ),
    );
  }
}
