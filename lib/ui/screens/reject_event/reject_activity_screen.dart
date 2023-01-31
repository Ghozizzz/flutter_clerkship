import 'package:clerkship/config/themes.dart';
import 'package:clerkship/r.dart';
import 'package:clerkship/ui/components/buttons/primary_button.dart';
import 'package:clerkship/ui/components/buttons/tertiary_button.dart';
import 'package:clerkship/ui/components/commons/flat_card.dart';
import 'package:clerkship/ui/screens/reject_event/components/item_event_rejection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../components/commons/primary_appbar.dart';

class RejectActivityScreen extends StatelessWidget {
  RejectActivityScreen({super.key});

  final reasonControllers =
      List.generate(8, (index) => TextEditingController());

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
                      Text(
                        'Silahkan isi semua alasan terlebih dahulu!',
                        style: Themes().primaryBold12,
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
                      reasonController: reasonControllers[index],
                    ).addMarginBottom(12);
                  },
                ).addMarginBottom(12),
                Row(
                  children: [
                    TertiaryButton(
                      onTap: () {},
                      text: 'Batal',
                    ).addExpanded,
                    Container(width: 12),
                    PrimaryButton(
                      onTap: () {},
                      text: 'Tolak',
                    ).addExpanded,
                  ],
                )
              ],
            ),
          ).addExpanded
        ],
      ),
    );
  }
}
