import 'package:clerkship/config/themes.dart';
import 'package:clerkship/ui/components/commons/safe_statusbar.dart';
import 'package:clerkship/ui/screens/scientific_event_assessment/components/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import 'components/item_student_activity.dart';

//https://www.figma.com/file/gpqTnuPavMZ5hUhQFjdBvW/UPH_Log_Book?node-id=72%3A6271&t=RJsZz2AJHkpfpvsi-0
class ScientificEventAssessmentScreen extends StatelessWidget {
  const ScientificEventAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeStatusBar(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderWidget(),
            Text(
              'Penilaian Kegiatan Klinik',
              style: Themes().blackBold16?.withColor(Themes.black),
            ).addMarginOnly(
              top: 20.w,
              left: 20.w,
            ),
            ListView.builder(
              itemCount: 5,
              padding: EdgeInsets.all(20.w),
              itemBuilder: (context, index) {
                return const ItemStudentActivity().addMarginBottom(10);
              },
            ).addExpanded
          ],
        ),
      ),
    );
  }
}
