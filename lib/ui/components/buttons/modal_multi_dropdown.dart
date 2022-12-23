import 'package:clerkship/ui/components/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../r.dart';
import '../buttons/ripple_button.dart';
import '../commons/flat_card.dart';
import 'modal_dropdown.dart';

class ModalMultiDropDownController extends ValueNotifier<List<dynamic>?> {
  List<dynamic>? selected;

  ModalMultiDropDownController({this.selected}) : super(selected);

  void setSelected(List<dynamic> value) {
    selected = value;
    notifyListeners();
  }
}

class ModalMultiDropdown extends StatefulWidget {
  final ModalMultiDropDownController controller;
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

  const ModalMultiDropdown({
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
  });

  @override
  State<ModalMultiDropdown> createState() => _ModalMultiDropdownState();
}

class _ModalMultiDropdownState<T> extends State<ModalMultiDropdown> {
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
                    final selectedItems = widget.items.where(
                      (element) =>
                          widget.controller.selected?.contains(element.value) ??
                          false,
                    );
                    return Text(
                      selectedItems.isNotEmpty
                          ? [
                              for (DropDownItem item in selectedItems)
                                item.title
                            ].join(',').replaceAll(',', ', ')
                          : widget.hint ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Themes().black14?.withColor(
                          selectedItems.isNotEmpty
                              ? widget.textColor
                              : Themes.hint),
                    ).addExpanded;
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
      builder: (context) => ModalMultiDropDownWidget(
        onSelected: (items) {
          widget.controller.setSelected(items.map((e) => e.value).toList());
          Navigator.pop(context);
        },
        items: widget.items,
        selected: widget.controller.selected ?? [],
      ),
    );
  }
}

class ModalMultiDropDownWidget extends StatefulWidget {
  final Function(List<DropDownItem> values) onSelected;
  final List<DropDownItem> items;
  final List<dynamic> selected;

  const ModalMultiDropDownWidget({
    super.key,
    required this.onSelected,
    required this.items,
    required this.selected,
  });

  @override
  State<ModalMultiDropDownWidget> createState() =>
      _ModalMultiDropDownWidgetState();
}

class _ModalMultiDropDownWidgetState extends State<ModalMultiDropDownWidget> {
  final controller = ScrollController();

  Widget listView() => ListView.builder(
        controller: controller,
        physics: widget.items.length > 10
            ? null
            : const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.items.length,
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemBuilder: (context, index) {
          final item = widget.items[index];

          return Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:
                      item.selected ? Themes.primary.withOpacity(0.08) : null,
                ),
                child: ListTile(
                  minLeadingWidth: 24.w,
                  onTap: () {
                    setState(() {
                      item.selected = !item.selected;
                    });
                  },
                  title: Stack(
                    children: [
                      Center(
                        child: Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: Themes()
                              .black14
                              ?.withColor(
                                item.selected ? Themes.primary : Themes.text,
                              )
                              .copyWith(
                                fontWeight: item.selected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                        ),
                      ),
                      if (item.selected)
                        Positioned(
                          right: 0,
                          top: 16,
                          child: SvgPicture.asset(
                            AssetIcons.icCheck,
                            color: Themes.primary,
                          ),
                        )
                    ],
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
      height: widget.items.length > 10 ? 80.hp : null,
      borderRadius: BorderRadius.circular(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          widget.items.length > 10 ? listView().addExpanded : listView(),
          PrimaryButton(
            onTap: () {
              widget.onSelected(
                widget.items.where((element) => element.selected).toList(),
              );
            },
            text: 'Pilih',
          ).addAllMargin(20.w),
        ],
      ),
    );
  }
}
