import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../r.dart';
import '../buttons/ripple_button.dart';

class PrimaryAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onTapBack;
  final Widget? action;
  final bool showBackButton;

  const PrimaryAppBar({
    super.key,
    required this.title,
    this.action,
    this.onTapBack,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            height: statusBarHeight,
            color: Themes.primary,
          ),
          Container(
            padding: EdgeInsets.all(16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (showBackButton)
                  RippleButton(
                    padding: EdgeInsets.all(4.w),
                    onTap: onTapBack ??
                        () {
                          Navigator.pop(context);
                        },
                    child: SvgPicture.asset(
                      AssetIcons.icChevronLeft,
                      width: 24.w,
                      height: 24.w,
                    ),
                  ).addMarginRight(8.w)
                else
                  Container(
                    padding: EdgeInsets.all(3.w),
                    child: const SizedBox(
                      height: 36,
                      width: 3,
                    ),
                  ),
                Text(
                  title,
                  style: Themes().black14,
                ),
                Expanded(child: Container()),
                if (action != null) action!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
