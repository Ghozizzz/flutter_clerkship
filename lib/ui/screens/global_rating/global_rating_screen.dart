import 'package:clerkship/data/network/entity/scoring_detail_response.dart';
import 'package:clerkship/data/network/entity/scoring_response.dart';
import 'package:clerkship/ui/components/commons/primary_appbar.dart';
import 'package:clerkship/ui/screens/global_rating/components/global_rating_header.dart';
import 'package:clerkship/ui/screens/global_rating/components/item_quiz_group.dart';
import 'package:clerkship/ui/screens/global_rating/provider/rating_assessment_provider.dart';
import 'package:clerkship/utils/tools.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../components/buttons/primary_button.dart';
import '../../components/buttons/secondary_button.dart';
import '../final_assessment_detail/provider/final_assessment_detail_provider.dart';

class GlobalRatingScreen extends StatefulWidget {
  final ScoringData data;
  final String idRatingType;

  const GlobalRatingScreen({
    super.key,
    required this.data,
    required this.idRatingType,
  });

  @override
  State<GlobalRatingScreen> createState() => _GlobalRatingScreenState();
}

class _GlobalRatingScreenState extends State<GlobalRatingScreen> {
  FleatherController noteController = FleatherController();

  @override
  void initState() {
    super.initState();
    Tools.onViewCreated(() async {});
  }

  @override
  Widget build(BuildContext context) {
    final detailData = widget.idRatingType == '0'
        ? context.watch<FinalAssessmentDetailProvder>().detailDataMiddle
        : context.watch<FinalAssessmentDetailProvder>().detailDataFinal;
    final headerData = widget.idRatingType == '0'
        ? context.watch<FinalAssessmentDetailProvder>().headerDataMiddle
        : context.watch<FinalAssessmentDetailProvder>().headerDataFinal;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrimaryAppBar(title: 'Kembali'),
          const GlobalRatingHeader(isQuiz: true),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: detailData.length,
                  itemBuilder: (context, index) {
                    final itemData = detailData[index];

                    return ItemQuizGroup(
                      data: itemData,
                      isReadOnly: headerData?.status == 1,
                    ).addMarginTop(20);
                  },
                ).addMarginBottom(20),
                if (headerData?.status == 0 ||
                    headerData?.status == 2 ||
                    headerData?.status == null)
                  if (detailData.isNotEmpty)
                    MultiValueListenableBuilder(
                      valueListenables: [
                        for (ScoringDetail data in detailData)
                          for (Assessment assessment in data.dataDetail ?? [])
                            assessment.quizController,
                      ],
                      builder: (context, _, __) {
                        return Column(
                          children: [
                            SecondaryButton(
                              enable: isValidForm(detailData),
                              onTap: () => context
                                  .read<RatingAssessmentProvider>()
                                  .insertDetailScoring(
                                    idRatingType: widget.idRatingType,
                                    id: headerData?.id ?? 0,
                                    idBatch: headerData?.idBatch ?? 0,
                                    idUser: headerData?.idUser ?? 0,
                                    status: 2,
                                    data: detailData,
                                    onFinish: () {
                                      context
                                          .read<FinalAssessmentDetailProvder>()
                                          .getDetail(
                                            id: '${widget.data.id}',
                                            idUser: '${widget.data.idUser}',
                                          );
                                    },
                                  ),
                              text: 'Simpan Perubahan',
                            ).addMarginBottom(18),
                            PrimaryButton(
                              enable: isValidForm(detailData),
                              onTap: () => context
                                  .read<RatingAssessmentProvider>()
                                  .insertDetailScoring(
                                      idRatingType: widget.idRatingType,
                                      id: headerData?.id ?? 0,
                                      idBatch: headerData?.idBatch ?? 0,
                                      idUser: headerData?.idUser ?? 0,
                                      status: 1,
                                      data: detailData,
                                      onFinish: () {
                                        context
                                            .read<
                                                FinalAssessmentDetailProvder>()
                                            .getDetail(
                                              id: '${widget.data.id}',
                                              idUser: '${widget.data.idUser}',
                                            );
                                      }),
                              text: 'Simpan Penilaian',
                            ).addMarginBottom(20),
                          ],
                        );
                      },
                    ),
              ],
            ),
          ).addExpanded,
        ],
      ),
    );
  }

  bool isValidForm(List<ScoringDetail> group) {
    final isAllFilled = [];

    for (ScoringDetail data in group) {
      for (Assessment assessment in data.dataDetail ?? []) {
        if (data.idTipe == 1) {
          isAllFilled.add(
              assessment.notesController.plainTextEditingValue.text.isNotEmpty);
        } else {
          isAllFilled.add(assessment.quizController.selected != null);
        }
      }
    }

    return !isAllFilled.contains(false) &&
        noteController.plainTextEditingValue.text.isNotEmpty;
  }
}
