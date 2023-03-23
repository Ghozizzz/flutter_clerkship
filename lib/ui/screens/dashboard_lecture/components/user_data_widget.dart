import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../data/shared_providers/user_provider.dart';
import '../../../../r.dart';
import '../../../components/commons/flat_card.dart';

class UserDataWidget extends StatelessWidget {
  const UserDataWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${user.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Themes().whiteBold24,
            ),
            Text(
              '${user.nim}',
              style: Themes().white14?.withFontWeight(FontWeight.w500),
            ),
            Text(
              'Departemen',
              style: Themes().white10,
            ).addMarginTop(9),
            Text(
              'Ilmu Penyakit Dalam',
              style: Themes().whiteBold12,
            ).addMarginTop(2),
          ],
        ).addFlexible,
        FlatCard(
          borderRadius: BorderRadius.circular(56.w),
          border: Border.all(
            color: Themes.white,
            width: 4,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(56.w),
            child: Image.asset(
              AssetImages.avatarPlaceholder,
              width: 56.w,
              height: 56.w,
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}
