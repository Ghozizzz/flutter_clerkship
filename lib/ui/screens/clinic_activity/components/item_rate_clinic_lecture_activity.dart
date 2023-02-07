import 'package:clerkship/ui/screens/clinic_activity/providers/item_list_all_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../components/commons/animated_item.dart';
import '../../scientific_event/components/footer_widget.dart';
import '../providers/item_rate_clinic_lecuture_provider.dart';
import 'item_group_clinic_activity.dart';

class ListItemRateClinicLecture extends StatelessWidget {
  const ListItemRateClinicLecture({super.key});

  @override
  Widget build(BuildContext context) {
    final listData = context.watch<ItemListRateClinicLectureProvider>().data;
    final loading = context.watch<ItemListAllClinicProvider>().loading;

    if (loading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Column(
        children: [
          ListView.builder(
            itemCount: listData.length,
            padding: EdgeInsets.all(20.w),
            itemBuilder: (context, index) {
              return AnimatedItem(
                index: index,
                child: ItemGroupClinicActivity(
                  rated: true,
                  data: listData[index],
                ),
              ).addMarginBottom(20);
            },
          ).addExpanded,
          FooterWidget(),
        ],
      );
    }
  }
}
