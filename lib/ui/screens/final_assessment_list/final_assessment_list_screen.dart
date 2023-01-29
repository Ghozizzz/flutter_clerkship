import 'package:clerkship/ui/components/commons/primary_appbar.dart';
import 'package:clerkship/ui/screens/final_assessment_list/components/assessment_list_header.dart';
import 'package:clerkship/ui/screens/final_assessment_list/components/item_rating_lecture.dart';
import 'package:clerkship/ui/screens/final_score_recap/final_score_recap_screen.dart';
import 'package:clerkship/ui/screens/global_rating/global_rating_detail_screen.dart';
import 'package:clerkship/ui/screens/global_rating/global_rating_screen.dart';
import 'package:clerkship/utils/nav_helper.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

class FinalAssessmentListScreen extends StatelessWidget {
  final bool rated;

  const FinalAssessmentListScreen({
    super.key,
    this.rated = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrimaryAppBar(title: 'Kembali'),
          const AssessmentListHeader(),
          Column(
            children: List.generate(
              3,
              (index) => ItemRatingLecture(
                isGlobalRating: index != 2,
                onTap: () {
                  if (index != 2) {
                    if (rated) {
                      NavHelper.navigatePush(const GlobalRatingDetailScreen());
                    } else {
                      NavHelper.navigatePush(GlobalRatingScreen());
                    }
                  } else {
                    NavHelper.navigatePush(const FinalScoreRecapScreen());
                  }
                },
              ).addMarginBottom(12),
            ),
          ).addAllMargin(20.w),
        ],
      ),
    );
  }
}
