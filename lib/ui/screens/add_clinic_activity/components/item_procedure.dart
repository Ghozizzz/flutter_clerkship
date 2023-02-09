import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../data/models/dropdown_item.dart';
import '../../../../r.dart';
import '../../../components/buttons/multi_dropdown_field.dart';
import '../../../components/buttons/ripple_button.dart';
import '../../../components/commons/flat_card.dart';
import 'counter_widget.dart';

class ItemProcedure extends StatelessWidget {
  final DropDownItem item;
  final Function(DropDownItem item) onRemoveItem;

  const ItemProcedure({
    super.key,
    required this.item,
    required this.onRemoveItem,
    required this.procedureController,
  });

  final MultiDropDownController procedureController;

  @override
  Widget build(BuildContext context) {
    return FlatCard(
      border: Border.all(color: Themes.stroke),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.title,
                style: Themes().black12,
              ).addSymmetricMargin(horizontal: 14.w).addFlexible,
              RippleButton(
                onTap: () {
                  onRemoveItem(item);
                },
                child: SvgPicture.asset(
                  AssetIcons.icClose,
                ),
              ).addMarginRight(4.w),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CounterWidget(
                item: item,
                procedureController: procedureController,
              ),
            ],
          ).addMarginOnly(
            right: 14.w,
            bottom: 14.w,
          ),
        ],
      ),
    );
  }
}
