import 'dart:isolate';
import 'dart:ui';

import 'package:clerkship/ui/screens/scientific_event/components/item_event_lecture.dart';
import 'package:clerkship/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/network/entity/scientifc_event_participant_response.dart';
import '../../../data/shared_providers/reference_provider.dart';
import '../../../utils/dialog_helper.dart';
import '../../components/commons/animated_item.dart';
import '../../components/commons/primary_appbar.dart';
import 'components/filter_header.dart';
import 'components/footer_widget.dart';
import 'providers/scientific_event_lecture_provider.dart';

class ScientificEventLectureScreen extends StatefulWidget {
  final ScientificEventParticipant participant;

  const ScientificEventLectureScreen({
    super.key,
    required this.participant,
  });

  @override
  State<ScientificEventLectureScreen> createState() =>
      _ScientificEventLectureScreenState();
}

class _ScientificEventLectureScreenState
    extends State<ScientificEventLectureScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final pageController = PageController();
  final ReceivePort _port = ReceivePort();

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    Tools.onViewCreated(() {
      registerDownloadCallback();
      context.read<ScientificEventLectureProvider>().reset();
      context.read<ReferenceProvider>().getFilterKegiatan();
      if (widget.participant.idUser != null) {
        context
            .read<ScientificEventLectureProvider>()
            .getScientificEvent(idUser: widget.participant.idUser!);
        context
            .read<ScientificEventLectureProvider>()
            .getRatedScientificEvent(idUser: widget.participant.idUser!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scientificEventProvider =
        context.watch<ScientificEventLectureProvider>();

    final checkedId = scientificEventProvider.checkedId;
    final pageIndex = scientificEventProvider.pageIndex;
    final showFooter = checkedId.isNotEmpty && pageIndex == 0;

    return Scaffold(
      body: Column(
        children: [
          const PrimaryAppBar(
            title: 'Kembali',
          ).addMarginBottom(12),
          FilterHeader(
            participant: widget.participant,
          ),
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
              context
                  .read<ScientificEventLectureProvider>()
                  .setPageIndex(index);
            },
            children: const [
              ListWIdget(pageIndex: 0),
              ListWIdget(pageIndex: 1),
            ],
          ).addExpanded,
          FooterWidget(
            onTap: (checkAll) => context
                .read<ScientificEventLectureProvider>()
                .toggleCheckAll(checkAll),
          )
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
      _port.sendPort,
      'downloader_send_port',
    );
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

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    DownloadTaskStatus status,
    int progress,
  ) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }
}

class ListWIdget extends StatelessWidget {
  final int pageIndex;

  const ListWIdget({
    super.key,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    final scientificEventProvider =
        context.watch<ScientificEventLectureProvider>();
    final loading = scientificEventProvider.loading;
    final loadingRated = scientificEventProvider.loadingRated;
    final currentLoading = pageIndex == 0 ? loading : loadingRated;
    final listData = [
      scientificEventProvider.scientificEvents,
      scientificEventProvider.ratedScientificEvents,
    ];

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
              final scientificEvent = listData[pageIndex][index];

              return AnimatedItem(
                index: index,
                child: ItemEventLecture(
                  data: scientificEvent,
                  rated: pageIndex == 1,
                ),
              ).addMarginBottom(20);
            },
          ).addExpanded,
      ],
    );
  }
}
