import 'package:clerkship/data/shared_providers/standard_competency_provider.dart';
import 'package:clerkship/ui/screens/clinic_activity/providers/item_list_approve_provider.dart';
import 'package:clerkship/ui/screens/clinic_activity/providers/item_list_draft_provider.dart';
import 'package:clerkship/ui/screens/clinic_activity/providers/item_list_reject_provider.dart';
import 'package:clerkship/ui/screens/standard_competency/standard_competency_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../r.dart';
import '../../../../utils/nav_helper.dart';
import '../../clinic_activity/providers/item_list_all_provider.dart';
import '../../scientific_event/providers/item_list_all_provider.dart';
import '../../scientific_event/providers/item_list_approve_provider.dart';
import '../../scientific_event/providers/item_list_draft_provider.dart';
import '../../scientific_event/providers/item_list_reject_provider.dart';
import '../../clinic_activity/clinic_activity_student_screen.dart';
import '../../scientific_event/scientific_event_student_screen.dart';
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
                NavHelper.navigatePush(const ClinicActivityStudentScreen());
                context.read<ItemListAllClinicProvider>().getListClinic();
                context.read<ItemListDraftClinicProvider>().getListClinic();
                context.read<ItemListApproveClinicProvider>().getListClinic();
                context.read<ItemListRejectClinicProvider>().getListClinic();
              },
            ).addExpanded,
            Container(width: 20.w),
            ItemMenu(
              icon: AssetIcons.icScienceShow,
              title: 'Acara\nIlmiah',
              onTap: () {
                NavHelper.navigatePush(const ScientificEventStudentScreen());
                context
                    .read<ItemListAllScientificProvider>()
                    .getListScientific();
                context
                    .read<ItemListDraftScientificProvider>()
                    .getListScientific();
                context
                    .read<ItemListApproveScientificProvider>()
                    .getListScientific();
                context
                    .read<ItemListRejectScientificProvider>()
                    .getListScientific();
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
                context.read<StandardCompetencyProvider>().getListSk();
                NavHelper.navigatePush(const StandardCompetencyScreen());
              },
            ).addExpanded,
            Container(width: 20.w),
            ItemMenu(
              icon: AssetIcons.icFinalAssesment,
              title: 'Penilaian\nAkhir',
              onTap: () {
                // NavHelper.navigatePush(const FinalAssessmentStudentScreen());
              },
            ).addExpanded,
          ],
        ).addSymmetricMargin(horizontal: 20.w),
      ],
    );
  }
}
