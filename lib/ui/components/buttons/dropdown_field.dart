import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/models/dropdown_item.dart';
import '../../../r.dart';
import '../buttons/ripple_button.dart';
import '../commons/flat_card.dart';
import '../modal/modal_dropdown_widget.dart';

class DropDownController extends ValueNotifier<DropDownItem?> {
  DropDownItem? selected;

  DropDownController({this.selected}) : super(selected);

  void resetValue() {
    selected = null;
    notifyListeners();
  }

  void setSelected(DropDownItem value) {
    selected = value;
    notifyListeners();
  }
}

class DropdownField extends StatefulWidget {
  final DropDownController controller;
  final String? hint;
  final Color? iconColor;
  final double? iconSize;
  final Function(DropDownItem value)? onSelected;
  final VoidCallback? onRemoved;
  final double? width;
  final double? height;
  final Color? color;
  final Border? border;
  final bool enable;
  final Widget? icon;
  final List<DropDownItem> items;
  final bool? showSubtitle;
  final BoxShadow? shadow;
  final Color? textColor;
  final bool withSearchField;
  final bool withReset;

  const DropdownField({
    super.key,
    required this.controller,
    required this.items,
    this.iconColor,
    this.iconSize = 18,
    this.hint,
    this.onSelected,
    this.onRemoved,
    this.width,
    this.height,
    this.color,
    this.border,
    this.enable = true,
    this.icon,
    this.showSubtitle = true,
    this.shadow,
    this.textColor,
    this.withSearchField = true,
    this.withReset = false,
  });

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState<T> extends State<DropdownField> {
  Widget rightIcon(BuildContext context) {
    if (!widget.withReset || widget.controller.selected == null) {
      return widget.icon ??
          SvgPicture.asset(
            AssetIcons.icChevronRight,
          );
    } else {
      if (widget.withReset && widget.controller.selected != null) {
        return RippleButton(
          onTap: () {
            widget.controller.resetValue();
            widget.onRemoved?.call();
          },
          padding: EdgeInsets.zero,
          child: SvgPicture.asset(
            AssetIcons.icClose,
          ),
        );
      }
    }

    return Container();
  }

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
            child: ValueListenableBuilder(
              valueListenable: widget.controller,
              builder: (context, value, _) {
                final searchItem = widget.items.where(
                  (element) =>
                      element.value == widget.controller.selected?.value,
                );

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      searchItem.isNotEmpty
                          ? searchItem.first.title
                          : widget.hint ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Themes().black12?.withColor(searchItem.isNotEmpty
                          ? widget.textColor
                          : Themes.hint),
                    ).addFlexible,
                    rightIcon(context),
                  ],
                );
              },
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
      builder: (context) => ModalDropDownWidget(
        withSearchField: widget.withSearchField,
        onSelected: (item) {
          widget.controller.setSelected(item);
          if (widget.onSelected != null) widget.onSelected!(item);
          Navigator.pop(context);
        },
        items: widget.items,
        selected: widget.controller.selected?.value,
      ),
    );
  }
}
