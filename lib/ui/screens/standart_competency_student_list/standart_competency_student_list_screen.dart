import 'package:clerkship/config/themes.dart';
import 'package:clerkship/ui/components/commons/safe_statusbar.dart';
import 'package:clerkship/ui/components/items/item_student.dart';
import 'package:clerkship/ui/screens/scientific_event_student_list/components/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../utils/nav_helper.dart';
import '../standard_competency/standart_lecture_screen.dart';

class StandartCompetencyStudentListScreen extends StatelessWidget {
  const StandartCompetencyStudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeStatusBar(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderWidget(),
            Text(
              'Standar Kompetensi Mahasiswa',
              style: Themes().blackBold16?.withColor(Themes.black),
            ).addMarginOnly(
              top: 20.w,
              left: 20.w,
            ),
            ListView.builder(
              itemCount: 5,
              padding: EdgeInsets.all(20.w),
              itemBuilder: (context, index) {
                return ItemStudent(
                  onTap: () {
                    NavHelper.navigatePush(const StandartLectureScreen());
                  },
                ).addMarginBottom(10);
              },
            ).addExpanded
          ],
        ),
      ),
    );
  }
}
