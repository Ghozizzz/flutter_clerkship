import 'package:clerkship/config/themes.dart';
import 'package:clerkship/ui/components/commons/safe_statusbar.dart';
import 'package:clerkship/ui/components/items/item_student.dart';
import 'package:clerkship/ui/screens/scientific_event_student_list/components/header_widget.dart';
import 'package:clerkship/ui/screens/standart_competency_student_list/provider/standart_competency_lecture_provider.dart';
import 'package:clerkship/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../data/network/entity/scientifc_event_participant_response.dart';
import '../../../utils/nav_helper.dart';
import '../../components/commons/animated_item.dart';
import '../standard_competency/standart_lecture_screen.dart';

class StandartCompetencyStudentListScreen extends StatefulWidget {
  const StandartCompetencyStudentListScreen({super.key});

  @override
  State<StandartCompetencyStudentListScreen> createState() =>
      _StandartCompetencyStudentListScreenState();
}

class _StandartCompetencyStudentListScreenState
    extends State<StandartCompetencyStudentListScreen> {
  @override
  void initState() {
    super.initState();
    Tools.onViewCreated(() {
      context.read<StandartCompetencyLectureProvider>().getParticipant();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<StandartCompetencyLectureProvider>().loading;
    final participants =
        context.watch<StandartCompetencyLectureProvider>().participants;

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
            loading
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView.builder(
                    itemCount: participants.length,
                    padding: EdgeInsets.all(20.w),
                    itemBuilder: (context, index) {
                      final participant = participants[index];

                      return AnimatedItem(
                        child: ItemStudent(
                          onTap: () => onTapItemStudent(participant),
                        ),
                      ).addMarginBottom(10);
                    },
                  ).addExpanded
          ],
        ),
      ),
    );
  }

  void onTapItemStudent(ScientificEventParticipant participant) {
    NavHelper.navigatePush(
      StandartLectureScreen(
        participant: participant,
      ),
    );
  }
}
