import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/models/dropdown_item.dart';
import '../commons/flat_card.dart';

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
        if (widget.items.length > 10) {
          controller.jumpTo(
            56.0 * index,
          );
        }
      }
    });
  }

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
          final selected = widget.selected == item.value;

          return Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: item.value == widget.selected
                      ? Themes.primary.withOpacity(0.08)
                      : null,
                ),
                child: ListTile(
                  minLeadingWidth: 24.w,
                  onTap: () {
                    widget.onSelected(item);
                  },
                  title: Text(
                    item.title,
                    textAlign: TextAlign.center,
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
              if (item.value != widget.selected)
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
          widget.items.length > 10 ? listView().addExpanded : listView()
        ],
      ),
    );
  }
}
