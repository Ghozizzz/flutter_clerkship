import 'package:clerkship/ui/screens/standard_competency/sub_standard_competency_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../r.dart';
import '../../../utils/nav_helper.dart';
import '../../components/buttons/ripple_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import 'components/item_standard.dart';

class StandardCompetencyScreen extends StatelessWidget {
  const StandardCompetencyScreen({super.key});

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
              'Standar Kompetensi',
              style: Themes().primaryBold20,
            ).addMarginOnly(
              right: 20.w,
              left: 20.w,
              bottom: 22,
            ),
            ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: 24,
              itemBuilder: (context, index) {
                return ItemStandard(
                  onTap: () {
                    NavHelper.navigatePush(
                      const SubStandardCompetencyScreen(),
                    );
                  },
                ).addMarginBottom(12);
              },
            ).addExpanded
          ],
        ),
      ),
    );
  }
}
