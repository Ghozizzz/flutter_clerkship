import 'dart:isolate';
import 'dart:ui';

import 'package:clerkship/ui/screens/clinic_activity/providers/clinic_activity_lecture_provider.dart';
import 'package:clerkship/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../utils/dialog_helper.dart';
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
  final pageController = PageController();
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    Tools.onViewCreated(() {
      registerDownloadCallback();
      context
          .read<ClinicActivityLectureProvider>()
          .activityFilterController
          .resetValue();
      context.read<ClinicActivityLectureProvider>().dateController.resetValue();
      context.read<ClinicActivityLectureProvider>().getClinicActivities();
      context.read<ClinicActivityLectureProvider>().getRatedClinicActivities();
    });
  }

  @override
  Widget build(BuildContext context) {
    final clinicActivityProvider =
        context.watch<ClinicActivityLectureProvider>();

    final loading = clinicActivityProvider.loading;
    final listData = [
      clinicActivityProvider.clinicActivities,
      clinicActivityProvider.ratedClinicActivities,
    ];
    final checkedId = clinicActivityProvider.checkedId;
    final pageIndex = clinicActivityProvider.pageIndex;
    final showFooter = checkedId.isNotEmpty && pageIndex == 0;

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
              onTap: (index) {
                pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ).addMarginTop(20),
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              tabController.animateTo(index);
              context.read<ClinicActivityLectureProvider>().setPageIndex(index);
            },
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
                  ],
                );
              },
            ),
          ).addExpanded,
          const FooterWidget()
              .animate(
                target: showFooter ? 0 : 1,
              )
              .slideY(
                begin: 0,
                end: 1,
                duration: Duration(
                  milliseconds: showFooter ? 800 : 200,
                ),
                curve: showFooter ? Curves.elasticIn : Curves.easeIn,
              )
              .hide(
                maintain: false,
              ),
        ],
      ),
    );
  }

  void registerDownloadCallback() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String taskId = data[0];
      DownloadTaskStatus status = data[1];
      // int progress = data[2];
      if (status == DownloadTaskStatus.complete) {
        DialogHelper.closeDialog();
        Fluttertoast.showToast(
          msg: 'Download selesai',
        );
        FlutterDownloader.remove(taskId: taskId, shouldDeleteContent: false);
      } else if (status == DownloadTaskStatus.failed) {
        DialogHelper.closeDialog();
        Fluttertoast.showToast(
          msg: 'Download gagal',
        );
        FlutterDownloader.remove(taskId: taskId, shouldDeleteContent: false);
      }
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }
}
