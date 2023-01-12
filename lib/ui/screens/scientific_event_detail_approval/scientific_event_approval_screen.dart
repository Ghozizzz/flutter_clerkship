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
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../clinic_detail_approval/components/item_file.dart';

class ScientificEventDetailApprovalScreen extends StatelessWidget {
  const ScientificEventDetailApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeStatusBar(
      child: Scaffold(
        body: Column(
          children: [
            PrimaryAppBar(
              title: 'Kembali',
              action: RippleButton(
                onTap: () {
                  DialogHelper.showModalConfirmation(
                    title: 'Konfirmasi Penghapusan',
                    message:
                        'Apakah anda benar-benar ingin\nmenghapus kegiatan ini?',
                    positiveText: 'Hapus',
                    type: ConfirmationType.horizontalButton,
                    onPositiveTap: () {
                      NavHelper.pop();
                      DialogHelper.showMessageDialog(
                        title: 'Dihapus',
                        body: 'kegiatan anda telah dihapus',
                      );
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
                          'Mini Referat',
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
                  const ItemInfoSegment(
                    title: 'Tanggal',
                    value: '10 Agustus 2022',
                  ),
                  const ItemInfoSegment(
                    title: 'Jam',
                    value: '9.00',
                  ),
                  const ItemInfoSegment(
                    title: 'Kegiatan',
                    value: 'Mini Referat',
                  ),
                  const ItemInfoSegment(
                    title: 'Peran',
                    value: 'Hadirin Acara',
                  ),
                  const ItemInfoSegment(
                    title: 'Departemen',
                    value: 'Ilmu Penyakit Dalam',
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
                          'dr Budiman',
                          style: Themes().blackBold12,
                        ),
                      ],
                    ),
                  ).addMarginBottom(20),
                  const OtherInfoSegment(
                    title: 'Topik',
                    value: 'Penanganan Medis',
                  ).addMarginBottom(20),
                  const OtherInfoSegment(
                    title: 'Catatan',
                    value: 'Lorem ipsum doloir site amet',
                  ).addMarginBottom(20),
                  Text(
                    'Attachment',
                    style: Themes().blackBold12?.withColor(Themes.hint),
                  ).addMarginBottom(8),
                  Column(
                    children: List.generate(
                      2,
                      (index) => const ItemFile(
                        title: 'File.pdf',
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
