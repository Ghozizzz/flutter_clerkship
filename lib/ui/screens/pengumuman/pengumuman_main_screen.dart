import 'package:clerkship/data/models/breadcrum_sk.dart';
import 'package:clerkship/ui/screens/pengumuman/pengumuman_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/shared_providers/standard_competency_provider.dart';
import '../../../r.dart';
import '../../../utils/nav_helper.dart';
import '../../components/buttons/ripple_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import '../../screens/standard_competency/components/item_standard.dart';

class PengumumanMainScreen extends StatelessWidget {
  const PengumumanMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final skList = context.watch<StandardCompetencyProvider>().skList;
    final isLoading =
        context.watch<StandardCompetencyProvider>().isloadingListSK;

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
              'Pengumuman',
              style: Themes().primaryBold20,
            ).addMarginOnly(
              right: 20.w,
              left: 20.w,
              bottom: 22,
            ),
            if (isLoading)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else
              ListView.builder(
                padding: EdgeInsets.all(20.w),
                itemCount: skList.length,
                itemBuilder: (context, index) {
                  return ItemStandard(
                    title: skList[index].namaBatch!,
                    onTap: () {
                      NavHelper.navigatePush(
                        PengumumanScreen(
                          breadcrumSK: BreadcrumSK(
                              id: skList[index].id!,
                              title: skList[index].namaBatch!),
                        ),
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
