import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../../utils/nav_helper.dart';
import '../../../components/buttons/ripple_button.dart';
import '../../final_score_recap/final_score_recap_screen.dart';
import '../../global_rating/global_rating_detail_screen.dart';
import '../../global_rating/global_rating_screen.dart';
import '../provider/final_assessment_detail_provider.dart';

class ItemRatingLecture extends StatelessWidget {
  final bool rated;
  final int index;

  ItemRatingLecture({
    super.key,
    required this.rated,
    required this.index,
  });

  final titles = [
    'GRS - Tengah Rotasi',
    'GRS - Akhir Rotasi',
    'Rekapitulasi Nilai Akhir',
  ];

  @override
  Widget build(BuildContext context) {
    final headerData = context.watch<FinalAssessmentDetailProvder>().headerData;

    return RippleButton(
      onTap: () {
        if (rated) {
          NavHelper.navigatePush(const GlobalRatingDetailScreen());
        } else {
          if (index < 2) {
            if (headerData == null) return;
            NavHelper.navigatePush(GlobalRatingScreen(
              id: headerData.id!,
              idBatch: headerData.idBatch!,
              idRatingType: index,
            ));
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
            titles[index],
            style: Themes().blackBold12?.withColor(Themes.content),
          ),
          SvgPicture.asset(AssetIcons.icChevronRight),
        ],
      ),
    );
  }
}
