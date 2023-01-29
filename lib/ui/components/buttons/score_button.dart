import 'package:clerkship/config/themes.dart';
import 'package:clerkship/ui/components/buttons/ripple_button.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

class ScoreController extends ValueNotifier {
  String? score;
  ScoreController({String? score}) : super(score);

  void setScore(String score) {
    this.score = score;
    notifyListeners();
  }
}

class ScoreButton extends StatelessWidget {
  final ScoreController controller;
  final String title;
  final scores = [
    'F',
    'P-',
    'P',
    'E',
  ];

  ScoreButton({
    super.key,
    required this.title,
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
            return Row(
              children: scores.map((data) {
                final selected = data == controller.score;

                return SizedBox(
                  width: 50.w,
                  height: 50.w,
                  child: RippleButton(
                    onTap: () {
                      controller.setScore(data);
                    },
                    border: Border.all(
                      color: selected ? Themes.primary : Themes.stroke,
                    ),
                    borderRadius: BorderRadius.circular(50.w),
                    padding: EdgeInsets.zero,
                    text: data,
                    textColor: selected ? Themes.primary : Themes.grey,
                  ),
                ).addMarginRight(12);
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
