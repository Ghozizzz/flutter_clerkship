import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../components/buttons/ripple_button.dart';

class ItemStandard extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String? subtitle;

  const ItemStandard({
    super.key,
    required this.title,
    this.subtitle,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Themes().blackBold12?.withColor(Themes.content),
                  softWrap: true,
                  maxLines: 2,
                ),
                Text(
                  subtitle ?? '',
                  style: Themes().blackBold10?.withColor(Themes.content),
                ),
              ],
            ),
          ),
          SvgPicture.asset(AssetIcons.icChevronRight),
        ],
      ),
    );
  }
}
