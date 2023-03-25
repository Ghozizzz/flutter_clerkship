import 'package:clerkship/config/themes.dart';
import 'package:clerkship/data/network/entity/clinic_lecture_response.dart';
import 'package:clerkship/ui/components/commons/flat_card.dart';
import 'package:clerkship/ui/components/textareas/textarea.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../clinic_detail_approval/components/item_info_segment.dart';

class ItemActivityRejection extends StatelessWidget {
  final ActivityData data;
  final TextEditingController reasonController;

  const ItemActivityRejection({
    super.key,
    required this.data,
    required this.reasonController,
  });

  @override
  Widget build(BuildContext context) {
    final header = data.header;

    return FlatCard(
      border: Border.all(color: Themes.stroke),
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (header?.namaKegiatan ?? '').textBold14,
          ItemInfoSegment(
            title: 'Mahasiswa',
            value: header?.namaStudent ?? '',
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          ItemInfoSegment(
            title: 'Departemen',
            value: header?.namaDepartment ?? '',
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
