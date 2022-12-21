import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import 'ripple_button.dart';

class ToggleButton extends StatelessWidget {
  const ToggleButton({
    Key? key,
    required this.controller,
    required this.attribute,
    required this.icon,
  }) : super(key: key);

  final FleatherController controller;
  final ParchmentAttribute attribute;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return ToggleStyleButton(
      attribute: attribute,
      controller: controller,
      icon: Icons.abc,
      childBuilder: (context, attribute, _, isToggled, onPressed) {
        return SizedBox(
          width: 32.w,
          height: 32.w,
          child: RippleButton(
            padding: EdgeInsets.all(4.w),
            onTap: onPressed,
            child: SvgPicture.asset(
              icon,
              width: 24.w,
              height: 24.w,
              color: isToggled ? Themes.black : Themes.hint,
            ),
          ),
        );
      },
    ).addMarginRight(4.w);
  }
}
