import 'package:clerkship/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../buttons/ripple_button.dart';
import '../commons/flat_card.dart';

class ModalDropDownController extends ValueNotifier<dynamic> {
  dynamic selected;

  ModalDropDownController({this.selected}) : super(selected);

  void setSelected(dynamic value) {
    selected = value;
    notifyListeners();
  }
}

class DropDownItem {
  String title;
  dynamic value;
  Color? color;
  bool selected;

  DropDownItem({
    required this.title,
    required this.value,
    this.color,
    this.selected = false,
  });
}

class ModalDropdown<T> extends StatefulWidget {
  final ModalDropDownController controller;
  final T? selected;
  final String? hint;
  final Color? iconColor;
  final double? iconSize;
  final Function(DropDownItem value)? onSelected;
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

  const ModalDropdown({
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
    this.selected,
    this.enable = true,
    this.icon,
    this.showSubtitle = true,
    this.shadow,
    this.textColor,
  });

  @override
  State<ModalDropdown> createState() => _ModalDropdownState();
}

class _ModalDropdownState<T> extends State<ModalDropdown> {
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
      builder: (context) => ModalDropDownWidget(
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

class ModalDropDownWidget extends StatefulWidget {
  final Function(DropDownItem value) onSelected;
  final List<DropDownItem> items;
  final dynamic selected;

  const ModalDropDownWidget({
    super.key,
    required this.onSelected,
    required this.items,
    required this.selected,
  });

  @override
  State<ModalDropDownWidget> createState() => _ModalDropDownWidgetState();
}

class _ModalDropDownWidgetState extends State<ModalDropDownWidget> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int index = -1;
      for (int i = 0; i < widget.items.length; i++) {
        if (widget.items[i].value == widget.selected) {
          index = i;
          break;
        }
      }
      if (!index.isNegative) {
        if (widget.items.length > 6) {
          controller.jumpTo(
            56.0 * index,
          );
        }
      }
    });
  }

  Widget listView() => ListView.builder(
        controller: controller,
        physics: widget.items.length > 6
            ? null
            : const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.items.length,
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemBuilder: (context, index) {
          final item = widget.items[index];
          final selected = widget.selected == item.value;

          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                height: 56,
                color: item.value == widget.selected
                    ? Themes.stroke.withOpacity(0.1)
                    : null,
                child: ListTile(
                  minLeadingWidth: 24.w,
                  onTap: () {
                    widget.onSelected(item);
                  },
                  title: Text(
                    item.title,
                    style: Themes()
                        .black14
                        ?.withColor(
                          selected ? Themes.primary : Themes.text,
                        )
                        .copyWith(
                          fontWeight:
                              selected ? FontWeight.bold : FontWeight.normal,
                        ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Themes.stroke,
                margin: EdgeInsets.symmetric(horizontal: 12.w),
              ),
            ],
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return FlatCard(
      height: widget.items.length > 6 ? 80.hp : null,
      borderRadius: BorderRadius.circular(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          widget.items.length > 6 ? listView().addExpanded : listView()
        ],
      ),
    );
  }
}
