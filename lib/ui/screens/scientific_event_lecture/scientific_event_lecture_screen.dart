import 'package:clerkship/ui/screens/scientific_event_lecture/components/item_scientific_event.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../components/commons/animated_item.dart';
import '../../components/commons/primary_appbar.dart';
import 'components/filter_header.dart';
import 'components/footer_widget.dart';

class ScientificEventLectureScreen extends StatefulWidget {
  const ScientificEventLectureScreen({super.key});

  @override
  State<ScientificEventLectureScreen> createState() =>
      _ScientificEventLectureScreenState();
}

class _ScientificEventLectureScreenState
    extends State<ScientificEventLectureScreen>
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
    return Scaffold(
      body: Column(
        children: [
          const PrimaryAppBar(
            title: 'Kembali',
          ).addMarginBottom(12),
          FilterHeader(),
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
              (pageIndex) => Column(
                children: [
                  ListView.builder(
                    itemCount: 12,
                    padding: EdgeInsets.all(20.w),
                    itemBuilder: (context, index) {
                      return AnimatedItem(
                        index: index,
                        child: ItemScientificEvent(
                          rated: pageIndex == 1,
                        ),
                      ).addMarginBottom(20);
                    },
                  ).addExpanded,
                  if (pageIndex == 0) FooterWidget(),
                ],
              ),
            ),
          ).addExpanded,
        ],
      ),
    );
  }
}
