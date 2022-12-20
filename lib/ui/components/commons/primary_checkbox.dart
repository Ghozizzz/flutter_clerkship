import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../r.dart';

class PrimaryCheckbox extends StatefulWidget {
  final Function(bool value)? onValueChange;
  final String? title;
  final Size? checkBoxSize;
  final Color? color;

  const PrimaryCheckbox({
    super.key,
    this.onValueChange,
    this.title,
    this.checkBoxSize,
    this.color,
  });

  @override
  PrimaryCheckboxState createState() => PrimaryCheckboxState();
}

class PrimaryCheckboxState extends State<PrimaryCheckbox> {
  bool value = false;
  Size? size;

  @override
  Widget build(BuildContext context) {
    if (widget.checkBoxSize != null) {
      size = widget.checkBoxSize;
    } else {
      size = Size(24.w, 24.w);
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          value = !value;
        });
        widget.onValueChange?.call(value);
      },
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: size?.width,
            height: size?.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.w),
              border: Border.all(
                color: value ? (widget.color ?? Themes.checkbox) : Themes.black,
              ),
              color: value
                  ? (widget.color ?? Themes.checkbox)
                  : Colors.transparent,
            ),
            child: Transform.scale(
              scale: 0.8,
              child: SvgPicture.asset(
                AssetIcons.icCheck,
                color: value ? Themes.white : Colors.transparent,
              ),
            ),
          ).addMarginRight(8.w),
          Text(
            widget.title ?? '',
            style: Themes().black14,
          ),
        ],
      ),
    );
  }
}
