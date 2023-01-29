import 'package:clerkship/ui/components/commons/primary_appbar.dart';
import 'package:clerkship/ui/screens/global_rating/components/global_rating_header.dart';
import 'package:clerkship/utils/dialog_helper.dart';
import 'package:clerkship/utils/nav_helper.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/models/quiz.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/buttons/quiz_button.dart';
import '../../components/buttons/secondary_button.dart';
import '../../components/textareas/rich_text_editor.dart';
import 'components/item_quiz_group.dart';

class GlobalRatingScreen extends StatelessWidget {
  final data = [];
  final noteController = FleatherController();

  GlobalRatingScreen({super.key}) {
    generateData();
  }

  @override
  Widget build(BuildContext context) {
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
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ItemQuizGroup(
                      quizes: data[index]['quiz'],
                      controllers: data[index]['controller'],
                    ).addMarginTop(20);
                  },
                ),
                Text(
                  'Catatan/Masukan',
                  style: Themes().blackBold12,
                ).addMarginBottom(12),
                SizedBox(
                  height: 300,
                  child: RichTextEditor(
                    controller: noteController,
                    hint: 'Tulis catatan di sini',
                  ),
                ).addMarginBottom(20),
                SecondaryButton(
                  onTap: () {},
                  text: 'Simpan Perubahan',
                ).addMarginBottom(18),
                PrimaryButton(
                  onTap: () {
                    DialogHelper.showMessageDialog(
                      title: 'Dinilai',
                      body: 'Penilaian sudah dilakukan',
                    ).then((_) {
                      NavHelper.pop();
                    });
                  },
                  text: 'Simpan Penilaian',
                ).addMarginBottom(20),
              ],
            ),
          ).addExpanded,
        ],
      ),
    );
  }

  void generateData() {
    for (int i = 0; i < 4; i++) {
      data.add({
        'quiz': List.generate(
          5,
          (index) => Quiz(
            title: 'Poor follow-up care; unreliable (late/absent)',
            id: '$index',
          ),
        ),
        'controller': List.generate(4, (index) => QuizController()),
      });
    }
  }
}
