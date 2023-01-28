import 'package:clerkship/config/themes.dart';
import 'package:clerkship/ui/components/commons/flat_card.dart';
import 'package:clerkship/ui/components/textareas/textarea.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../clinic_detail_approval/components/item_info_segment.dart';

class ItemEventRejection extends StatelessWidget {
  final TextEditingController reasonController;

  const ItemEventRejection({
    super.key,
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
          'Mini-CEX'.textBold14,
          const ItemInfoSegment(
            title: 'Tanggal',
            value: '10 August 2022',
            padding: EdgeInsets.symmetric(vertical: 12),
          ),
          const ItemInfoSegment(
            title: 'Jam',
            value: '9.00',
            padding: EdgeInsets.symmetric(vertical: 12),
          ).addMarginBottom(12),
          const ItemInfoSegment(
            title: 'Peran',
            value: 'Hadirin Acara',
            padding: EdgeInsets.symmetric(vertical: 12),
          ).addMarginBottom(12),
          const ItemInfoSegment(
            title: 'Departemen',
            value: 'Ilmu Penyakit Dalam',
            padding: EdgeInsets.symmetric(vertical: 12),
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
