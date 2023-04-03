import 'package:clerkship/config/themes.dart';
import 'package:clerkship/ui/components/commons/flat_card.dart';
import 'package:clerkship/ui/components/textareas/textarea.dart';
import 'package:clerkship/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../data/network/entity/scientific_event_lecture_response.dart';
import '../../clinic_detail_approval/components/item_info_segment.dart';

class ItemEventRejection extends StatelessWidget {
  final ScientificEventData data;
  final TextEditingController reasonController;

  const ItemEventRejection({
    super.key,
    required this.data,
    required this.reasonController,
  });

  @override
  Widget build(BuildContext context) {
    return FlatCard(
      border: Border.all(color: Themes.stroke),
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '${data.header?.namaKegiatan}'.textBold14,
          ItemInfoSegment(
            title: 'Tanggal',
            value: data.header?.tanggal?.formatDate('dd MMMM yyyy'),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          ItemInfoSegment(
            title: 'Jam',
            value: data.header?.tanggal?.formatDate('HH:mm'),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ).addMarginBottom(12),
          ItemInfoSegment(
            title: 'Peran',
            value: '${data.header?.namaPeran}',
            padding: const EdgeInsets.symmetric(vertical: 12),
          ).addMarginBottom(12),
          ItemInfoSegment(
            title: 'Departemen',
            value: '${data.header?.namaDepartment}',
            padding: const EdgeInsets.symmetric(vertical: 12),
          ).addMarginBottom(12),
          'Alasan Penolakan'.textBold12.addMarginBottom(8),
          TextArea(
            controller: reasonController,
            hint: 'Masukkan Alasan Penolakan',
          ),
        ],
      ),
    );
  }
}
