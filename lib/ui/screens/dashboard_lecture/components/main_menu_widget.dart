import 'package:clerkship/ui/screens/clinic_activity_lecture/clinic_activity_lecture_screen.dart';
import 'package:clerkship/ui/screens/final_assessment/final_assessment_screen.dart';
import 'package:clerkship/ui/screens/scientific_event_student/scientific_event_student_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../r.dart';
import '../../../../utils/nav_helper.dart';
import '../../standart_competency_student/standart_competency_student_screen.dart';
import 'item_menu.dart';

class MainMenuWidget extends StatelessWidget {
  const MainMenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ItemMenu(
              icon: AssetIcons.icClinicActivity,
              title: 'Kegiatan\nKlinik',
              onTap: () {
                NavHelper.navigatePush(const ClinicActivityLectureScreen());
              },
            ).addExpanded,
            Container(width: 20.w),
            ItemMenu(
              icon: AssetIcons.icScienceShow,
              title: 'Acara\nIlmiah',
              onTap: () {
                NavHelper.navigatePush(const ScientificEventStudentScreen());
              },
            ).addExpanded,
          ],
        ).addSymmetricMargin(horizontal: 20.w),
        Container(height: 20.w),
        Row(
          children: [
            ItemMenu(
              icon: AssetIcons.icStandartCompetence,
              title: 'Standar\nKompetensi',
              onTap: () {
                NavHelper.navigatePush(const StandartCompetencyStudentScreen());
              },
            ).addExpanded,
            Container(width: 20.w),
            ItemMenu(
              icon: AssetIcons.icFinalAssesment,
              title: 'Penilaian\nAkhir',
              onTap: () {
                NavHelper.navigatePush(const FinalAssessmentScreen());
              },
            ).addExpanded,
          ],
        ).addSymmetricMargin(horizontal: 20.w),
      ],
    );
  }
}
