import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:clerkship/config/themes.dart';
import 'package:clerkship/r.dart';
import 'package:clerkship/ui/components/buttons/primary_button.dart';
import 'package:clerkship/ui/components/buttons/ripple_button.dart';
import 'package:clerkship/ui/components/commons/flat_card.dart';
import 'package:clerkship/ui/components/commons/primary_appbar.dart';
import 'package:clerkship/ui/components/commons/safe_statusbar.dart';
import 'package:clerkship/ui/components/modal/modal_confirmation.dart';
import 'package:clerkship/ui/screens/clinic_detail_approval/components/item_info_segment.dart';
import 'package:clerkship/ui/screens/scientific_event_detail_approval/components/other_info_segment.dart';
import 'package:clerkship/utils/dialog_helper.dart';
import 'package:clerkship/utils/nav_helper.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../data/network/entity/scientific_detail_response.dart';
import '../../../data/shared_providers/scientific_provider.dart';
import '../../../utils/tools.dart';
import '../clinic_detail_approval/components/item_file.dart';

class ScientificEventDetailApprovalScreen extends StatefulWidget {
  final int? id;
  const ScientificEventDetailApprovalScreen({super.key, required this.id});

  @override
  State<ScientificEventDetailApprovalScreen> createState() =>
      _ScientificEventDetailApprovalScreenState();
}

class _ScientificEventDetailApprovalScreenState
    extends State<ScientificEventDetailApprovalScreen> {
  bool loading = true;
  HeaderScientific headerData = HeaderScientific();
  ScientificDetailItem jenisKegiatan = ScientificDetailItem();
  List<ScientificDetailItem> listPenyakit = [];
  List<ScientificDetailItem> listProsedur = [];
  List<ScientificDocument> listDocument = [];
  String status = 'Waiting';
  Color backgroundColor = Themes.yellow;
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    Tools.onViewCreated(() async {
      loading = true;
      await context
          .read<ScientificActivityProvider>()
          .getDetailScientific(id: widget.id!);

      setState(() {
        loading = false;
        headerData =
            context.read<ScientificActivityProvider>().headerScientific;
        jenisKegiatan =
            context.read<ScientificActivityProvider>().jenisKegiatan;
        listDocument = context.read<ScientificActivityProvider>().listDocument;
        switch (headerData.status) {
          case 0:
            status = 'Proses';
            backgroundColor = Themes.blue;
            break;
          case 1:
            status = 'Diterima';
            backgroundColor = Themes.green;
            break;
          case 2:
            status = 'Waiting';
            backgroundColor = Themes.yellow;
            break;
          case 9:
            status = 'Ditolak';
            backgroundColor = Themes.red;
            break;
          default:
            status = 'Proses';
            backgroundColor = Themes.blue;
            break;
        }
      });
    });

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
  }

  @override
  Widget build(BuildContext context) {
    return SafeStatusBar(
      child: Scaffold(
        body: Column(
          children: [
            PrimaryAppBar(
              title: 'Kembali',
              action: RippleButton(
                onTap: headerData.status != 1 && !loading
                    ? () async {
                        DialogHelper.showModalConfirmation(
                          title: 'Konfirmasi Penghapusan',
                          message:
                              'Apakah anda benar-benar ingin\nmenghapus kegiatan ini?',
                          positiveText: 'Hapus',
                          type: ConfirmationType.horizontalButton,
                          onPositiveTap: () async {
                            NavHelper.pop();
                            await context
                                .read<ScientificActivityProvider>()
                                .deleteScientific(
                                    id: headerData.id!, context: context);
                          },
                        );
                      }
                    : () {
                        Fluttertoast.showToast(
                          msg: 'Kegiatan tidak dapat dihapus',
                        );
                      },
                padding: EdgeInsets.all(8.w),
                child: SvgPicture.asset(
                  AssetIcons.icDelete,
                  color: Themes.red,
                ),
              ),
            ),
            if (loading)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else
              SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlatCard(
                      color: Themes.greyBg,
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        children: [
                          Text(
                            jenisKegiatan.namaItem!,
                            style:
                                Themes().blackBold20?.withColor(Themes.content),
                          ).addMarginBottom(12),
                          Text(
                            DateFormat('dd MMMM yyyy')
                                .format(headerData.tanggal!),
                            style: Themes().gray12,
                          ).addMarginBottom(12),
                          FlatCard(
                            borderRadius: BorderRadius.circular(4),
                            padding: EdgeInsets.symmetric(
                              vertical: 6.w,
                              horizontal: 8.w,
                            ),
                            color: Themes.blue.withOpacity(0.2),
                            child: Text(
                              'Proses',
                              style:
                                  Themes().blackBold10?.withColor(Themes.blue),
                            ),
                          )
                        ],
                      ),
                    ).addMarginBottom(40),
                    ItemInfoSegment(
                      title: 'Tanggal',
                      value: DateFormat('dd MMMM yyyy')
                          .format(headerData.tanggal!),
                    ),
                    ItemInfoSegment(
                      title: 'Jam',
                      value: DateFormat('HH:mm').format(headerData.tanggal!),
                    ),
                    ItemInfoSegment(
                      title: 'Kegiatan',
                      value: jenisKegiatan.namaItem ?? '',
                    ),
                    ItemInfoSegment(
                      title: 'Peran',
                      value: headerData.namaPeran ?? '',
                    ),
                    ItemInfoSegment(
                      title: 'Departemen',
                      value: headerData.namaDepartment ?? '',
                    ),
                    ItemInfoSegment(
                      title: 'Pembimbing',
                      valueWidget: Row(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              AssetImages.avatar,
                              width: 24.w,
                              height: 24.w,
                              fit: BoxFit.cover,
                            ),
                          ).addMarginRight(8.w),
                          Text(
                            headerData.namaDokter ?? '',
                            style: Themes().blackBold12,
                          ),
                        ],
                      ),
                    ).addMarginBottom(20),
                    OtherInfoSegment(
                      title: 'Topik',
                      value: headerData.topik ?? '',
                    ).addMarginBottom(20),
                    Text(
                      'Catatan',
                      style: Themes().blackBold12?.withColor(Themes.hint),
                    ),
                    FleatherEditor(
                      readOnly: true,
                      controller: headerData.remarks != null
                          ? FleatherController(ParchmentDocument.fromJson(
                              jsonDecode(headerData.remarks!)))
                          : FleatherController(),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Themes.stroke,
                    ),
                    Visibility(
                      visible: listDocument.isNotEmpty,
                      child: Text(
                        'Attachment',
                        style: Themes().blackBold12?.withColor(Themes.hint),
                      ).addMarginBottom(8).addMarginTop(20),
                    ),
                    Column(
                      children: List.generate(
                        listDocument.length,
                        (index) => ItemFile(
                          onTap: () async {
                            if (await Permission.storage.request().isGranted) {
                              DialogHelper.showProgressDialog();
                              await FlutterDownloader.cancelAll();
                              await FlutterDownloader.enqueue(
                                url: listDocument[index].fileUrl!,
                                headers: {}, // optional: header send with url (auth token etc)
                                savedDir: '/storage/emulated/0/Download/',
                                showNotification:
                                    true, // show download progress in status bar (for Android)
                                openFileFromNotification:
                                    true, // click on notification to open downloaded file (for Android)
                              );
                            }
                          },
                          title: listDocument[index].fileName!,
                        ).addMarginBottom(12),
                      ),
                    ).addMarginBottom(8),
                    PrimaryButton(
                      onTap: () {
                        NavHelper.pop();
                      },
                      text: 'Kembali ke Menu',
                    ),
                  ],
                ),
              ).addExpanded,
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }
}
