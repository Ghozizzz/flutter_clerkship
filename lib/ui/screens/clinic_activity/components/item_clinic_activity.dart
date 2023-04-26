import 'dart:io';
import 'dart:math';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../data/models/key_value_data.dart';
import '../../../../data/network/entity/clinic_lecture_response.dart';
import '../../../../r.dart';
import '../../../../utils/dialog_helper.dart';
import '../../../../utils/nav_helper.dart';
import '../../../components/buttons/primary_button.dart';
import '../../../components/buttons/ripple_button.dart';
import '../../../components/commons/flat_card.dart';
import '../../../components/commons/primary_checkbox.dart';
import '../../../components/modal/modal_confirmation.dart';
import '../../clinic_detail_approval/components/item_file.dart';
import '../../clinic_detail_approval/components/item_info_segment.dart';
import '../../mini_cex_approval/mini_cex_approval_screen.dart';
import '../../scientific_event_approval/scientific_event_approval_screen.dart';
import '../providers/clinic_activity_lecture_provider.dart';
import 'bullet_list.dart';
import 'item_review_segment.dart';
import 'notes_segment.dart';
import '../../../../utils/extensions.dart';

class ItemClinicActivity extends StatelessWidget {
  final bool rated;
  final ActivityData data;

  ItemClinicActivity({
    super.key,
    required this.data,
    this.rated = false,
  }) {
    expandableController.expanded = rated;
    checkboxController.value = data.checked;
  }

  final checkboxController = CheckboxController(false);
  final expandableController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    final header = data.header;
    final details = data.detail;
    final documents = data.document;
    final reviews = data.tinjauan;
    final Map<String, List<String>> detail = {};
    final checkedId = context.watch<ClinicActivityLectureProvider>().checkedId;
    final isMiniCex = data.header?.isMinicex == 1;
    final isForm = data.header?.isForm ?? 0;

    for (Detail detalBody in details ?? []) {
      if (detalBody.namaJenis != null && detalBody.namaItem != null) {
        if (detail.containsKey(detalBody.namaJenis)) {
          detail[detalBody.namaJenis!]!.add(detalBody.namaItem!);
        } else {
          detail[detalBody.namaJenis!] = [detalBody.namaItem!];
        }
      }
    }

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
                //   onTap: () {},
                //   padding: EdgeInsets.all(4.w),
                //   child: SvgPicture.asset(
                //     AssetIcons.icEdit,
                //     color: Themes.primary,
                //     width: 20.w,
                //   ),
                // ),
              ],
            ).addMarginBottom(12)
          else if (isForm == 0)
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
                      .read<ClinicActivityLectureProvider>()
                      .addCheckId(header.id!);
                } else {
                  context
                      .read<ClinicActivityLectureProvider>()
                      .removeCheckId(header.id!);
                }
              },
            ),
          Text(
            header?.namaKegiatan ?? '',
            style: Themes().blackBold14?.withColor(Themes.black),
          ).addMarginTop(12),
          if (rated)
            Column(
              children: [
                ItemInfoSegment(
                  title: 'Tanggal',
                  value: header?.tanggal?.formatDate('dd MMMM yyyy') ?? '',
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
                  value: header?.namaDepartment ?? '',
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                ItemInfoSegment(
                  title: 'Batch',
                  value: header?.namaBatch ?? '',
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ).addMarginBottom(12),
              ],
            )
          else
            Column(
              children: [
                ItemInfoSegment(
                  title: 'Mahasiswa',
                  value: header?.namaStudent ?? '',
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                ItemInfoSegment(
                  title: 'Departemen',
                  value: header?.namaDepartment ?? '',
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                ItemInfoSegment(
                  title: 'Batch',
                  value: header?.namaBatch ?? '',
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ).addMarginBottom(12),
              ],
            ),
          ValueListenableBuilder(
            valueListenable: expandableController,
            builder: (context, value, _) {
              return ExpandablePanel(
                controller: expandableController,
                collapsed: RippleButton(
                  onTap: () {
                    expandableController.toggle();
                  },
                  color: Themes.transparent,
                  padding: EdgeInsets.all(12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AssetIcons.icChevronDown)
                          .addMarginRight(8.w),
                      Text(
                        'Lihat Detail',
                        style: Themes().black12,
                      )
                    ],
                  ),
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: detail.entries.map((entry) {
                        return BulletList(
                          title: entry.key,
                          listData: entry.value,
                        );
                      }).toList(),
                    ),
                    NotesSegment(
                      title: 'Catatan',
                      body: header?.remarks ?? '',
                    ).addMarginBottom(20),
                    if (documents?.isNotEmpty ?? false)
                      Text(
                        'Attachment',
                        style: Themes().blackBold12?.withColor(Themes.hint),
                      ).addMarginBottom(8),
                    if (documents?.isNotEmpty ?? false)
                      Column(
                        children: List.generate(
                          documents?.length ?? 0,
                          (index) {
                            final document = documents?[index];

                            return ItemFile(
                              title: document?.fileName ?? '',
                              url: document?.fileUrl ?? '',
                              onTap: () => downloadFile(document),
                            ).addMarginBottom(
                              index < 1 ? 12 : 0,
                            );
                          },
                        ),
                      ),
                    if (rated && (isForm > 0) && (reviews?.isNotEmpty ?? false))
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: Themes.stroke,
                            margin: const EdgeInsets.only(
                              top: 4,
                              bottom: 12,
                            ),
                          ),
                          Text(
                            'Hasil Tinjauan',
                            style:
                                Themes().blackBold14?.withColor(Themes.black),
                          ).addMarginBottom(12),
                          Column(
                            children: (reviews ?? []).map((review) {
                              final isNotes = review.keterangan
                                      ?.toLowerCase()
                                      .contains('catatan') ??
                                  false;

                              return ItemReviewSegment(
                                title: review.keterangan ?? '',
                                value: review.nilai ?? '',
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                isVerticalValue: isNotes,
                                isRichTextValue: isNotes,
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    if (!rated)
                      RippleButton(
                        onTap: () {
                          expandableController.toggle();
                        },
                        color: Themes.transparent,
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.rotate(
                              angle: 180 * pi / 180,
                              child: SvgPicture.asset(AssetIcons.icChevronDown),
                            ).addMarginRight(8.w),
                            Text(
                              'Tutup Detail',
                              style: Themes().black12,
                            )
                          ],
                        ),
                      )
                  ],
                ),
                theme: const ExpandableThemeData(
                  hasIcon: false,
                ),
              );
            },
          ),
          if (!rated && checkedId.isEmpty)
            Row(
              children: [
                PrimaryButton(
                  onTap: () => rejectActivity(context),
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
                  onTap: () => approveActivity(
                    context: context,
                    isMiniCex: isMiniCex,
                    isForm: isForm,
                    id: header?.id,
                  ),
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
            ).addMarginTop(12),
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

  rejectActivity(BuildContext context) {
    DialogHelper.showModalConfirmation(
      title: 'Konfirmasi Penolakan',
      message: 'Silakan masukkan alasan penolakan di bawah ini.',
      type: ConfirmationType.withField,
      labelField: 'Alasan Penolakan',
      hintField: 'Masukkan Alasan Penolakan',
      optionalField: false,
      onPositiveTapWithField: (fieldValue) {
        Navigator.pop(context);

        if (data.header?.id != null) {
          context.read<ClinicActivityLectureProvider>().rejectActivity([
            KeyValueData(
              id: '${data.header?.id}',
              reason: fieldValue,
            ),
          ]);
        }
      },
    );
  }

  approveActivity({
    required BuildContext context,
    required bool isMiniCex,
    required int isForm,
    int? id,
  }) {
    if (isForm > 0 && id != null) {
      if (isMiniCex) {
        NavHelper.navigatePush(MiniCexApprovalScreen(
          id: '$id',
        ));
      } else {
        NavHelper.navigatePush(ScientificEventApprovalScreen(id: '$id'));
      }
    } else {
      DialogHelper.showModalConfirmation(
        title: 'Konfirmasi Persetujuan',
        message: 'Apakah anda yakin ingin menyetujui catatan ini?',
        type: ConfirmationType.withField,
        labelField: 'Masukan',
        hintField: 'Masukkan Alasan Penolakan',
        optionalField: true,
        onPositiveTapWithField: (fieldValue) {
          Navigator.pop(context);

          if (data.header?.id != null) {
            context.read<ClinicActivityLectureProvider>().approveActivity([
              KeyValueData(
                id: '${data.header?.id}',
                reason: fieldValue,
              ),
            ]);
          }
        },
      );
    }
  }
}
