import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../components/buttons/ripple_button.dart';

class ItemRating extends StatelessWidget {
  final VoidCallback onTap;

  const ItemRating({
    super.key,
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
            'GRS - Tengah Rotasi',
            style: Themes().blackBold12?.withColor(Themes.content),
          ),
          SvgPicture.asset(AssetIcons.icChevronRight),
        ],
      ),
    );
  }
}
