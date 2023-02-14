import 'package:clerkship/ui/components/buttons/dropdown_field.dart';
import 'package:clerkship/ui/screens/scientific_event/providers/scientific_event_lecture_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../../data/models/dropdown_item.dart';
import '../../../../data/network/entity/scientifc_event_participant_response.dart';
import '../../../../data/shared_providers/reference_provider.dart';
import '../../../../r.dart';
import '../../../components/buttons/date_picker_button.dart';

class FilterHeader extends StatelessWidget {
  final ScientificEventParticipant participant;
  const FilterHeader({
    super.key,
    required this.participant,
  });

  @override
  Widget build(BuildContext context) {
    final scientificEventLectureProvider =
        context.watch<ScientificEventLectureProvider>();
    final refrenceProvider = context.watch<ReferenceProvider>();

    final filterKegiatan = refrenceProvider.filterKegiatan;
    final dateController = scientificEventLectureProvider.dateController;
    final activityFilterController =
        scientificEventLectureProvider.activityFilterController;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${participant.namaStudent}',
          style: Themes().blackBold20,
        ).addMarginOnly(
          left: 20.w,
          bottom: 4,
        ),
        Text(
          'ID. ${participant.idUser}',
          style: Themes().gray10?.boldText(),
        ).addMarginOnly(
          left: 20.w,
          bottom: 12,
        ),
        Row(
          children: [
            DatePickerButton(
              controller: dateController,
              dateFormat: 'dd/MM/yyyy',
              hint: 'Tanggal',
              icon: SvgPicture.asset(
                AssetIcons.icChevronRight,
              ),
              textStyle: Themes().black12,
              onDatePicked: (date) => refreshData(context),
              onRemoved: () => refreshData(context),
              withReset: true,
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
              onSelected: (value) => refreshData(context),
              onRemoved: () => refreshData(context),
              withReset: true,
            ).addExpanded,
            // Container(width: 10.w),
            // PrimaryButton(
            //   onTap: () {},
            //   padding: EdgeInsets.all(10.w),
            //   child: SvgPicture.asset(
            //     AssetIcons.icSearch,
            //     color: Themes.white,
            //     width: 24.w,
            //   ),
            // ),
          ],
        ).addSymmetricMargin(horizontal: 24.w),
      ],
    );
  }

  void refreshData(BuildContext context) {
    if (participant.idUser == null) return;
    context
        .read<ScientificEventLectureProvider>()
        .getScientificEvent(idUser: participant.idUser!);
    context
        .read<ScientificEventLectureProvider>()
        .getRatedScientificEvent(idUser: participant.idUser!);
  }
}
