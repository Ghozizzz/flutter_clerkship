import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../components/buttons/ripple_button.dart';

class ItemMenu extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const ItemMenu({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RippleButton(
      onTap: onTap,
      padding: EdgeInsets.all(14.w),
      color: Themes.white,
      shadow: Themes.dropShadow,
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            width: 48.w,
            height: 48.w,
          ).addMarginBottom(10.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Themes(withLineHeight: true)
                .blackBold12
                ?.withColor(Themes.content),
          ),
        ],
      ),
    );
  }
}
