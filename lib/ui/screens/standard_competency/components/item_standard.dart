import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../components/buttons/ripple_button.dart';

class ItemStandard extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  const ItemStandard({
    super.key,
    required this.title,
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
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Themes().blackBold12?.withColor(Themes.content),
          ).addFlexible,
          SvgPicture.asset(AssetIcons.icChevronRight),
        ],
      ),
    );
  }
}
