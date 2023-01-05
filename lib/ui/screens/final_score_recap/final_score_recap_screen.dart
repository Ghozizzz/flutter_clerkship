import 'package:clerkship/config/themes.dart';
import 'package:clerkship/r.dart';
import 'package:clerkship/ui/components/buttons/ripple_button.dart';
import 'package:clerkship/ui/components/commons/flat_card.dart';
import 'package:clerkship/ui/components/commons/primary_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import 'components/item_score.dart';
import 'components/score_recap_header.dart';

class FinalScoreRecapScreen extends StatelessWidget {
  const FinalScoreRecapScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            itemCount: 7,
            itemBuilder: (context, index) {
              return const ItemScore().addMarginTop(20);
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
                      onTap: () {},
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
}
