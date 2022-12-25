import 'package:clerkship/config/themes.dart';
import 'package:clerkship/data/models/doctor.dart';
import 'package:clerkship/data/models/dropdown_item.dart';
import 'package:clerkship/ui/components/buttons/date_picker_button.dart';
import 'package:clerkship/ui/components/buttons/doctor_field.dart';
import 'package:clerkship/ui/components/buttons/dropdown_field.dart';
import 'package:clerkship/ui/components/buttons/file_picker_button.dart';
import 'package:clerkship/ui/components/buttons/time_picker_button.dart';
import 'package:clerkship/ui/components/commons/primary_appbar.dart';
import 'package:clerkship/ui/components/commons/safe_statusbar.dart';
import 'package:clerkship/ui/components/textareas/rich_text_editor.dart';
import 'package:clerkship/ui/components/textareas/textarea.dart';
import 'package:clerkship/ui/screens/add_clinic_activity/components/label_text.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../utils/dialog_helper.dart';
import '../../../utils/nav_helper.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/buttons/secondary_button.dart';

class AddScientificEventScreen extends StatelessWidget {
  AddScientificEventScreen({super.key});

  final dateController = DatePickerController();
  final timeController = TimePickerController();
  final activityController = DropDownController();
  final roleController = DropDownController();
  final departementController = DropDownController();
  final mentorController = DoctorController();
  final noteController = FleatherController();
  final attachmentController = FilePickerController();
  final topicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeStatusBar(
      child: Scaffold(
        body: Column(
          children: [
            const PrimaryAppBar(
              title: 'Kembali',
            ),
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tambah Acara Ilmiah',
                      style: Themes().primaryBold20,
                    ).addMarginBottom(32),
                    const LabelText(
                      text: 'Tanggal & Jam',
                      mandatory: true,
                    ).addMarginBottom(8),
                    DatePickerButton(
                      controller: dateController,
                    ).addMarginBottom(20),
                    TimePickerButton(
                      controller: timeController,
                    ).addMarginBottom(20),
                    const LabelText(
                      text: 'Kegiatan Acara',
                      mandatory: true,
                    ).addMarginBottom(8),
                    DropdownField(
                      controller: activityController,
                      hint: 'Pilih Jenis Acara',
                      items: List.generate(
                        4,
                        (index) => DropDownItem(
                          title: 'Mini Referat',
                          value: index,
                        ),
                      ),
                    ).addMarginBottom(20),
                    const LabelText(
                      text: 'Peran',
                      mandatory: true,
                    ).addMarginBottom(8),
                    DropdownField(
                      controller: roleController,
                      hint: 'Pilih Peran',
                      items: List.generate(
                        4,
                        (index) => DropDownItem(
                          title: 'Peserta',
                          value: index,
                        ),
                      ),
                    ).addMarginBottom(20),
                    const LabelText(
                      text: 'Departemen',
                      mandatory: true,
                    ).addMarginBottom(8),
                    DropdownField(
                      controller: departementController,
                      hint: 'Pilih Departemen',
                      items: List.generate(
                        4,
                        (index) => DropDownItem(
                          title: 'Ilmu Penyakit Dalam',
                          value: index,
                        ),
                      ),
                    ).addMarginBottom(20),
                    const LabelText(
                      text: 'Pembimbing',
                      mandatory: true,
                    ).addMarginBottom(8),
                    DoctorField(
                      controller: mentorController,
                      hint: 'Pilih Pembimbing',
                      items: List.generate(
                        4,
                        (index) => Doctor(
                          title: 'Dr. Budiman',
                          value: index,
                        ),
                      ),
                    ).addMarginBottom(20),
                    const LabelText(
                      text: 'Topik',
                      mandatory: true,
                    ).addMarginBottom(8),
                    TextArea(
                      controller: topicController,
                      hint: 'Judul Topik',
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
                      text: 'Tautan',
                    ).addMarginBottom(8),
                    FilePickerButton(
                      controller: attachmentController,
                    ).addMarginBottom(8),
                    Text(
                      'pdf, jpg, png, xlsx, xls, jpeg, docx, doc, csv, txt, ppt, pptx with maximum size 10MB',
                      style: Themes().gray12,
                    ).addMarginBottom(24),
                    SecondaryButton(
                      onTap: () {},
                      text: 'Simpan Perubahan',
                    ).addMarginBottom(18),
                    PrimaryButton(
                      onTap: () {
                        DialogHelper.showModalConfirmation(
                          title: 'Konfirmasi Pengiriman',
                          message:
                              'Data yang dimasukkan\ntidak akan bisa diubah lagi.',
                          positiveText: 'Kirim untuk Disetujui',
                          negativeText: 'Batal',
                          onPositiveTap: () {
                            NavHelper.pop();
                            // NavHelper.navigateReplace(
                            //   const DetailApprovalScreen(),
                            // );
                          },
                        );
                      },
                      text: 'Kirim untuk Disetujui',
                    ).addMarginBottom(20.w),
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
