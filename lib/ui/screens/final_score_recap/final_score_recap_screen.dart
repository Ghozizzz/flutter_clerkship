import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:clerkship/config/themes.dart';
import 'package:clerkship/r.dart';
import 'package:clerkship/ui/components/buttons/ripple_button.dart';
import 'package:clerkship/ui/components/commons/flat_card.dart';
import 'package:clerkship/ui/components/commons/primary_appbar.dart';
import 'package:clerkship/ui/screens/final_score_recap/provider/final_score_recap_provider.dart';
import 'package:clerkship/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../data/network/entity/scoring_response.dart';
import '../../../utils/dialog_helper.dart';
import 'components/item_score.dart';
import 'components/score_recap_header.dart';

class FinalScoreRecapScreen extends StatefulWidget {
  final ScoringData data;
  const FinalScoreRecapScreen({super.key, required this.data});

  @override
  State<FinalScoreRecapScreen> createState() => _FinalScoreRecapScreenState();
}

class _FinalScoreRecapScreenState extends State<FinalScoreRecapScreen> {
  final ReceivePort _port = ReceivePort();

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Tools.onViewCreated(() {
      registerDownloadCallback();
      if (widget.data.id == null) return;
      context.read<FinalScoreRecapProvider>().getScoringRecap(widget.data.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final detailData = context.watch<FinalScoreRecapProvider>().detailData;
    final document = context.watch<FinalScoreRecapProvider>().document;

    return Scaffold(
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
          const ScoreRecapHeader(),
          ListView.builder(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              bottom: 20.w,
            ),
            itemCount: detailData.length,
            itemBuilder: (context, index) {
              final detail = detailData[index];
              return ItemScore(data: detail).addMarginTop(20);
            },
          ).addExpanded,
          Container(
            width: double.infinity,
            height: 1,
            color: Themes.stroke,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Validasi Kelulusan',
                style: Themes().blackBold12?.withColor(Themes.hint),
              ).addMarginBottom(8),
              FlatCard(
                padding: EdgeInsets.all(8.w),
                border: Border.all(color: Themes.stroke),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'dokumen-validasi.pdf',
                      style: Themes().black12?.withUnderline(offset: 2),
                    ).addMarginLeft(8.w),
                    RippleButton(
                      onTap: () {
                        if (document == null) return;
                        downloadFile(document);
                      },
                      padding: EdgeInsets.all(8.w),
                      child: SvgPicture.asset(
                        AssetIcons.icDownload,
                        color: Themes.primary,
                        width: 20.w,
                        height: 20.w,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ).addAllPadding(20.w),
        ],
      ),
    );
  }

  void downloadFile(String url) async {
    if (await Permission.storage.request().isGranted) {
      String fileName = url.split('/').last;
      final currentFile = File('/storage/emulated/0/Download/$fileName');

      if ((await currentFile.exists())) {
        await currentFile.delete();
      }

      DialogHelper.showProgressDialog();
      await FlutterDownloader.cancelAll();
      await FlutterDownloader.enqueue(
        url: url,
        fileName: fileName,
        headers: {},
        savedDir: '/storage/emulated/0/Download/',
        showNotification: true,
        openFileFromNotification: true,
      );
    }
  }

  void registerDownloadCallback() {
    IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );
    _port.listen((dynamic data) {
      String taskId = data[0];
      int status = data[1];
      if (status == 3) {
        DialogHelper.closeDialog();
        Fluttertoast.showToast(
          msg: 'Download selesai',
        );
        FlutterDownloader.remove(taskId: taskId, shouldDeleteContent: false);
      } else if (status == 4) {
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
    send?.send([id, status.value, progress]);
  }
}
