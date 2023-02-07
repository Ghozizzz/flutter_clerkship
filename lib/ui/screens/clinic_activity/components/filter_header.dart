import 'package:clerkship/ui/components/buttons/dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../data/models/dropdown_item.dart';
import '../../../../data/shared_providers/reference_provider.dart';
import '../../../../r.dart';
import '../../../components/buttons/date_picker_button.dart';
import '../../../components/buttons/primary_button.dart';
import '../providers/clinic_activity_lecture_provider.dart';

class FilterHeader extends StatelessWidget {
  const FilterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final filterKegiatan = context.watch<ReferenceProvider>().filterKegiatan;
    final dateController =
        context.watch<ClinicActivityLectureProvider>().dateController;
    final activityFilterController =
        context.watch<ClinicActivityLectureProvider>().activityFilterController;

    return Row(
      children: [
        DatePickerButton(
          controller: dateController,
          dateFormat: 'dd/MM/yyyy',
          hint: 'Tanggal',
          icon: SvgPicture.asset(
            AssetIcons.icChevronRight,
          ),
          textStyle: Themes().black12,
        ).addExpanded,
        Container(width: 10.w),
        DropdownField(
          hint: 'Kegiatan',
          controller: activityFilterController,
          enable: filterKegiatan.isNotEmpty,
          items: List.generate(
            filterKegiatan.length,
            (index) => DropDownItem(
              title: filterKegiatan[index].name!,
              value: index,
            ),
          ),
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
    ).addSymmetricMargin(horizontal: 24.w);
  }
}
