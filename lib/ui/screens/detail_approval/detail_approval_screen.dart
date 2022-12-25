import 'package:clerkship/config/themes.dart';
import 'package:clerkship/r.dart';
import 'package:clerkship/ui/components/buttons/ripple_button.dart';
import 'package:clerkship/ui/components/commons/primary_appbar.dart';
import 'package:clerkship/ui/components/commons/safe_statusbar.dart';
import 'package:clerkship/ui/components/modal/modal_confirmation.dart';
import 'package:clerkship/utils/dialog_helper.dart';
import 'package:clerkship/utils/nav_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';

class DetailApprovalScreen extends StatelessWidget {
  const DetailApprovalScreen({super.key});

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
          ],
        ),
      ),
    );
  }
}
