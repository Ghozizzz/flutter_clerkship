import 'package:clerkship/ui/components/buttons/dropdown_field.dart';
import 'package:clerkship/ui/screens/scientific_event/providers/item_list_all_provider.dart';
import 'package:clerkship/ui/screens/scientific_event/providers/item_list_approve_provider.dart';
import 'package:clerkship/ui/screens/scientific_event/providers/item_list_draft_provider.dart';
import 'package:clerkship/ui/screens/scientific_event/providers/item_list_reject_provider.dart';
import 'package:clerkship/ui/screens/scientific_event/providers/item_list_waiting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../data/models/dropdown_item.dart';
import '../../../../data/shared_providers/reference_provider.dart';

class FilterHeaderStudent extends StatefulWidget {
  const FilterHeaderStudent({super.key});

  @override
  State<FilterHeaderStudent> createState() => _FilterHeaderStudentState();
}

class _FilterHeaderStudentState extends State<FilterHeaderStudent> {
  final activityFilterController = DropDownController();

  @override
  Widget build(BuildContext context) {
    final refrenceProvider = context.watch<ReferenceProvider>();

    final filterKegiatanStudent =
        refrenceProvider.filterKegiatanStudent.toList();

    return Row(
      children: [
        DropdownField(
          hint: 'Kegiatan',
          controller: activityFilterController,
          enable: filterKegiatanStudent.isNotEmpty,
          items: List.generate(
            filterKegiatanStudent.length,
            (index) => DropDownItem(
              title: filterKegiatanStudent[index].name!,
              value: filterKegiatanStudent[index].id,
            ),
          ),
          onSelected: (value) => refreshData(context),
          onRemoved: () => refreshData(context),
          withReset: true,
        ).addExpanded,
      ],
    ).addSymmetricMargin(horizontal: 24.w);
  }

  void refreshData(BuildContext context) {
    context.read<ItemListAllScientificProvider>().getListScientific(
        idActivity: activityFilterController.selected?.value);
    context.read<ItemListApproveScientificProvider>().getListScientific(
        idActivity: activityFilterController.selected?.value);
    context.read<ItemListDraftScientificProvider>().getListScientific(
        idActivity: activityFilterController.selected?.value);
    context.read<ItemListRejectScientificProvider>().getListScientific(
        idActivity: activityFilterController.selected?.value);
    context.read<ItemListWaitingScientificProvider>().getListScientific(
        idActivity: activityFilterController.selected?.value);
  }
}
