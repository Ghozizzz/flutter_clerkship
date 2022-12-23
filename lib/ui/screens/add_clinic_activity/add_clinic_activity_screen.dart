import 'package:clerkship/config/themes.dart';
import 'package:clerkship/ui/components/buttons/date_picker_button.dart';
import 'package:clerkship/ui/components/buttons/modal_dropdown.dart';
import 'package:clerkship/ui/components/buttons/modal_multi_dropdown.dart';
import 'package:clerkship/ui/components/buttons/time_picker_button.dart';
import 'package:clerkship/ui/components/commons/primary_appbar.dart';
import 'package:clerkship/ui/components/commons/safe_statusbar.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

class AddClinicActivityScreen extends StatelessWidget {
  AddClinicActivityScreen({super.key});

  final dateController = DatePickerController();
  final timeController = TimePickerController();
  final activityTypeController = ModalMultiDropDownController();

  @override
  Widget build(BuildContext context) {
    return SafeStatusBar(
      child: Scaffold(
        body: Column(
          children: [
            const PrimaryAppBar(title: 'Kembali'),
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tambah Kegiatan Klinik',
                      style: Themes().primaryBold20,
                    ).addMarginBottom(22),
                    const LabelText(
                      mandatory: true,
                      text: 'Tanggal',
                    ).addMarginBottom(8),
                    DatePickerButton(
                      controller: dateController,
                    ).addMarginBottom(20),
                    TimePickerButton(
                      controller: timeController,
                    ).addMarginBottom(20),
                    const LabelText(
                      mandatory: true,
                      text: 'Jenis Kegiatan',
                    ).addMarginBottom(8),
                    ModalMultiDropdown(
                      hint: 'Pilih Jenis Kegiatan',
                      controller: activityTypeController,
                      items: [
                        DropDownItem(
                          title: 'Pembuatan status',
                          value: 0,
                        ),
                        DropDownItem(
                          title: 'Bed-side teaching (BST)',
                          value: 1,
                        ),
                        DropDownItem(
                          title: 'Visit Bangsal',
                          value: 2,
                        ),
                        DropDownItem(
                          title: 'Poliklinik',
                          value: 3,
                        ),
                        DropDownItem(
                          title: 'Jaga Malam',
                          value: 4,
                        ),
                        DropDownItem(
                          title: 'Tindakan/Prosedur',
                          value: 5,
                        ),
                        DropDownItem(
                          title: 'Mini CEX',
                          value: 6,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  final bool mandatory;
  final String text;

  const LabelText({
    super.key,
    this.mandatory = false,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: Themes().blackBold12,
        ),
        if (mandatory)
          Text(
            '*',
            style: Themes().blackBold12?.withColor(Themes.red),
          ),
      ],
    );
  }
}
