import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../data/shared_providers/user_provider.dart';
import '../../../../r.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

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
                '${user.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Themes().whiteBold24,
              ).addMarginBottom(8),
              Text(
                'ID. ${user.nim}',
                style: Themes().white14,
              ),
            ],
          ).addFlexible,
          ClipOval(
            child: Image.asset(
              AssetImages.avatarPlaceholder,
              width: 56.w,
            ),
          )
        ],
      ),
    );
  }
}
