import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/models/dropdown_item.dart';
import '../../../r.dart';
import '../buttons/ripple_button.dart';
import '../commons/flat_card.dart';
import '../modal/modal_multi_dropdown_widget.dart';

class MultiDropDownController extends ValueNotifier<List<DropDownItem>?> {
  List<DropDownItem>? selected;

  MultiDropDownController({this.selected}) : super(selected);

  void addCount(DropDownItem item) {
    for (DropDownItem itemSelected in selected ?? []) {
      if (itemSelected.value == item.value) {
        itemSelected.count++;
        notifyListeners();
        break;
      }
    }
  }

  void subtractCount(DropDownItem item) {
    for (DropDownItem itemSelected in selected ?? []) {
      if (itemSelected.value == item.value) {
        if (itemSelected.count > 0) itemSelected.count--;
        notifyListeners();
        break;
      }
    }
  }

  void setSelected(List<DropDownItem> value) {
    selected = value;
    notifyListeners();
  }

  void removeSelected(DropDownItem item) {
    selected?.removeWhere((element) => element.value == item.value);
    notifyListeners();
  }
}

class MultiDropdownField extends StatefulWidget {
  final MultiDropDownController controller;
  final String? hint;
  final Color? iconColor;
  final double? iconSize;
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
  final String otherHint;
  final Widget Function(
    DropDownItem item,
    Function(DropDownItem item) onRemoveItem,
  )? customItem;

  const MultiDropdownField({
    super.key,
    required this.controller,
    required this.items,
    this.iconColor,
    this.iconSize = 18,
    this.hint,
    this.width,
    this.height,
    this.color,
    this.border,
    this.enable = true,
    this.icon,
    this.showSubtitle = true,
    this.shadow,
    this.textColor,
    this.otherHint = 'Lainnya',
    this.customItem,
  });

  @override
  State<MultiDropdownField> createState() => _MultiDropdownStateButton();
}

class _MultiDropdownStateButton<T> extends State<MultiDropdownField> {
  @override
  void initState() {
    super.initState();
    widget.items.add(DropDownItem(
      title: 'Lainnya',
      value: -1,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.enable,
      child: ValueListenableBuilder(
          valueListenable: widget.controller,
          builder: (context, value, _) {
            return Column(
              children: [
                Column(
                  children: (widget.controller.selected ?? [])
                      .map(
                        (e) =>
                            widget.customItem?.call(e, removeItem) ??
                            defaultItem(e),
                      )
                      .toList(),
                ),
                FlatCard(
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
                          Text(
                            widget.hint ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Themes().black12?.withColor(Themes.hint),
                          ).addExpanded,
                          widget.icon ??
                              SvgPicture.asset(
                                AssetIcons.icChevronRight,
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  void removeItem(DropDownItem item) {
    widget.items.firstWhere((element) => element.value == item.value).selected =
        false;
    widget.controller.removeSelected(item);
  }

  Widget defaultItem(DropDownItem item) {
    return FlatCard(
      border: Border.all(color: Themes.stroke),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.value == -1 ? item.other : item.title,
            style: Themes().black12,
          ).addMarginLeft(12.w),
          RippleButton(
            onTap: () {
              removeItem(item);
            },
            child: SvgPicture.asset(AssetIcons.icClose),
          ).addMarginRight(4.w),
        ],
      ),
    ).addMarginBottom(12);
  }

  void showBottomSheetOptions() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) => ModalMultiDropDownWidget(
        otherHint: widget.otherHint,
        onSelected: (items) {
          widget.controller.setSelected(items);
          Navigator.pop(context);
        },
        items: widget.items,
        selected: widget.controller.selected ?? [],
      ),
    );
  }
}
