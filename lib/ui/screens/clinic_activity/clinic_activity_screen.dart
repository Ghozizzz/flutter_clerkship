import 'package:clerkship/config/themes.dart';
import 'package:clerkship/r.dart';
import 'package:clerkship/ui/components/buttons/ripple_button.dart';
import 'package:clerkship/ui/components/commons/animated_item.dart';
import 'package:clerkship/ui/components/commons/primary_appbar.dart';
import 'package:clerkship/ui/components/commons/safe_statusbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import 'components/item_activity.dart';

class ClinicActivityScreen extends StatefulWidget {
  const ClinicActivityScreen({super.key});

  @override
  State<ClinicActivityScreen> createState() => _ClinicActivityScreenState();
}

class _ClinicActivityScreenState extends State<ClinicActivityScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 4,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeStatusBar(
      lightIcon: true,
      statusBarColor: Themes.primary,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryAppBar(
              title: 'Back',
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
              'Kegiatan Klinik',
              style: Themes().primaryBold20,
            ).addMarginOnly(
              bottom: 4.h,
              top: 14,
              left: 20.w,
            ),
            Text(
              'Batch I',
              style: Themes().gray10?.boldText(),
            ).addMarginLeft(20.w),
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
                ],
              ),
            ).addMarginTop(12),
            Stack(
              children: [
                TabBarView(
                  controller: tabController,
                  children: List.generate(
                    4,
                    (index) => ListView.builder(
                      itemCount: 12,
                      padding: EdgeInsets.all(20.w),
                      itemBuilder: (context, index) {
                        return AnimatedItem(
                          index: index,
                          child: const ItemActivity().addMarginBottom(12),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  right: 20.w,
                  bottom: 20.w,
                  child: FloatingActionButton(
                    onPressed: () {},
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