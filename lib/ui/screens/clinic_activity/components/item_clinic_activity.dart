import 'dart:math';

import 'package:clerkship/r.dart';
import 'package:clerkship/ui/components/buttons/primary_button.dart';
import 'package:clerkship/ui/components/buttons/ripple_button.dart';
import 'package:clerkship/ui/components/commons/flat_card.dart';
import 'package:clerkship/ui/components/modal/modal_confirmation.dart';
import 'package:clerkship/ui/screens/clinic_activity/providers/clinic_activity_lecture_provider.dart';
import 'package:clerkship/ui/screens/clinic_activity_review/clinic_activity_review_screen.dart';
import 'package:clerkship/utils/dialog_helper.dart';
import 'package:clerkship/utils/extensions.dart';
import 'package:clerkship/utils/nav_helper.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../data/network/entity/clinic_lecture_response.dart';
import '../../../components/commons/primary_checkbox.dart';
import '../../clinic_detail_approval/components/item_file.dart';
import '../../clinic_detail_approval/components/item_info_segment.dart';
import 'bullet_list.dart';

class ItemClinicActivity extends StatefulWidget {
  final bool rated;
  final ClinicActivityData data;

  const ItemClinicActivity({
    super.key,
    required this.data,
    this.rated = false,
  });

  @override
  State<ItemClinicActivity> createState() => _ItemClinicActivityState();
}

class _ItemClinicActivityState extends State<ItemClinicActivity> {
  final checkboxController = CheckboxController(false);
  final expandableController = ExpandableController();

  @override
  void initState() {
    super.initState();
    expandableController.expanded = widget.rated;
    checkboxController.value = widget.data.checked;
  }

  @override
  Widget build(BuildContext context) {
    final header = widget.data.data?.first.header;
    final details = widget.data.data?.first.detail;
    final documents = widget.data.data?.first.document;
    final reviews = widget.data.data?.first.tinjauan;
    final Map<String, List<String>> detail = {};
    final checkedId = context.watch<ClinicActivityLectureProvider>().checkedId;

    for (Detail detalBody in details ?? []) {
      if (detalBody.namaJenis != null && detalBody.namaItem != null) {
        if (detail.containsKey(detalBody.namaJenis)) {
          detail[detalBody.namaJenis!]!.add(detalBody.namaItem!);
        } else {
          detail[detalBody.namaJenis!] = [detalBody.namaItem!];
        }
      }
    }

    return FlatCard(
      padding: EdgeInsets.all(12.w),
      border: Border.all(color: Themes.stroke),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.rated)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatCard(
                  color: Themes.success.withOpacity(0.1),
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.w,
                    vertical: 4,
                  ),
                  child: Text(
                    'Disetujui',
                    style: Themes().primary14?.withColor(Themes.success),
                  ),
                ),
                RippleButton(
                  onTap: () {},
                  padding: EdgeInsets.all(4.w),
                  child: SvgPicture.asset(
                    AssetIcons.icEdit,
                    color: Themes.primary,
                    width: 20.w,
                  ),
                ),
              ],
            ).addMarginBottom(12)
          else if (widget.data.data?.first.header?.isMinicex == 0)
            PrimaryCheckbox(
              controller: checkboxController,
              checkBoxSize: Size(20.w, 20.w),
              unCheckColor: Themes.hint,
              strokeWidth: 2,
              onValueChange: (value) {
                widget.data.checked = value;

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
          if (widget.rated)
            Column(
              children: [
                ItemInfoSegment(
                  title: 'Tanggal',
                  value: header?.tanggal?.formatDate('dd MMMM yyyy') ?? '',
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                ItemInfoSegment(
                  title: 'Preseptor',
                  padding: const EdgeInsets.symmetric(vertical: 12),
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
                        'dr Budiman',
                        style: Themes().blackBold12,
                      ),
                    ],
                  ),
                ),
                const ItemInfoSegment(
                  title: 'Departemen',
                  value: 'Ilmu Penyakit Dalam',
                  padding: EdgeInsets.symmetric(vertical: 12),
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
                    const BulletList(
                      title: 'Catatan',
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
                            ).addMarginBottom(
                              index < 1 ? 12 : 0,
                            );
                          },
                        ),
                      ),
                    if (!widget.rated)
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
          if (!widget.rated)
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
                        NavHelper.navigatePush(
                          ClinicActivityReviewScreen(),
                        );
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
            )
                .addMarginTop(12)
                .animate(target: checkedId.isEmpty ? 0 : 1)
                .slideY(
                  begin: 0,
                  end: -0.5,
                  curve: Curves.elasticInOut,
                  duration: const Duration(milliseconds: 400),
                )
                .fade(
                  duration: const Duration(milliseconds: 400),
                  begin: 1,
                  end: 0,
                )
                .hide(
                  maintain: false,
                ),
        ],
      ),
    );
  }
}
