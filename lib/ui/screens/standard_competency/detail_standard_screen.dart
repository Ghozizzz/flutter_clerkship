import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/models/breadcrum_sk.dart';
import '../../../data/shared_providers/standard_competency_provider.dart';
import '../../../r.dart';
import '../../components/buttons/ripple_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import '../standard_competency/components/item_standard_total.dart';

class DetailStandardCompetencyScreen extends StatelessWidget {
  final BreadcrumSK breadcrumSK;
  final BreadcrumSK breadcrumSKJenis;
  final BreadcrumSK breadcrumSKGroup;
  const DetailStandardCompetencyScreen(
      {super.key,
      required this.breadcrumSK,
      required this.breadcrumSKJenis,
      required this.breadcrumSKGroup});

  @override
  Widget build(BuildContext context) {
    final skListGroupDetail =
        context.watch<StandardCompetencyProvider>().skListGroupDetail;
    final isLoadingGroupDetail =
        context.watch<StandardCompetencyProvider>().isloadingListSKGroupDetail;

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
                // child: SvgPicture.asset(
                //   AssetIcons.icSearch,
                //   width: 18.w,
                //   height: 18.w,
                // ),
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
              '${breadcrumSK.title} > ${breadcrumSKJenis.title} > ${breadcrumSKGroup.title}',
              style: Themes().blackBold10?.withColor(Themes.hint),
            ).addMarginOnly(
              top: 4,
              left: 20.w,
              bottom: 16,
            ),
            if (isLoadingGroupDetail)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else
              ListView.builder(
                padding: EdgeInsets.all(20.w),
                itemCount: skListGroupDetail.length,
                itemBuilder: (context, index) {
                  return ItemStandardTotal(
                    title: skListGroupDetail[index].name!,
                    total: skListGroupDetail[index].jumlah!,
                  ).addMarginBottom(12);
                },
              ).addExpanded
          ],
        ),
      ),
    );
  }
}
