import 'package:clerkship/config/themes.dart';
import 'package:clerkship/r.dart';
import 'package:clerkship/ui/components/buttons/primary_button.dart';
import 'package:clerkship/ui/components/buttons/tertiary_button.dart';
import 'package:clerkship/ui/components/commons/flat_card.dart';
import 'package:clerkship/ui/screens/reject_event/components/item_event_rejection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../data/models/key_value_data.dart';
import '../../../data/network/entity/scientific_event_lecture_response.dart';
import '../../../utils/nav_helper.dart';
import '../../components/commons/primary_appbar.dart';
import '../scientific_event/providers/scientific_event_lecture_provider.dart';

class RejectEventScreen extends StatefulWidget {
  final List<ScientificEventData> data;

  const RejectEventScreen({
    super.key,
    required this.data,
  });

  @override
  State<RejectEventScreen> createState() => _RejectEventScreenState();
}

class _RejectEventScreenState extends State<RejectEventScreen> {
  late final reasonControllers =
      List.generate(widget.data.length, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PrimaryAppBar(
            title: 'Kembali',
          ).addMarginBottom(12),
          SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tolak Semua',
                  style: Themes().primaryBold20,
                ).addMarginBottom(12),
                FlatCard(
                  color: Themes.primary.withOpacity(0.1),
                  padding: EdgeInsets.all(12.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AssetIcons.icAlert,
                        width: 20.w,
                      ).addMarginRight(10.w),
                      Expanded(
                        child: Text(
                          'Silahkan isi semua alasan terlebih dahulu!',
                          style: Themes().primaryBold12,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ).addPaddingBottom(20),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  primary: true,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: reasonControllers.length,
                  itemBuilder: (context, index) {
                    return ItemEventRejection(
                      data: widget.data[index],
                      reasonController: reasonControllers[index],
                    ).addMarginBottom(12);
                  },
                ).addMarginBottom(12),
                Row(
                  children: [
                    TertiaryButton(
                      onTap: () => NavHelper.pop(),
                      text: 'Batal',
                    ).addExpanded,
                    Container(width: 12),
                    MultiValueListenableBuilder(
                      valueListenables: reasonControllers,
                      builder: (context, _, __) {
                        return PrimaryButton(
                          enable: isValidForm(),
                          onTap: () => rejectAllActivity(context),
                          text: 'Tolak',
                        ).addExpanded;
                      },
                    ),
                  ],
                )
              ],
            ),
          ).addExpanded
        ],
      ),
    );
  }

  void rejectAllActivity(BuildContext context) {
    final keyValues = <KeyValueData>[];

    for (int i = 0; i < widget.data.length; i++) {
      final headerId = widget.data[i].header?.id;

      if (headerId != null) {
        keyValues.add(KeyValueData(
          id: '$headerId',
          reason: reasonControllers[i].text,
        ));
      }
    }

    context.read<ScientificEventLectureProvider>().rejectEvent(
      keyValues,
      onFinish: (success) {
        if (success) {
          NavHelper.pop();
        }
      },
    );
  }

  bool isValidForm() {
    final isValidForm = List.generate(reasonControllers.length,
        (index) => reasonControllers[index].text.isNotEmpty);
    return !isValidForm.contains(false);
  }
}
