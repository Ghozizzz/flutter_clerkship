import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../components/buttons/ripple_button.dart';

class ItemRatingLecture extends StatelessWidget {
  final bool isGlobalRating;
  final VoidCallback onTap;

  const ItemRatingLecture({
    super.key,
    required this.isGlobalRating,
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
            isGlobalRating ? 'GRS - Tengah Rotasi' : 'Rekapitulasi Nilai Akhir',
            style: Themes().blackBold12?.withColor(Themes.content),
          ),
          SvgPicture.asset(AssetIcons.icChevronRight),
        ],
      ),
    );
  }
}
