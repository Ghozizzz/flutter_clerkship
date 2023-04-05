import 'package:clerkship/config/themes.dart';
import 'package:clerkship/data/network/entity/scientifc_event_participant_response.dart';
import 'package:clerkship/ui/components/commons/animated_item.dart';
import 'package:clerkship/ui/components/commons/safe_statusbar.dart';
import 'package:clerkship/ui/components/items/item_student.dart';
import 'package:clerkship/ui/screens/scientific_event_student_list/components/header_widget.dart';
import 'package:clerkship/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../utils/nav_helper.dart';
import '../scientific_event/scientific_event_lecture_screen.dart';
import 'provider/scientific_event_student_provider.dart';

class ScientificEventStudentListScreen extends StatefulWidget {
  const ScientificEventStudentListScreen({super.key});

  @override
  State<ScientificEventStudentListScreen> createState() =>
      _ScientificEventStudentListScreenState();
}

class _ScientificEventStudentListScreenState
    extends State<ScientificEventStudentListScreen> {
  @override
  void initState() {
    super.initState();
    Tools.onViewCreated(() {
      context.read<ScientificEventStudentProvider>().getParticipant();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<ScientificEventStudentProvider>().loading;
    final participants =
        context.watch<ScientificEventStudentProvider>().participants;

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
                          participant: participant,
                          from: 1,
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
      ScientificEventLectureScreen(
        participant: participant,
      ),
    );
  }
}
