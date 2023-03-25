import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/themes.dart';
import '../../../../data/network/entity/scoring_response.dart';
import '../../../../r.dart';
import '../../../../utils/nav_helper.dart';
import '../../../components/buttons/ripple_button.dart';
import '../../final_score_recap/final_score_recap_screen.dart';
import '../../global_rating/global_rating_screen.dart';

class ItemRatingLecture extends StatelessWidget {
  final bool rated;
  final int index;
  final ScoringData data;

  ItemRatingLecture({
    super.key,
    required this.rated,
    required this.index,
    required this.data,
  });

  final titles = [
    'GRS - Tengah Rotasi',
    'GRS - Akhir Rotasi',
    'Rekapitulasi Nilai Akhir',
  ];

  @override
  Widget build(BuildContext context) {
    return RippleButton(
      onTap: () {
        if (index < 2) {
          NavHelper.navigatePush(GlobalRatingScreen(
            data: data,
            idRatingType: '$index',
          ));
        } else {
          NavHelper.navigatePush(const FinalScoreRecapScreen());
        }
      },
      border: Border.all(color: Themes.stroke),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titles[index],
            style: Themes().blackBold12?.withColor(Themes.content),
          ),
          SvgPicture.asset(AssetIcons.icChevronRight),
        ],
      ),
    );
  }
}
