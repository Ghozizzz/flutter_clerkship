import 'package:clerkship/ui/components/commons/animated_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../r.dart';
import '../../components/buttons/ripple_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import 'components/item_assessment.dart';

class FinalAssessmentScreen extends StatelessWidget {
  const FinalAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeStatusBar(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryAppBar(
              title: 'Kembali',
              action: RippleButton(
                onTap: () {},
                padding: EdgeInsets.all(4.w),
                child: SvgPicture.asset(
                  AssetIcons.icSearch,
                  width: 18.w,
                  height: 18.w,
                ),
              ),
            ),
            Text(
              'Penilaian Akhir',
              style: Themes().primaryBold20,
            ).addMarginOnly(
              top: 20.w,
              right: 20.w,
              left: 20.w,
            ),
            Text(
              'Rangkuman Penilaian',
              style: Themes().black10?.withColor(Themes.grey),
            ).addMarginOnly(
              top: 4,
              left: 20.w,
              bottom: 16,
            ),
            ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: 24,
              itemBuilder: (context, index) {
                return const AnimatedItem(
                  child: ItemAssessment(),
                );
              },
            ).addExpanded
          ],
        ),
      ),
    );
  }
}
