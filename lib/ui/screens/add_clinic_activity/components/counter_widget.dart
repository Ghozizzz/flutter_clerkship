import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';

import '../../../../config/themes.dart';
import '../../../../data/models/dropdown_item.dart';
import '../../../components/buttons/multi_dropdown_field.dart';
import '../../../components/buttons/ripple_button.dart';
import '../../../components/commons/flat_card.dart';

class CounterWidget extends StatelessWidget {
  final DropDownItem item;

  const CounterWidget({
    Key? key,
    required this.procedureController,
    required this.item,
  }) : super(key: key);

  final MultiDropDownController procedureController;

  @override
  Widget build(BuildContext context) {
    return FlatCard(
      height: 32.w,
      child: Row(
        children: [
          RippleButton(
            onTap: () {
              procedureController.subtractCount(item);
            },
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.w),
              bottomLeft: Radius.circular(4.w),
            ),
            color: Themes.primary,
            padding: EdgeInsets.all(6.w),
            child: const Icon(
              Icons.remove_rounded,
              color: Themes.white,
            ),
          ),
          FlatCard(
            width: 32.w,
            borderRadius: BorderRadius.zero,
            border: Border.all(color: Themes.stroke),
            child: Center(
              child: Text(
                '${item.count}',
                style: Themes().black12,
              ),
            ),
          ),
          RippleButton(
            onTap: () {
              procedureController.addCount(item);
            },
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(4.w),
              bottomRight: Radius.circular(4.w),
            ),
            color: Themes.primary,
            padding: EdgeInsets.all(6.w),
            child: const Icon(
              Icons.add_rounded,
              color: Themes.white,
            ),
          ),
        ],
      ),
    );
  }
}
