import 'package:clerkship/config/themes.dart';
import 'package:clerkship/data/models/dropdown_item.dart';
import 'package:clerkship/ui/components/buttons/dropdown_field.dart';
import 'package:clerkship/ui/components/buttons/primary_button.dart';
import 'package:clerkship/ui/components/buttons/rating_button.dart';
import 'package:clerkship/ui/components/textareas/textarea.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../components/commons/primary_appbar.dart';
import '../../components/textareas/rich_text_editor.dart';

//https://www.figma.com/file/gpqTnuPavMZ5hUhQFjdBvW/UPH_Log_Book?node-id=38%3A8978&t=RJsZz2AJHkpfpvsi-0
class ClinicActivityReviewScreen extends StatelessWidget {
  ClinicActivityReviewScreen({super.key});

  final patientProblemController = TextEditingController();
  final patientAgeController = TextEditingController();
  final genderControler = DropDownController();
  final settingController = TextEditingController();
  final complexityControler = DropDownController();
  final medicalInterviewController = RatingController();
  final physicalExaminationController = RatingController();
  final profesionallismController = RatingController();
  final counsellinController = RatingController();
  final clinicalJudgementController = RatingController();
  final organizationController = RatingController();
  final overallController = RatingController();
  final noteController = FleatherController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PrimaryAppBar(
            title: 'Kembali',
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tinjauan Mini-CEX',
                    style: Themes().primaryBold20,
                  ).addMarginBottom(14),
                  Text(
                    'Bhima Saputra',
                    style: Themes().blackBold14,
                  ),
                  Text(
                    'ID. 1123532345',
                    style: Themes().gray10?.boldText(),
                  ).addMarginBottom(16),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Themes.stroke,
                  ).addMarginBottom(14),
                  Text(
                    'INFORMASI DASAR',
                    style: Themes().blackBold12,
                  ).addMarginBottom(8),
                  Text(
                    'Masalah Pasien',
                    style: Themes().blackBold12,
                  ).addMarginBottom(8),
                  TextArea(
                    controller: patientProblemController,
                    hint: 'Deskripsi Masalah Pasien',
                  ).addMarginBottom(20),
                  Text(
                    'Umur Pasien',
                    style: Themes().blackBold12,
                  ).addMarginBottom(8),
                  TextArea(
                    controller: patientAgeController,
                    hint: ' Umur Pasien',
                    inputType: TextInputType.number,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ).addMarginBottom(20),
                  Text(
                    'Gender Pasien',
                    style: Themes().blackBold12,
                  ).addMarginBottom(8),
                  DropdownField(
                    withSearchField: false,
                    controller: genderControler,
                    hint: 'Gender Pasien',
                    items: [
                      DropDownItem(
                        title: 'Pria',
                        value: 'p',
                      ),
                      DropDownItem(
                        title: 'Wanita',
                        value: 'w',
                      ),
                    ],
                  ).addMarginBottom(20),
                  Text(
                    'Setting',
                    style: Themes().blackBold12,
                  ).addMarginBottom(8),
                  TextArea(
                    controller: settingController,
                    hint: 'Deskripsi Setting',
                  ).addMarginBottom(20),
                  Text(
                    'Kerumitan Masalah',
                    style: Themes().blackBold12,
                  ).addMarginBottom(8),
                  DropdownField(
                    withSearchField: false,
                    controller: complexityControler,
                    hint: 'Pilih Tingkat Kerumitan',
                    items: List.generate(
                      3,
                      (index) => DropDownItem(
                        title: 'Mudah',
                        value: index,
                      ),
                    ),
                  ).addMarginBottom(27),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    width: double.infinity,
                    height: 1,
                    color: Themes.stroke,
                  ),
                  Text(
                    'PENILAIAN TINJAUAN',
                    style: Themes().blackBold12,
                  ).addMarginBottom(22),
                  RatingButton(
                    title: 'Medical Interviewing Skills',
                    controller: medicalInterviewController,
                  ).addMarginBottom(20),
                  RatingButton(
                    title: 'Physical Examination Skills',
                    controller: physicalExaminationController,
                  ).addMarginBottom(20),
                  RatingButton(
                    title: 'Profesionalisme/ Humanistic Qualities',
                    controller: profesionallismController,
                  ).addMarginBottom(20),
                  RatingButton(
                    title: 'Counselln Skills',
                    controller: counsellinController,
                  ).addMarginBottom(20),
                  RatingButton(
                    title: 'Clinical Judgment',
                    controller: clinicalJudgementController,
                  ).addMarginBottom(20),
                  RatingButton(
                    title: 'Organization/Efficiency',
                    controller: organizationController,
                  ).addMarginBottom(20),
                  RatingButton(
                    title: 'Overall Clinical Competence',
                    controller: overallController,
                  ).addMarginBottom(20),
                  Text(
                    'Catatan/Masukan',
                    style: Themes().blackBold12,
                  ).addMarginBottom(8),
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
                  ).addMarginBottom(26),
                ],
              ),
            ),
          ).addExpanded,
        ],
      ),
    );
  }
}
