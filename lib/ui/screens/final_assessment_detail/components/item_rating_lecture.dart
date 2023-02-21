import 'package:clerkship/data/network/entity/scoring_detail_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../../utils/nav_helper.dart';
import '../../../components/buttons/ripple_button.dart';
import '../../final_score_recap/final_score_recap_screen.dart';
import '../../global_rating/global_rating_detail_screen.dart';
import '../../global_rating/global_rating_screen.dart';

class ItemRatingLecture extends StatelessWidget {
  final ScoringDetail data;
  final bool rated;

  const ItemRatingLecture({
    super.key,
    required this.data,
    required this.rated,
  });

  @override
  Widget build(BuildContext context) {
    return RippleButton(
      onTap: () {
        if (rated) {
          NavHelper.navigatePush(const GlobalRatingDetailScreen());
        } else {
          if (data.idTipe == 0) {
            NavHelper.navigatePush(GlobalRatingScreen());
          } else {
            NavHelper.navigatePush(const FinalScoreRecapScreen());
          }
        }
      },
      border: Border.all(color: Themes.stroke),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${data.namaSection}',
            style: Themes().blackBold12?.withColor(Themes.content),
          ),
          SvgPicture.asset(AssetIcons.icChevronRight),
        ],
      ),
    );
  }
}
