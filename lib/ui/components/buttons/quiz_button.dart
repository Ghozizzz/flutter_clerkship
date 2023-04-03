import 'package:clerkship/data/network/entity/scoring_detail_response.dart';
import 'package:clerkship/ui/components/buttons/ripple_button.dart';
import 'package:clerkship/ui/components/commons/flat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../utils/tools.dart';

class QuizController extends ValueNotifier {
  Answer? selected;

  QuizController({this.selected}) : super(selected);

  void setSelected(Answer value) {
    selected = value;
    notifyListeners();
  }
}

class QuizButton extends StatefulWidget {
  final Assessment data;
  final bool isReadOnly;

  const QuizButton({
    super.key,
    required this.data,
    this.isReadOnly = false,
  });

  @override
  State<QuizButton> createState() => _QuizButtonState();
}

class _QuizButtonState extends State<QuizButton> {
  @override
  void initState() {
    super.initState();
    for (Answer answer in widget.data.jawaban ?? []) {
      if (answer.isTrue ?? false) {
        Tools.onViewCreated(() {
          widget.data.quizController.setSelected(answer);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final rightAnswers =
        widget.data.jawaban?.where((element) => element.isTrue ?? false) ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.data.pertanyaan}',
          style: Themes().blackBold12?.withColor(Themes.black),
        ).addMarginBottom(12),
        if (widget.isReadOnly)
          FlatCard(
            width: double.infinity,
            border: Border.all(color: Themes.stroke),
            padding: EdgeInsets.all(14.w),
            child: Text(
              rightAnswers.first.jawaban ?? '',
              style: Themes().black12,
            ),
          )
        else
          ValueListenableBuilder(
            valueListenable: widget.data.quizController,
            builder: (context, _, __) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.data.jawaban?.length,
                itemBuilder: (context, index) {
                  final quiz = widget.data.jawaban?[index];
                  final selected =
                      widget.data.quizController.selected?.idJawaban ==
                          quiz?.idJawaban;

                  return RippleButton(
                    onTap: () {
                      if (quiz == null) return;
                      widget.data.quizController.setSelected(quiz);
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
                            color: Themes.primary,
                            borderRadius: BorderRadius.circular(16.w),
                          ).animate(target: selected ? 1 : 0).scaleXY(
                                duration: const Duration(milliseconds: 100),
                                begin: 0,
                                end: 0.68,
                              ),
                        ).addMarginRight(12.w),
                        Text(
                          '${quiz?.jawaban}',
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
