import 'package:clerkship/config/themes.dart';
import 'package:clerkship/data/shared_providers/clinic_activity_provider.dart';
import 'package:clerkship/r.dart';
import 'package:clerkship/ui/components/buttons/primary_button.dart';
import 'package:clerkship/ui/components/buttons/ripple_button.dart';
import 'package:clerkship/ui/components/commons/flat_card.dart';
import 'package:clerkship/ui/components/commons/primary_appbar.dart';
import 'package:clerkship/ui/components/commons/safe_statusbar.dart';
import 'package:clerkship/ui/components/modal/modal_confirmation.dart';
import 'package:clerkship/ui/screens/clinic_detail_approval/components/item_info_segment.dart';
import 'package:clerkship/utils/dialog_helper.dart';
import 'package:clerkship/utils/nav_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../clinic_activity/providers/item_list_all_provider.dart';
import '../clinic_activity/providers/item_list_approve_provider copy.dart';
import '../clinic_activity/providers/item_list_draft_provider.dart';
import '../clinic_activity/providers/item_list_reject_provider.dart';
import 'components/bullet_list.dart';
import 'components/item_file.dart';

class ClinicDetailApprovalScreen extends StatelessWidget {
  final int id;
  const ClinicDetailApprovalScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final headerData = context.watch<ClinicActivityProvider>().headerClinic;
    final jenisKegiatan = context.watch<ClinicActivityProvider>().jenisKegiatan;
    final listPenyakit = context.watch<ClinicActivityProvider>().penyakit;
    final listProsedur = context.watch<ClinicActivityProvider>().prosedur;
    final listDocument = context.watch<ClinicActivityProvider>().listDocument;

    return SafeStatusBar(
      child: Scaffold(
        body: Column(
          children: [
            PrimaryAppBar(
              title: 'Kembali',
              action: Visibility(
                visible: headerData.status != 1,
                child: RippleButton(
                  onTap: () {
                    DialogHelper.showModalConfirmation(
                      title: 'Konfirmasi Penghapusan',
                      message:
                          'Apakah anda benar-benar ingin\nmenghapus kegiatan ini?',
                      positiveText: 'Hapus',
                      type: ConfirmationType.horizontalButton,
                      onPositiveTap: () async {
                        NavHelper.pop();
                        await context
                            .read<ClinicActivityProvider>()
                            .deleteClinic(id: headerData.id!)
                            .then((value) {
                          context
                              .read<ItemListAllClinicProvider>()
                              .getListClinic();
                          context
                              .read<ItemListDraftClinicProvider>()
                              .getListClinic();
                          context
                              .read<ItemListApproveClinicProvider>()
                              .getListClinic();
                          context
                              .read<ItemListRejectClinicProvider>()
                              .getListClinic();
                        });
                      },
                    );
                  },
                  padding: EdgeInsets.all(8.w),
                  child: SvgPicture.asset(
                    AssetIcons.icDelete,
                    color: Themes.red,
                  ),
                ),
              ),
            ),
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
                          '10 Agustus 2022',
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
                            style: Themes().blackBold10?.withColor(Themes.blue),
                          ),
                        )
                      ],
                    ),
                  ).addMarginBottom(40),
                  ItemInfoSegment(
                    title: 'Tanggal',
                    value:
                        DateFormat('dd MMMM yyyy').format(headerData.tanggal!),
                  ),
                  ItemInfoSegment(
                    title: 'Kegiatan',
                    value: jenisKegiatan.namaItem!,
                  ),
                  ItemInfoSegment(
                    title: 'Preseptor',
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
                          headerData.namaDokter!,
                          style: Themes().blackBold12,
                        ),
                      ],
                    ),
                  ),
                  ItemInfoSegment(
                    title: 'Departemen',
                    value: headerData.namaDepartment!,
                  ),
                  BulletList(
                    title: 'Penyakit',
                    listData: listPenyakit,
                  ),
                  BulletList(
                    title: 'Prosedur',
                    listData: listProsedur,
                    withCount: true,
                  ),
                  Visibility(
                    visible: headerData.remarks!.isNotEmpty,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Catatan',
                          style: Themes().blackBold12?.withColor(Themes.hint),
                        ).addMarginTop(20),
                        Text(
                          headerData.remarks!,
                          style: Themes().black12,
                        ).addMarginOnly(
                          top: 8,
                          bottom: 20,
                        ),
                      ],
                    ),
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
}
