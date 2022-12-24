import 'package:clerkship/data/models/doctor.dart';
import 'package:clerkship/ui/components/modal/modal_doctor_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';

import '../../../config/themes.dart';
import '../../../r.dart';
import '../buttons/ripple_button.dart';
import '../commons/flat_card.dart';

class DoctorController extends ValueNotifier<dynamic> {
  dynamic selected;

  DoctorController({this.selected}) : super(selected);

  void setSelected(dynamic value) {
    selected = value;
    notifyListeners();
  }
}

class DoctorField extends StatefulWidget {
  final DoctorController controller;
  final String? hint;
  final Color? iconColor;
  final double? iconSize;
  final Function(Doctor value)? onSelected;
  final double? width;
  final double? height;
  final Color? color;
  final Border? border;
  final bool enable;
  final Widget? icon;
  final List<Doctor> items;
  final bool? showSubtitle;
  final BoxShadow? shadow;
  final Color? textColor;

  const DoctorField({
    super.key,
    required this.controller,
    required this.items,
    this.iconColor,
    this.iconSize = 18,
    this.hint,
    this.onSelected,
    this.width,
    this.height,
    this.color,
    this.border,
    this.enable = true,
    this.icon,
    this.showSubtitle = true,
    this.shadow,
    this.textColor,
  });

  @override
  State<DoctorField> createState() => _DoctorFieldState();
}

class _DoctorFieldState<T> extends State<DoctorField> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.enable,
      child: FlatCard(
        shadow: widget.shadow,
        borderRadius: BorderRadius.circular(8),
        border: widget.border ?? Border.all(color: Themes.stroke),
        color: widget.color ?? Themes.white.withOpacity(0.3),
        width: widget.width,
        height: widget.height,
        child: Opacity(
          opacity: widget.enable ? 1 : 0.4,
          child: RippleButton(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16,
            ),
            onTap: showBottomSheetOptions,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ValueListenableBuilder(
                  valueListenable: widget.controller,
                  builder: (context, value, _) {
                    final searchItem = widget.items.where(
                      (element) => element.value == widget.controller.selected,
                    );
                    return Text(
                      searchItem.isNotEmpty
                          ? searchItem.first.title
                          : widget.hint ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Themes().black14?.withColor(searchItem.isNotEmpty
                          ? widget.textColor
                          : Themes.hint),
                    );
                  },
                ),
                widget.icon ?? SvgPicture.asset(AssetIcons.icChevronRight),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheetOptions() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) => ModalDoctorPicker(
        onSelected: (item) {
          widget.controller.setSelected(item.value);
          if (widget.onSelected != null) widget.onSelected!(item);
          Navigator.pop(context);
        },
        items: widget.items,
        selected: widget.controller.selected,
      ),
    );
  }
}
