import 'package:clerkship/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../components/buttons/ripple_button.dart';

class ItemNotification extends StatelessWidget {
  final bool isRead;

  const ItemNotification({
    super.key,
    this.isRead = false,
  });

  @override
  Widget build(BuildContext context) {
    return RippleButton(
      border: Border.all(color: Themes.stroke),
      color: isRead ? Themes.primary.withOpacity(0.05) : Themes.white,
      onTap: () {},
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                margin: EdgeInsets.only(right: 12.w),
                decoration: BoxDecoration(
                  color: Themes.primary.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AssetIcons.icVerified,
                  width: 20.w,
                  height: 20.w,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text:
                        '<p>Penilaian akhir <b>ilmu Penyakit Dalam</b> sudah diberikan</p>'
                            .toSpan(context),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ).addMarginBottom(2),
                  Text(
                    '2 menit',
                    style: Themes().black10?.withColor(Themes.hint),
                  ),
                ],
              ).addExpanded,
              Container(
                margin: EdgeInsets.only(left: 12.w),
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Themes.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
