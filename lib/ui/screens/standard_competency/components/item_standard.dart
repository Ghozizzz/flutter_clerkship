import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../components/buttons/ripple_button.dart';

class ItemStandard extends StatelessWidget {
  final VoidCallback onTap;

  const ItemStandard({
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
            'Ilmu Penyakit Dalam',
            style: Themes().blackBold12?.withColor(Themes.content),
          ),
          SvgPicture.asset(AssetIcons.icChevronRight),
        ],
      ),
    );
  }
}
