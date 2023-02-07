import 'package:clerkship/ui/screens/clinic_activity/providers/clinic_activity_lecture_provider.dart';
import 'package:clerkship/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../components/commons/animated_item.dart';
import '../../components/commons/primary_appbar.dart';
import 'components/filter_header.dart';
import 'components/footer_widget.dart';
import 'components/item_group_clinic_activity.dart';

class ClinicActivityLectureScreen extends StatefulWidget {
  const ClinicActivityLectureScreen({super.key});

  @override
  State<ClinicActivityLectureScreen> createState() =>
      _ClinicActivityLectureScreenState();
}

class _ClinicActivityLectureScreenState
    extends State<ClinicActivityLectureScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    Tools.onViewCreated(() {
      context.read<ClinicActivityLectureProvider>().getClinicActivities();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<ClinicActivityLectureProvider>().loading;
    final listData = [
      context.watch<ClinicActivityLectureProvider>().clinicActivities,
      context.watch<ClinicActivityLectureProvider>().ratedClinicActivities,
    ];
    final checkedId = context.watch<ClinicActivityLectureProvider>().checkedId;

    return Scaffold(
      body: Column(
        children: [
          const PrimaryAppBar(
            title: 'Kembali',
          ).addMarginBottom(12),
          const FilterHeader(),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            height: 38,
            child: TabBar(
              controller: tabController,
              labelColor: Themes.primary,
              unselectedLabelColor: Themes.hint,
              labelStyle: Themes().black12?.withFontWeight(FontWeight.w500),
              isScrollable: true,
              tabs: const [
                Tab(text: 'Butuh Penilaian'),
                Tab(text: 'Sudah Dinilai'),
              ],
            ),
          ).addMarginTop(20),
          TabBarView(
            controller: tabController,
            children: List.generate(
              2,
              (pageIndex) {
                final currentLoading = pageIndex == 0 ? loading : loading;

                return Column(
                  children: [
                    if (currentLoading)
                      const Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else
                      ListView.builder(
                        itemCount: listData[pageIndex].length,
                        padding: EdgeInsets.all(20.w),
                        itemBuilder: (context, index) {
                          final clinicActivities =
                              listData[pageIndex].entries.toList()[index];

                          return AnimatedItem(
                            index: index,
                            child: ItemGroupClinicActivity(
                              clinicActivities: clinicActivities,
                              rated: pageIndex == 1,
                            ),
                          ).addMarginBottom(20);
                        },
                      ).addExpanded,
                    if (pageIndex == 0)
                      const FooterWidget()
                          .animate(target: checkedId.isNotEmpty ? 0 : 1)
                          .slideY(
                            begin: 0,
                            end: 1,
                            duration: Duration(
                              milliseconds: checkedId.isNotEmpty ? 800 : 200,
                            ),
                            curve: checkedId.isNotEmpty
                                ? Curves.elasticIn
                                : Curves.easeIn,
                          )
                          .hide(
                            maintain: false,
                          ),
                  ],
                );
              },
            ),
          ).addExpanded,
        ],
      ),
    );
  }
}
