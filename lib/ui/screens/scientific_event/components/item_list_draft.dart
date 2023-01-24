import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../data/shared_providers/reference_provider.dart';
import '../../../../utils/nav_helper.dart';
import '../../../components/commons/animated_item.dart';
import '../../add_scientific_event/add_scientific_event_screen.dart';
import '../../clinic_activity/components/item_activity.dart';
import '../../scientific_event_detail_approval/scientific_event_approval_screen.dart';
import '../providers/item_list_draft_provider.dart';

class ListItemDraftScientific extends StatelessWidget {
  const ListItemDraftScientific({super.key});

  @override
  Widget build(BuildContext context) {
    final listAllScientific =
        context.watch<ItemListDraftScientificProvider>().listScientific;
    final loading = context.watch<ItemListDraftScientificProvider>().loading;

    if (loading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: listAllScientific.length,
        padding: EdgeInsets.all(20.w),
        itemBuilder: (context, k) {
          String status;
          Color color;
          switch (listAllScientific[k].status) {
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
              title: listAllScientific[k].namaDepartment!,
              date: DateFormat('DD MMMM yyyy')
                  .format(listAllScientific[k].tanggal!),
              doctor: listAllScientific[k].namaDokter!,
              status: status,
              colorStatus: color,
              onTap: () async {
                if (listAllScientific[k].status == 0) {
                  context.read<ReferenceProvider>().getBatch(
                        idFlow: 2,
                      );
                  NavHelper.navigatePush(
                    AddScientificEventScreen(id: listAllScientific[k].id!),
                  );
                } else {
                  NavHelper.navigatePush(
                    ScientificEventDetailApprovalScreen(
                        id: listAllScientific[k].id!),
                  );
                }
              },
            ).addMarginBottom(12),
          );
        },
      );
    }
  }
}
