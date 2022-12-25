import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/models/dropdown_item.dart';
import '../../../r.dart';
import '../buttons/primary_button.dart';
import '../commons/flat_card.dart';
import '../textareas/textarea.dart';

class ModalMultiDropDownWidget extends StatefulWidget {
  final Function(List<DropDownItem> values) onSelected;
  final List<DropDownItem> items;
  final List<dynamic> selected;
  final String otherHint;

  const ModalMultiDropDownWidget({
    super.key,
    required this.onSelected,
    required this.items,
    required this.selected,
    required this.otherHint,
  });

  @override
  State<ModalMultiDropDownWidget> createState() =>
      _ModalMultiDropDownWidgetState();
}

class _ModalMultiDropDownWidgetState extends State<ModalMultiDropDownWidget> {
  final controller = ScrollController();
  final searchController = TextEditingController();
  final otherController = TextEditingController();
  final List<DropDownItem> result = [];
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    result.addAll(widget.items);
    otherController.text = widget.items.last.other;
  }

  Widget listView() => ListView.builder(
        controller: controller,
        physics: result.length > 8 || focusNode.hasFocus
            ? null
            : const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: result.length,
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemBuilder: (context, index) {
          final item = result[index];

          return Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                height: item.value == -1 ? null : 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:
                      item.selected ? Themes.primary.withOpacity(0.08) : null,
                ),
                child: Column(
                  children: [
                    ListTile(
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
                                    item.selected
                                        ? Themes.primary
                                        : Themes.text,
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
                              child: SvgPicture.asset(
                                AssetIcons.icCheck,
                                color: Themes.primary,
                              ),
                            )
                        ],
                      ),
                    ),
                    if (item.value == -1 && item.selected)
                      TextArea(
                        controller: otherController,
                        hint: widget.otherHint,
                        onChangedText: (text) {
                          item.other = text;
                        },
                      ).addMarginOnly(
                        left: 12.w,
                        right: 12.w,
                        bottom: 12.w,
                      ),
                  ],
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
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: FlatCard(
        height: widget.items.length + 1 > 8 ? 80.hp : null,
        borderRadius: BorderRadius.circular(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextArea(
              focusNode: focusNode,
              hint: 'Cari',
              controller: searchController,
              onChangedText: (text) {
                result.clear();
                for (DropDownItem item in widget.items) {
                  if (item.title.toLowerCase().contains(text)) {
                    result.add(item);
                  }
                }
                setState(() {});
              },
              endIcon: Padding(
                padding: EdgeInsets.all(12.w),
                child: SvgPicture.asset(
                  AssetIcons.icSearch,
                  color: Themes.hint,
                ),
              ),
            ).addMarginOnly(
              top: 20.w,
              left: 20.w,
              right: 20.w,
            ),
            result.length > 8 || focusNode.hasFocus
                ? listView().addExpanded
                : listView(),
            PrimaryButton(
              onTap: () {
                final selectedItems =
                    widget.items.where((element) => element.selected).toList();
                widget.onSelected(
                  selectedItems,
                );
              },
              text: 'Pilih',
            ).addAllMargin(20.w),
          ],
        ),
      ),
    );
  }
}