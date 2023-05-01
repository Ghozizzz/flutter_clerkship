import 'package:clerkship/config/themes.dart';
import 'package:clerkship/ui/components/buttons/ripple_button.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../commons/flat_card.dart';

class SurveyScoreController extends ValueNotifier {
  int? score;
  SurveyScoreController({int? score}) : super(score);

  void setScore(int score) {
    this.score = score;
    notifyListeners();
  }
}

class SurveyScoreButton extends StatelessWidget {
  final SurveyScoreController controller;
  final String title;
  final bool readOnly;
  final int nilai;
  final scores = [
    'sangat kurang / hampir tidak ada / sangat tidak setuju',
    'kurang / sedikit / kurang setuju',
    'cukup / sesuai / setuju',
    'banyak / baik / sangat setuju',
  ];

  SurveyScoreButton({
    super.key,
    required this.title,
    required this.readOnly,
    required this.nilai,
    required this.controller,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Themes().blackBold12,
        ).addMarginBottom(12),
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, _, __) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: scores.length,
                itemBuilder: (context, index) {
                  dynamic selectedNilai = (readOnly==true)? nilai : controller.score;
                  final selected = index == selectedNilai;
                  return RippleButton(
                    onTap: () {
                      if(readOnly==false){
                        debugPrint(index.toString());
                        controller.setScore(index);
                      }
                    },
                    border: Border.all(
                      color: selected ? Themes.primary : Themes.stroke,
                    ),
                    child: Row(
                      children: [
                        FlatCard(
                          width: 16.w,
                          height: 16.w,
                          border: Border.all(
                            color: selected ? Themes.primary : Themes.grey,
                          ),
                          borderRadius: BorderRadius.circular(16.w),
                          child: FlatCard(
                            color: selected ? Themes.primary : Themes.grey,
                            borderRadius: BorderRadius.circular(16.w),
                          )
                        ).addMarginRight(12.w),
                        Text(
                          scores[index],
                          style: Themes(withLineHeight: true)
                              .black12
                              ?.withColor(selected ? Themes.primary : null),
                        ).addFlexible,
                      ],
                    ),
                  ).addMarginBottom(12);
                },
              );
            },
          ),
      ],
    );
  }
}
