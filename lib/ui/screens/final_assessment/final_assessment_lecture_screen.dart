import 'package:clerkship/ui/screens/final_assessment/providers/final_assessment_lecture_provider.dart';
import 'package:clerkship/ui/screens/final_assessment_detail/final_assessment_detail_screen.dart';
import 'package:clerkship/utils/nav_helper.dart';
import 'package:clerkship/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../r.dart';
import '../../components/buttons/ripple_button.dart';
import '../../components/commons/animated_item.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import 'components/item_student_assessment.dart';

class FinalAssessmentLectureScreen extends StatefulWidget {
  const FinalAssessmentLectureScreen({super.key});

  @override
  State<FinalAssessmentLectureScreen> createState() =>
      _FinalAssessmentLectureScreenState();
}

class _FinalAssessmentLectureScreenState
    extends State<FinalAssessmentLectureScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    Tools.onViewCreated(() {
      context.read<FinalAssessmentLectureProvider>().getScoring();
      context.read<FinalAssessmentLectureProvider>().getDoneScoring();
    });
  }

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
              bottom: 4.h,
              top: 14,
              left: 20.w,
            ),
            Text(
              'Rangkuman Penilaian',
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
                  Tab(text: 'Butuh Penilaian'),
                  Tab(text: 'Sudah Dinilai'),
                ],
                onTap: (index) => pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
              ),
            ).addMarginTop(12),
            PageView(
              controller: pageController,
              onPageChanged: (index) {
                tabController.animateTo(index);
                context
                    .read<FinalAssessmentLectureProvider>()
                    .setPageIndex(index);
              },
              children: const [
                ListWidget(pageIndex: 0),
                ListWidget(pageIndex: 1),
              ],
            ).addExpanded,
          ],
        ),
      ),
    );
  }
}

class ListWidget extends StatelessWidget {
  final int pageIndex;

  const ListWidget({
    super.key,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<FinalAssessmentLectureProvider>().loading;
    final doneLoading =
        context.watch<FinalAssessmentLectureProvider>().doneLoading;

    final currentLoading = pageIndex == 0 ? loading : doneLoading;
    final currentData = [
      context.watch<FinalAssessmentLectureProvider>().finalAssessments,
      context.watch<FinalAssessmentLectureProvider>().doneAssessments,
    ];

    return Column(
      children: [
        if (currentLoading)
          const Expanded(
            child: Center(child: CircularProgressIndicator()),
          )
        else
          ListView.builder(
            itemCount: currentData[pageIndex].length,
            padding: EdgeInsets.all(20.w),
            itemBuilder: (context, index) {
              final itemData = currentData[pageIndex][index];

              return AnimatedItem(
                index: index,
                child: ItemStudentAssessment(
                  data: itemData,
                  onTap: () {
                    if (itemData.status == null) return;
                    NavHelper.navigatePush(
                      FinalAssessmentDetailScreen(
                        rated: pageIndex == 1,
                        data: itemData,
                      ),
                    );
                  },
                ).addMarginBottom(12),
              );
            },
          ).addExpanded,
      ],
    );
  }
}
