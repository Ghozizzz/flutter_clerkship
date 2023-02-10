import 'package:clerkship/data/models/key_value_data.dart';
import 'package:clerkship/data/network/entity/clinic_lecture_response.dart';
import 'package:clerkship/ui/screens/clinic_activity/providers/clinic_activity_lecture_provider.dart';
import 'package:clerkship/ui/screens/reject_activity/reject_activity_screen.dart';
import 'package:clerkship/utils/dialog_helper.dart';
import 'package:clerkship/utils/nav_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../components/buttons/primary_button.dart';
import '../../../components/commons/flat_card.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final clinicActivityProvider =
        context.watch<ClinicActivityLectureProvider>();
    final activities = clinicActivityProvider.clinicActivities;

    return FlatCard(
      shadow: Themes.softShadow,
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          PrimaryButton(
            onTap: () {
              final allActivities = <ClinicActivityData>[];
              for (MapEntry entry in activities.entries) {
                allActivities.addAll(entry.value);
              }
              final checkedActivities =
                  allActivities.where((element) => element.checked).toList();

              NavHelper.navigatePush(RejectActivityScreen(
                data: checkedActivities,
              ));
            },
            color: Themes.red,
            padding: EdgeInsets.all(14.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetIcons.icClose,
                  color: Themes.white,
                  width: 14.w,
                ).addMarginRight(8.w),
                Text(
                  'Tolak Semua',
                  style: Themes().whiteBold14,
                )
              ],
            ),
          ).addExpanded,
          Container(width: 8.w),
          PrimaryButton(
            onTap: () {
              DialogHelper.showModalConfirmation(
                title: 'Konfirmasi Persetujuan',
                message: 'Yakin ingin menyetujui semua kegiatan klinik?',
                positiveText: 'Setujui Semua',
                onPositiveTap: () => approveActivities(context),
              );
            },
            padding: EdgeInsets.all(14.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetIcons.icCheck,
                  color: Themes.white,
                  width: 14.w,
                ).addMarginRight(8.w),
                Text(
                  'Setujui Semua',
                  style: Themes().whiteBold14,
                )
              ],
            ),
          ).addExpanded,
        ],
      ),
    );
  }

  void approveActivities(BuildContext context) {
    DialogHelper.closeDialog();
    final checkedId = context.read<ClinicActivityLectureProvider>().checkedId;
    final data = List<KeyValueData>.generate(
      checkedId.length,
      (index) => KeyValueData(id: '${checkedId[index]}', reason: ''),
    );

    if (data.isNotEmpty) {
      context.read<ClinicActivityLectureProvider>().approveActivity(data);
    }
  }
}
