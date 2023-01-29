import 'package:clerkship/ui/components/buttons/primary_button.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../components/buttons/score_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/textareas/rich_text_editor.dart';

//https://www.figma.com/file/gpqTnuPavMZ5hUhQFjdBvW/UPH_Log_Book?node-id=38%3A10100&t=RJsZz2AJHkpfpvsi-0
class ScientificEventReviewScreen extends StatelessWidget {
  ScientificEventReviewScreen({super.key});

  final demographicsController = ScoreController();
  final complaintsController = ScoreController();
  final pastController = ScoreController();
  final familyHistoryController = ScoreController();
  final otherController = ScoreController();
  final physicalExaminationController = ScoreController();
  final investigationController = ScoreController();
  final summaryController = ScoreController();
  final noteController = FleatherController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrimaryAppBar(title: 'Kembali'),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tinjauan Presentasi Kasus',
                  style: Themes().blackBold20,
                ).addMarginBottom(12),
                Text(
                  'Bhima Saputra',
                  style: Themes().blackBold14,
                ),
                Text(
                  'ID. 1123532345',
                  style: Themes().gray10?.boldText(),
                ).addMarginBottom(20),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Themes.stroke,
                  margin: const EdgeInsets.only(bottom: 12),
                ),
                Text(
                  'FORMAT',
                  style: Themes().blackBold12,
                ).addMarginBottom(12),
                ScoreButton(
                  title:
                      'Patient Demographic Information (age, gender, social information)',
                  controller: demographicsController,
                ).addMarginBottom(20),
                ScoreButton(
                  title: 'History Taking - Presenting complaints',
                  controller: complaintsController,
                ).addMarginBottom(20),
                ScoreButton(
                  title: 'History Taking -	Past history',
                  controller: pastController,
                ).addMarginBottom(20),
                ScoreButton(
                  title: 'History Taking -	Family history',
                  controller: familyHistoryController,
                ).addMarginBottom(20),
                ScoreButton(
                  title: 'History Taking -	Other',
                  controller: otherController,
                ).addMarginBottom(20),
                ScoreButton(
                  title: 'General physical examination',
                  controller: physicalExaminationController,
                ).addMarginBottom(20),
                ScoreButton(
                  title:
                      'Investigations needed to support diagnosis and expected results',
                  controller: investigationController,
                ).addMarginBottom(20),
                ScoreButton(
                  title: 'SUMMARY',
                  controller: summaryController,
                ).addMarginBottom(20),
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
                PrimaryButton(
                  onTap: () {},
                  text: 'Simpan Penilaian',
                ).addMarginBottom(20),
              ],
            ),
          ).addExpanded,
        ],
      ),
    );
  }
}
