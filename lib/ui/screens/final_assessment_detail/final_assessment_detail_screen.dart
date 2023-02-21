import 'package:clerkship/data/network/entity/scoring_response.dart';
import 'package:clerkship/ui/components/commons/animated_item.dart';
import 'package:clerkship/ui/components/commons/primary_appbar.dart';
import 'package:clerkship/ui/screens/final_assessment_detail/components/assessment_detail_header.dart';
import 'package:clerkship/ui/screens/final_assessment_detail/components/item_rating_lecture.dart';
import 'package:clerkship/ui/screens/final_assessment_detail/provider/final_assessment_detail_provider.dart';
import 'package:clerkship/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

class FinalAssessmentDetailScreen extends StatefulWidget {
  final bool rated;
  final ScoringData data;

  const FinalAssessmentDetailScreen({
    super.key,
    this.rated = false,
    required this.data,
  });

  @override
  State<FinalAssessmentDetailScreen> createState() =>
      _FinalAssessmentDetailScreenState();
}

class _FinalAssessmentDetailScreenState
    extends State<FinalAssessmentDetailScreen> {
  @override
  void initState() {
    super.initState();
    Tools.onViewCreated(() {
      context.read<FinalAssessmentDetailProvder>().getDetail(
            idBatch: '${widget.data.id}',
            idUser: '${widget.data.idUser}',
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final detailData = context.watch<FinalAssessmentDetailProvder>().detailData;
    final loading = context.watch<FinalAssessmentDetailProvder>().loading;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrimaryAppBar(title: 'Kembali'),
          const AssessmentDetailHeader(),
          loading
              ? const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : ListView.builder(
                  itemCount: detailData.length,
                  padding: EdgeInsets.all(20.w),
                  itemBuilder: (context, index) {
                    final data = detailData[index];

                    return AnimatedItem(
                      index: index,
                      child: ItemRatingLecture(
                        data: data,
                        rated: widget.rated,
                      ).addMarginBottom(12),
                    );
                  },
                ).addExpanded,
        ],
      ),
    );
  }
}
