import 'package:clerkship/ui/screens/final_assessment_list/final_assessment_list_screen.dart';
import 'package:clerkship/utils/nav_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
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
              ),
            ).addMarginTop(12),
            TabBarView(
              controller: tabController,
              children: List.generate(
                2,
                (index) => ListView.builder(
                  itemCount: 12,
                  padding: EdgeInsets.all(20.w),
                  itemBuilder: (context, index) {
                    return AnimatedItem(
                      index: index,
                      child: ItemStudentAssessment(
                        onTap: () {
                          NavHelper.navigatePush(
                            const FinalAssessmentListScreen(),
                          );
                        },
                      ).addMarginBottom(12),
                    );
                  },
                ),
              ),
            ).addExpanded,
          ],
        ),
      ),
    );
  }
}
