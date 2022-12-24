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
  final searchController = TextEditingController();
  final List<DropDownItem> result = [];

  @override
  void initState() {
    super.initState();
    result.addAll(widget.items);
  }

  Widget listView() => ListView.builder(
        controller: controller,
        physics:
            result.length > 8 ? null : const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: result.length,
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
      height: result.length > 8 ? 80.hp : null,
      borderRadius: BorderRadius.circular(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextArea(
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
          result.length > 8 ? listView().addExpanded : listView(),
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
