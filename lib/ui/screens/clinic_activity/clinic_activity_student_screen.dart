import 'package:clerkship/ui/screens/clinic_activity/components/filter_header_student.dart';
import 'package:clerkship/ui/screens/clinic_activity/components/item_list_all.dart';
import 'package:clerkship/ui/screens/clinic_activity/components/item_list_draft.dart';
import 'package:clerkship/ui/screens/clinic_activity/providers/item_list_all_provider.dart';
import 'package:clerkship/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/shared_providers/reference_provider.dart';
import '../../../r.dart';
import '../../../utils/nav_helper.dart';
import '../../components/buttons/ripple_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import '../add_clinic_activity/add_clinic_activity_screen.dart';
import 'components/item_list_approve.dart';
import 'components/item_list_reject.dart';
import 'components/item_list_waiting.dart';

class ClinicActivityStudentScreen extends StatefulWidget {
  const ClinicActivityStudentScreen({super.key});

  @override
  State<ClinicActivityStudentScreen> createState() =>
      _ClinicActivityStudentScreenState();
}

class _ClinicActivityStudentScreenState
    extends State<ClinicActivityStudentScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 5,
      vsync: this,
    );

    Tools.onViewCreated(() {
      context.read<ReferenceProvider>().getFilterKegiatanStudent(idFlow: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final batch = context.watch<ItemListAllClinicProvider>().batch;
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
              'Kegiatan Klinik',
              style: Themes().primaryBold20,
            ).addMarginOnly(
              bottom: 4.h,
              top: 14,
              left: 20.w,
            ),
            Text(
              'Batch $batch',
              style: Themes().gray10?.boldText(),
            ).addMarginLeft(20.w),
            const FilterHeaderStudent().addMarginTop(12),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              height: 38,
              child: TabBar(
                controller: tabController,
                labelColor: Themes.primary,
                unselectedLabelColor: Themes.hint,
                labelStyle: Themes().black12?.withFontWeight(FontWeight.w500),
                isScrollable: true,
                tabs: const [
                  Tab(text: 'Semua'),
                  Tab(text: 'Proses'),
                  Tab(text: 'Diterima'),
                  Tab(text: 'Ditolak'),
                  Tab(text: 'Menunggu'),
                ],
              ),
            ).addMarginTop(12),
            Stack(
              children: [
                TabBarView(controller: tabController, children: const [
                  ListItemAllClinic(),
                  ListItemDraftClinic(),
                  ListItemApproveClinic(),
                  ListItemRejectClinic(),
                  ListItemWaitingClinic(),
                ]),
                Positioned(
                  right: 20.w,
                  bottom: 20.w,
                  child: FloatingActionButton(
                    onPressed: () {
                      context.read<ReferenceProvider>().getBatch(idFlow: 1);
                      NavHelper.navigatePush(const AddClinicActivityScreen());
                    },
                    child: SvgPicture.asset(AssetIcons.icPlus),
                  ),
                )
              ],
            ).addExpanded,
          ],
        ),
      ),
    );
  }
}
