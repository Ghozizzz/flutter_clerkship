import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../data/network/entity/scientific_event_lecture_response.dart';
import '../../../../r.dart';
import '../../../../utils/dialog_helper.dart';
import '../../../../utils/extensions.dart';
import '../../../../utils/nav_helper.dart';
import '../../../components/buttons/primary_button.dart';
import '../../../components/buttons/ripple_button.dart';
import '../../../components/commons/flat_card.dart';
import '../../../components/commons/primary_checkbox.dart';
import '../../../components/modal/modal_confirmation.dart';
import '../../clinic_detail_approval/components/item_file.dart';
import '../../clinic_detail_approval/components/item_info_segment.dart';
import '../../scientific_event_review/scientific_event_review_screen.dart';
import '../providers/scientific_event_lecture_provider.dart';
import 'bullet_list.dart';
import 'notes_segment.dart';

class ItemEventLecture extends StatelessWidget {
  final bool rated;
  final bool showCheckbox;
  final ScientificEventData data;

  ItemEventLecture({
    super.key,
    required this.data,
    this.rated = false,
    this.showCheckbox = true,
  }) {
    checkboxController.value = data.checked;
  }

  final checkboxController = CheckboxController(false);
  final expandableController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    final header = data.header;
    final documents = data.document;
    final reviews = data.tinjauan;
    final checkedId = context.watch<ScientificEventLectureProvider>().checkedId;

    String status = '';
    Color statusColor = Themes.transparent;

    switch (header?.status) {
      case 0:
        status = 'Proses';
        statusColor = Themes.grey;
        break;
      case 1:
        status = 'Disetujui';
        statusColor = Themes.green;
        break;
      case 2:
        status = 'Menunggu';
        statusColor = Themes.orange;
        break;
      case 9:
        status = 'Ditolak';
        statusColor = Themes.red;
        break;
    }

    return FlatCard(
      padding: EdgeInsets.all(12.w),
      border: Border.all(color: Themes.stroke),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (rated)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatCard(
                  color: statusColor.withOpacity(0.1),
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.w,
                    vertical: 4,
                  ),
                  child: Text(
                    status,
                    style: Themes().primary14?.withColor(statusColor),
                  ),
                ),
                // RippleButton(
                //   onTap: () {
                //     NavHelper.navigatePush(
                //       const EditScientificEventReviewScreen(),
                //     );
                //   },
                //   padding: EdgeInsets.all(4.w),
                //   child: SvgPicture.asset(
                //     AssetIcons.icEdit,
                //     color: Themes.primary,
                //     width: 20.w,
                //   ),
                // ),
              ],
            ).addMarginBottom(12)
          else if (showCheckbox)
            PrimaryCheckbox(
              controller: checkboxController,
              checkBoxSize: Size(20.w, 20.w),
              unCheckColor: Themes.hint,
              strokeWidth: 2,
              onValueChange: (value) {
                data.checked = value;
                if (header == null) return;
                if (value) {
                  context
                      .read<ScientificEventLectureProvider>()
                      .addCheckId(header.id!);
                } else {
                  context
                      .read<ScientificEventLectureProvider>()
                      .removeCheckId(header.id!);
                }
              },
            ).addMarginBottom(12),
          Text(
            '${header?.namaKegiatan}',
            style: Themes().blackBold14?.withColor(Themes.black),
          ),
          if (rated)
            Column(
              children: [
                ItemInfoSegment(
                  title: 'Tanggal',
                  value: header?.tanggal?.formatDate('DD MMMM yyyy'),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                // ItemInfoSegment(
                //   title: 'Preseptor',
                //   padding: const EdgeInsets.symmetric(vertical: 12),
                //   valueWidget: Row(
                //     children: [
                //       ClipOval(
                //         child: Image.asset(
                //           AssetImages.avatar,
                //           width: 24.w,
                //           height: 24.w,
                //           fit: BoxFit.cover,
                //         ),
                //       ).addMarginRight(8.w),
                //       Text(
                //         'dr Budiman',
                //         style: Themes().blackBold12,
                //       ),
                //     ],
                //   ),
                // ),
                ItemInfoSegment(
                  title: 'Departemen',
                  value: '${header?.namaDepartment}',
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ).addMarginBottom(12),
              ],
            )
          else
            Column(
              children: [
                ItemInfoSegment(
                  title: 'Tanggal',
                  value: header?.tanggal?.formatDate('DD MMMM yyyy'),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                ItemInfoSegment(
                  title: 'Jam',
                  value: header?.tanggal?.formatDate('HH:mm'),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                ItemInfoSegment(
                  title: 'Peran',
                  value: '${header?.namaPeran}',
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                ItemInfoSegment(
                  title: 'Departemen',
                  value: '${header?.namaDepartment}',
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                // ItemInfoSegment(
                //   title: 'Preseptor',
                //   padding: const EdgeInsets.symmetric(vertical: 12),
                //   valueWidget: Row(
                //     children: [
                //       ClipOval(
                //         child: Image.asset(
                //           AssetImages.avatar,
                //           width: 24.w,
                //           height: 24.w,
                //           fit: BoxFit.cover,
                //         ),
                //       ).addMarginRight(8.w),
                //       Text(
                //         'dr Budiman',
                //         style: Themes().blackBold12,
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BulletList(
                title: 'Topik',
                listData: ['${header?.topik}'],
              ),
              NotesSegment(
                title: 'Catatan',
                body: '${header?.remarks}',
              ).addMarginBottom(20),
              if (data.document?.isNotEmpty ?? false)
                Text(
                  'Lampiran',
                  style: Themes().blackBold12?.withColor(Themes.hint),
                ).addMarginBottom(8),
              Column(
                children: (data.document ?? [])
                    .map((document) => ItemFile(
                          title: '${document.fileName}',
                          url: '${document.fileUrl}',
                          onTap: () => downloadFile(document),
                        ).addMarginBottom(12))
                    .toList(),
              ),
            ],
          ),
          if (!rated && checkedId.isEmpty)
            Row(
              children: [
                PrimaryButton(
                  onTap: () {
                    DialogHelper.showModalConfirmation(
                      title: 'Konfirmasi Penolakan',
                      message:
                          'Silakan masukkan alasan penolakan di bawah ini.',
                      type: ConfirmationType.withField,
                      labelField: 'Alasan Penolakan',
                      hintField: 'Masukkan Alasan Penolakan',
                      onPositiveTapWithField: (fieldValue) {
                        debugPrint(fieldValue);
                        Navigator.pop(context);
                      },
                    );
                  },
                  padding: EdgeInsets.all(10.w),
                  color: Themes.red,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetIcons.icClose,
                        color: Themes.white,
                        width: 24.w,
                      ).addMarginRight(8.w),
                      Text(
                        'Tolak',
                        style: Themes().whiteBold16,
                      )
                    ],
                  ),
                ).addExpanded,
                Container(
                  width: 8.w,
                ),
                PrimaryButton(
                  onTap: () {
                    DialogHelper.showModalConfirmation(
                      title: 'Konfirmasi Persetujuan',
                      message:
                          'Apakah anda yakin ingin menyetujui catatan ini?',
                      type: ConfirmationType.withField,
                      labelField: 'Masukan',
                      hintField: 'Masukkan Alasan Penolakan',
                      optionalField: true,
                      onPositiveTapWithField: (fieldValue) {
                        Navigator.pop(context);
                        NavHelper.navigatePush(ScientificEventReviewScreen());
                      },
                    );
                  },
                  padding: EdgeInsets.all(10.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetIcons.icCheck,
                        color: Themes.white,
                        width: 24.w,
                      ).addMarginRight(8.w),
                      Text(
                        'Setujui',
                        style: Themes().whiteBold16,
                      )
                    ],
                  ),
                ).addExpanded,
              ],
            ),
          if (rated)
            ValueListenableBuilder(
              valueListenable: expandableController,
              builder: (context, expanded, __) {
                return FlatCard(
                  color: Themes.greyBg,
                  border: Border.all(color: Themes.stroke),
                  child: ExpandablePanel(
                    controller: expandableController,
                    header: RippleButton(
                      onTap: () {
                        expandableController.toggle();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lihat Tinjauan',
                            style: Themes().black12,
                          ),
                          SvgPicture.asset(
                            AssetIcons.icChevronDown,
                          ).animate(target: expanded ? 0.5 : 0).rotate(),
                        ],
                      ),
                    ),
                    collapsed: Container(),
                    expanded: Column(
                      children: const [
                        ItemInfoSegment(
                          title:
                              'Patient Demographic Information (age, gender, social information)',
                          value: 'P',
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        ItemInfoSegment(
                          title: 'History Taking - Presenting complaints',
                          value: 'P',
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        ItemInfoSegment(
                          title: 'History Taking -	Past history',
                          value: 'F',
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        ItemInfoSegment(
                          title: 'History Taking -	Family history',
                          value: 'P',
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        ItemInfoSegment(
                          title: 'History Taking -	Family history',
                          value: 'P-',
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        ItemInfoSegment(
                          title: 'History Taking -	Other',
                          value: 'P-',
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        ItemInfoSegment(
                          title: 'General physical examination',
                          value: 'P-',
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        ItemInfoSegment(
                          title:
                              'Investigations needed to support diagnosis and expected results',
                          value: 'P-',
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        ItemInfoSegment(
                          title: 'Summary',
                          value: 'P-',
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ],
                    ).addSymmetricMargin(horizontal: 12.w),
                    theme: const ExpandableThemeData(
                      hasIcon: false,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  void downloadFile(Document? document) async {
    if (await Permission.storage.request().isGranted) {
      if (document?.fileUrl == null) return;
      String fileName = document?.fileName ?? '';
      final currentFile =
          File('/storage/emulated/0/Download/${document?.fileName}');

      if ((await currentFile.exists())) {
        await currentFile.delete();
      }

      DialogHelper.showProgressDialog();
      await FlutterDownloader.cancelAll();
      await FlutterDownloader.enqueue(
        url: document?.fileUrl ?? '',
        fileName: fileName,
        headers: {},
        savedDir: '/storage/emulated/0/Download/',
        showNotification: true,
        openFileFromNotification: true,
      );
    }
  }
}
