import 'package:clerkship/config/themes.dart';
import 'package:clerkship/r.dart';
import 'package:clerkship/ui/components/buttons/ripple_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

class ItemStandardTotal extends StatelessWidget {
  final String title;
  final int total;
  const ItemStandardTotal(
      {super.key, required this.title, required this.total});

  @override
  Widget build(BuildContext context) {
    return RippleButton(
      onTap: () {},
      border: Border.all(color: Themes.stroke),
      child: Row(
        children: [
          Container(
            width: 16.w,
            height: 16.w,
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Themes.primary,
                width: 1.5,
              ),
            ),
            child: SvgPicture.asset(
              AssetIcons.icCheck,
              color: Themes.primary,
            ),
          ).addMarginRight(12.w),
          Text(
            title,
            style: Themes().blackBold12?.withColor(Themes.content),
          ).addExpanded,
          Text(
            total.toString(),
            style: Themes().black12?.withColor(Themes.content),
          )
        ],
      ),
    );
  }
}
