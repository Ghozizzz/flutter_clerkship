import 'package:clerkship/config/themes.dart';
import 'package:clerkship/data/models/dinamic_notification.dart';
import 'package:clerkship/data/shared_providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../data/models/key_value_data.dart';
import '../../../../data/shared_providers/notification_provider.dart';
import '../../../../data/shared_providers/survey_provider.dart';
import '../../../../utils/dialog_helper.dart';
import '../../../../utils/nav_helper.dart';
import '../../../components/modal/modal_confirmation.dart';
import '../../clinic_activity/providers/clinic_activity_lecture_provider.dart';
import '../../scientific_event_approval/scientific_event_approval_screen.dart';
import '../../survey/survey_screen.dart';
import 'item_notification.dart';

class ItemGroupNotification extends StatelessWidget {
  final DinamicNotification notif;
  const ItemGroupNotification({
    super.key,
    required this.notif,
  });

  @override
  Widget build(BuildContext context) {
    final role = context.watch<UserProvider>().user.roleId;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          notif.title,
          style: Themes().blackBold12?.withColor(Themes.hint),
        ).addSymmetricMargin(vertical: 10),
        Column(
          children: List.generate(
            notif.notif!.length,
            (index) {
              return ItemNotification(
                notif: notif.notif![index],
                onTap: role == 2
                    ? () {
                        switch (notif.notif![index].notifType) {
                          case 5:
                            context.read<SurveyProvider>().getSurveyList();
                            NavHelper.navigatePush(const SurveyScreen());
                            break;
                        }
                      }
                    : () {
                        switch (notif.notif![index].notifType) {
                          case 0:
                            approveActivity(
                              context: context,
                              id: notif.notif![index].idTrx,
                            );
                            break;
                          case 1:
                            NavHelper.navigatePush(
                              ScientificEventApprovalScreen(
                                  id: '${notif.notif![index].idTrx}'),
                            );
                            break;
                          case 2:
                            NavHelper.navigatePush(
                              ScientificEventApprovalScreen(
                                  id: '${notif.notif![index].idTrx}'),
                            );
                            break;
                        }
                      },
              ).addMarginBottom(10);
            },
          ),
        )
      ],
    );
  }

  approveActivity({
    required BuildContext context,
    int? id,
  }) {
    DialogHelper.showModalConfirmation(
      title: 'Konfirmasi Persetujuan',
      message: 'Apakah anda yakin ingin menyetujui catatan ini?',
      type: ConfirmationType.withField,
      labelField: 'Masukan',
      hintField: 'Masukkan Alasan Persetujuan',
      optionalField: true,
      onPositiveTapWithField: (fieldValue) {
        Navigator.pop(context);

        if (id != null) {
          context.read<ClinicActivityLectureProvider>().approveActivity([
            KeyValueData(
              id: '$id',
              reason: fieldValue,
            ),
          ]).then((value) {
            final role = context.read<UserProvider>().user.roleId;
            context.read<NotificationProvider>().getNotification(role: role!);
          });
        }
      },
    );
  }
}
