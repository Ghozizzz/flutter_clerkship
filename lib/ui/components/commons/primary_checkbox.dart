import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../r.dart';

class CheckboxController extends ValueNotifier<bool> {
  CheckboxController(super.value);
}

class PrimaryCheckbox extends StatefulWidget {
  final CheckboxController controller;
  final Function(bool value)? onValueChange;
  final String? title;
  final Size? checkBoxSize;
  final Color? color;

  const PrimaryCheckbox({
    super.key,
    required this.controller,
    this.onValueChange,
    this.title,
    this.checkBoxSize,
    this.color,
  });

  @override
  PrimaryCheckboxState createState() => PrimaryCheckboxState();
}

class PrimaryCheckboxState extends State<PrimaryCheckbox> {
  Size? size;

  @override
  Widget build(BuildContext context) {
    if (widget.checkBoxSize != null) {
      size = widget.checkBoxSize;
    } else {
      size = Size(20.w, 20.w);
    }

    return GestureDetector(
      onTap: () {
        widget.controller.value = !widget.controller.value;
        widget.onValueChange?.call(widget.controller.value);
      },
      child: Row(
        children: [
          ValueListenableBuilder(
              valueListenable: widget.controller,
              builder: (context, value, _) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  width: size?.width,
                  height: size?.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.w),
                    border: Border.all(
                      color: value
                          ? (widget.color ?? Themes.checkbox)
                          : Themes.stroke,
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
                ).addMarginRight(8.w);
              }),
          Text(
            widget.title ?? '',
            style: Themes().black12,
          ),
        ],
      ),
    );
  }
}
