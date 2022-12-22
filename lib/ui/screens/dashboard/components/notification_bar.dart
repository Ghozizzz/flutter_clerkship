import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';

import '../../../../config/themes.dart';
import '../../../../r.dart';
import '../../../components/buttons/ripple_button.dart';

class NotificationBar extends StatelessWidget {
  const NotificationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          children: [
            RippleButton(
              onTap: () {},
              child: SvgPicture.asset(
                AssetIcons.icNotification,
                height: 18.h,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 12.w,
                left: 22.w,
              ),
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: Themes.red,
                shape: BoxShape.circle,
                border: Border.all(color: Themes.lightPrimary),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
