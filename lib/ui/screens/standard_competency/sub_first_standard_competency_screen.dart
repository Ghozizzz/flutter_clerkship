import 'package:clerkship/ui/screens/standard_competency/sub_standard_competency_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/models/breadcrum_sk.dart';
import '../../../data/shared_providers/standard_competency_provider.dart';
import '../../../r.dart';
import '../../../utils/nav_helper.dart';
import '../../components/buttons/ripple_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import 'components/item_standard.dart';

class SubFirstStandardCompetencyScreen extends StatelessWidget {
  final BreadcrumSK breadcrumSK;
  const SubFirstStandardCompetencyScreen(
      {super.key, required this.breadcrumSK});

  @override
  Widget build(BuildContext context) {
    final skListJenis = context.watch<StandardCompetencyProvider>().skListJenis;
    final isLoadingJenis =
        context.watch<StandardCompetencyProvider>().isloadingListSKJenis;
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
            ),
            Text(
              breadcrumSK.title,
              style: Themes().blackBold10?.withColor(Themes.hint),
            ).addMarginOnly(
              top: 4,
              left: 20.w,
              bottom: 16,
            ),
            if (isLoadingJenis)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else
              ListView.builder(
                padding: EdgeInsets.all(20.w),
                itemCount: skListJenis.length,
                itemBuilder: (context, index) {
                  return ItemStandard(
                    title: skListJenis[index].namaJenis!,
                    onTap: () {
                      context.read<StandardCompetencyProvider>().getListSKGroup(
                            idJenisSK: '${skListJenis[index].id}',
                          );

                      NavHelper.navigatePush(
                        SubStandardCompetencyScreen(
                          breadcrumSK: breadcrumSK,
                          breadcrumSKJenis: BreadcrumSK(
                              id: skListJenis[index].id!,
                              title: skListJenis[index].namaJenis!),
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
