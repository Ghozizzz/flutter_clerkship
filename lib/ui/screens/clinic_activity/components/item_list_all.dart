import 'package:clerkship/ui/screens/clinic_activity/providers/item_list_all_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../utils/nav_helper.dart';
import '../../../components/commons/animated_item.dart';
import '../../add_clinic_activity/add_clinic_activity_screen.dart';
import '../../clinic_detail_approval/clinic_detail_approval_screen.dart';
import 'item_activity.dart';

class ListItemAllClinic extends StatelessWidget {
  const ListItemAllClinic({super.key});

  @override
  Widget build(BuildContext context) {
    final listAllClinic = context.watch<ItemListAllClinicProvider>().listClinic;
    return ListView.builder(
      itemCount: listAllClinic.length,
      padding: EdgeInsets.all(20.w),
      itemBuilder: (context, k) {
        String status;
        Color color;
        switch (listAllClinic[k].status) {
          case 0:
            status = 'Proses';
            color = Themes.blue;
            break;
          case 1:
            status = 'Diterima';
            color = Themes.green;
            break;
          case 2:
            status = 'Waiting';
            color = Themes.yellow;
            break;
          case 9:
            status = 'Ditolak';
            color = Themes.red;
            break;
          default:
            status = 'Proses';
            color = Themes.blue;
            break;
        }
        return AnimatedItem(
          index: k,
          child: ItemActivity(
            title: listAllClinic[k].namaDepartment!,
            date: DateFormat('DD MMMM yyyy').format(listAllClinic[k].tanggal!),
            doctor: listAllClinic[k].namaDokter!,
            status: status,
            colorStatus: color,
            onTap: () async {
              if (listAllClinic[k].status == 0) {
                NavHelper.navigatePush(
                  AddClinicActivityScreen(id: listAllClinic[k].id!),
                );
              } else {
                NavHelper.navigatePush(
                  ClinicDetailApprovalScreen(id: listAllClinic[k].id!),
                );
              }
            },
          ).addMarginBottom(12),
        );
      },
    );
  }
}
