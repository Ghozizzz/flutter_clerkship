import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../data/models/dropdown_item.dart';
import '../../../../r.dart';
import '../../../components/buttons/date_picker_button.dart';
import '../../../components/buttons/multi_dropdown_field.dart';
import '../../../components/buttons/primary_button.dart';

class FilterHeader extends StatelessWidget {
  FilterHeader({super.key});

  final datePickerController = DatePickerController();
  final activityTypeController = MultiDropDownController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bhima Saputra',
          style: Themes().blackBold20,
        ).addMarginOnly(
          left: 20.w,
          bottom: 4,
        ),
        Text(
          'ID. 1123532345',
          style: Themes().gray10?.boldText(),
        ).addMarginOnly(
          left: 20.w,
          bottom: 12,
        ),
        Row(
          children: [
            DatePickerButton(
              controller: datePickerController,
              dateFormat: 'dd/MM/yyyy',
              hint: 'Tanggal',
              icon: SvgPicture.asset(
                AssetIcons.icChevronRight,
              ),
              textStyle: Themes().black12,
            ).addExpanded,
            Container(width: 10.w),
            MultiDropdownField(
              hint: 'Kegiatan',
              showSelected: false,
              controller: activityTypeController,
              items: List.generate(
                8,
                (index) => DropDownItem(
                  title: 'Pembuatan status',
                  value: index,
                ),
              ),
              textStyle: Themes().black12,
            ).addExpanded,
            Container(width: 10.w),
            PrimaryButton(
              onTap: () {},
              padding: EdgeInsets.all(10.w),
              child: SvgPicture.asset(
                AssetIcons.icSearch,
                color: Themes.white,
                width: 24.w,
              ),
            ),
          ],
        ).addSymmetricMargin(horizontal: 24.w),
      ],
    );
  }
}
