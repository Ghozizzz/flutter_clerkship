import 'package:clerkship/config/themes.dart';
import 'package:clerkship/data/models/doctor.dart';
import 'package:clerkship/ui/components/buttons/date_picker_button.dart';
import 'package:clerkship/ui/components/buttons/doctor_field.dart';
import 'package:clerkship/ui/components/buttons/dropdown_field.dart';
import 'package:clerkship/ui/components/buttons/file_picker_button.dart';
import 'package:clerkship/ui/components/buttons/time_picker_button.dart';
import 'package:clerkship/ui/components/commons/primary_appbar.dart';
import 'package:clerkship/ui/components/commons/safe_statusbar.dart';
import 'package:clerkship/ui/components/textareas/rich_text_editor.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../data/models/dropdown_item.dart';
import '../../components/buttons/multi_dropdown_field.dart';

class AddClinicActivityScreen extends StatelessWidget {
  AddClinicActivityScreen({super.key});

  final dateController = DatePickerController();
  final timeController = TimePickerController();
  final activityTypeController = MultiDropDownController();
  final doctorController = DoctorController();
  final departmentController = DropDownController();
  final diseaseController = MultiDropDownController();
  final skillController = MultiDropDownController();
  final procedureController = MultiDropDownController();
  final symptomsController = MultiDropDownController();
  final noteController = FleatherController();
  final filePickerController = FilePickerController();

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
                    MultiDropdownField(
                      hint: 'Pilih Jenis Kegiatan',
                      controller: activityTypeController,
                      items: List.generate(
                        8,
                        (index) => DropDownItem(
                          title: 'Pembuatan status',
                          value: index,
                        ),
                      ),
                    ).addMarginBottom(6),
                    Text(
                      '*dapat pilih lebih dari satu',
                      style: Themes()
                          .gray12
                          ?.copyWith(fontStyle: FontStyle.italic),
                    ).addMarginBottom(20),
                    const LabelText(
                      mandatory: true,
                      text: 'Preseptor',
                    ).addMarginBottom(8),
                    DoctorField(
                      hint: 'Pilih Dokter',
                      controller: doctorController,
                      items: List.generate(
                        8,
                        (index) => Doctor(
                          title: 'dr. Budiman',
                          value: index,
                        ),
                      ),
                    ).addMarginBottom(20),
                    const LabelText(
                      mandatory: true,
                      text: 'Departemen',
                    ).addMarginBottom(8),
                    DropdownField(
                      hint: 'Pilih Departemen',
                      controller: departmentController,
                      items: List.generate(
                        24,
                        (index) => DropDownItem(
                          title: 'Ilmu Penyakit Dalam',
                          value: index,
                        ),
                      ),
                    ).addMarginBottom(20),
                    const LabelText(
                      text: 'Penyakit',
                    ).addMarginBottom(8),
                    MultiDropdownField(
                      hint: 'Pilih Jenis Penyakit',
                      controller: diseaseController,
                      items: List.generate(
                        24,
                        (index) => DropDownItem(
                          title: 'Infeksi saluran kemih',
                          value: index,
                        ),
                      ),
                    ).addMarginBottom(6),
                    Text(
                      '*dapat pilih lebih dari satu',
                      style: Themes()
                          .gray12
                          ?.copyWith(fontStyle: FontStyle.italic),
                    ).addMarginBottom(20),
                    const LabelText(
                      text: 'Keterampilan',
                    ).addMarginBottom(8),
                    MultiDropdownField(
                      hint: 'Pilih Jenis Keterampilan',
                      controller: diseaseController,
                      items: List.generate(
                        24,
                        (index) => DropDownItem(
                          title: 'Makan Cepat',
                          value: index,
                        ),
                      ),
                    ).addMarginBottom(6),
                    Text(
                      '*dapat pilih lebih dari satu',
                      style: Themes()
                          .gray12
                          ?.copyWith(fontStyle: FontStyle.italic),
                    ).addMarginBottom(20),
                    const LabelText(
                      text: 'Prosedur',
                    ).addMarginBottom(8),
                    MultiDropdownField(
                      hint: 'Pilih Jenis Prosedur',
                      controller: diseaseController,
                      items: List.generate(
                        24,
                        (index) => DropDownItem(
                          title: 'Keamanan',
                          value: index,
                        ),
                      ),
                    ).addMarginBottom(6),
                    Text(
                      '*dapat pilih lebih dari satu',
                      style: Themes()
                          .gray12
                          ?.copyWith(fontStyle: FontStyle.italic),
                    ).addMarginBottom(20),
                    const LabelText(
                      text: 'Gejala',
                    ).addMarginBottom(8),
                    MultiDropdownField(
                      hint: 'Pilih Jenis Gejala',
                      controller: diseaseController,
                      items: List.generate(
                        24,
                        (index) => DropDownItem(
                          title: 'Gejala alam',
                          value: index,
                        ),
                      ),
                    ).addMarginBottom(6),
                    Text(
                      '*dapat pilih lebih dari satu',
                      style: Themes()
                          .gray12
                          ?.copyWith(fontStyle: FontStyle.italic),
                    ).addMarginBottom(20),
                    const LabelText(
                      text: 'Catatan',
                    ).addMarginBottom(8),
                    SizedBox(
                      height: 300,
                      child: RichTextEditor(
                        controller: noteController,
                      ),
                    ).addMarginBottom(20),
                    const LabelText(
                      text: 'Lampiran',
                    ).addMarginBottom(8),
                    FilePickerButton(
                      controller: filePickerController,
                    ).addMarginBottom(8),
                    Text(
                      'pdf, jpg, png, xlsx, xls, jpeg, docx, doc, csv, txt, ppt, pptx with maximum size 10MB',
                      style: Themes().gray12,
                    ).addMarginBottom(20),
                  ],
                ),
              ),
            ).addExpanded,
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
