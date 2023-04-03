import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../components/buttons/ripple_button.dart';

class ItemFile extends StatelessWidget {
  final String title;
  final String url;
  final VoidCallback? onTap;

  const ItemFile({
    super.key,
    required this.title,
    required this.url,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RippleButton(
      onTap: onTap,
      padding: EdgeInsets.zero,
      border: Border.all(color: Themes.stroke),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                Themes(withLineHeight: true).black12?.withUnderline(offset: 2),
          ).addMarginLeft(12.w).addFlexible,
          RippleButton(
            onTap: onTap,
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
