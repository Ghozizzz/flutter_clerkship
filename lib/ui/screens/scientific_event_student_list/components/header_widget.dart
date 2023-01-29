import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Themes.primary,
      width: double.infinity,
      height: 120,
      padding: EdgeInsets.all(20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'dr Budiman',
                style: Themes().whiteBold24,
              ).addMarginBottom(8),
              Text(
                'ID. 1123532345',
                style: Themes().white14,
              ),
            ],
          ),
          ClipOval(
            child: SvgPicture.asset(
              AssetImages.avatarPlaceholder,
              width: 56.w,
            ),
          )
        ],
      ),
    );
  }
}
