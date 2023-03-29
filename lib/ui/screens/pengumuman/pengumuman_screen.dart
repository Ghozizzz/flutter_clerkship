import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:clerkship/utils/tools.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:clerkship/data/network/services/get_feature_service.dart';

import '../../../data/models/breadcrum_sk.dart';
import '../../../config/themes.dart';
import '../../../r.dart';
import '../../components/buttons/ripple_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';

class PengumumanScreen extends StatefulWidget {
  final BreadcrumSK breadcrumSK;
  const PengumumanScreen(
      {super.key, required this.breadcrumSK});

  @override
  State<PengumumanScreen> createState() => _PengumumanScreenState();
}

class _PengumumanScreenState extends State<PengumumanScreen> {
  String htmlData = '';

  @override
  void initState() {
    super.initState();
    GetFeatureService().getFeature(idBatch: widget.breadcrumSK.id).then((value) {
      if(value.statusCode == 200){
        setState(() {
          htmlData = value.data?.data?.news ?? '';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeStatusBar(
      child: Scaffold(
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
            Text(
              'Pengumuman',
              style: Themes().primaryBold20,
            ).addMarginOnly(
              top: 0.w,
              right: 20.w,
              left: 20.w,
            ),
            Text(
              widget.breadcrumSK.title,
              style: Themes().primaryBold18,
            ).addMarginOnly(
              top: 5.w,
              right: 20.w,
              left: 20.w,
              bottom: 20.w
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Html(
                  data: htmlData,
                  tagsList: Html.tags,
                ).addMarginOnly(
                  top: 10.w,
                  right: 10.w,
                  left: 10.w,
                  bottom: 20.w
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
