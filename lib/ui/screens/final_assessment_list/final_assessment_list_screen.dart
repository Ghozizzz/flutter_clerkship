import 'package:clerkship/ui/components/commons/primary_appbar.dart';
import 'package:clerkship/ui/screens/final_assessment_list/components/assessment_list_header.dart';
import 'package:clerkship/ui/screens/final_assessment_list/components/item_rating_lecture.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

class FinalAssessmentListScreen extends StatelessWidget {
  const FinalAssessmentListScreen({super.key});

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
                  } else {}
                },
              ).addMarginBottom(12),
            ),
          ).addAllMargin(20.w),
        ],
      ),
    );
  }
}
