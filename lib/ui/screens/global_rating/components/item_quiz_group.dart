import 'package:clerkship/data/models/quiz.dart';
import 'package:clerkship/ui/components/buttons/quiz_button.dart';
import 'package:flutter/material.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';

class ItemQuizGroup extends StatelessWidget {
  final List<Quiz> quizes;
  final List<QuizController> controllers;

  const ItemQuizGroup({
    super.key,
    required this.quizes,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'A. Professional Behaviours',
          style: Themes().blackBold14?.withColor(Themes.black),
        ).addMarginBottom(12),
        Column(
          children: controllers.map((controller) {
            return QuizButton(
              controller: controller,
              title:
                  'Reliable work habits with responsibility toward pts & staff, punctuality & attendance',
              data: quizes,
            ).addMarginBottom(12);
          }).toList(),
        )
      ],
    );
  }
}
