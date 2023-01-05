import 'package:clerkship/data/shared_providers/reference_provider.dart';
import 'package:clerkship/data/shared_providers/user_provider.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/models/doctor.dart';
import '../../../data/models/dropdown_item.dart';
import '../../../data/shared_providers/clinic_activity_provider.dart';
import '../../../utils/dialog_helper.dart';
import '../../../utils/nav_helper.dart';
import '../../components/buttons/date_picker_button.dart';
import '../../components/buttons/doctor_field.dart';
import '../../components/buttons/dropdown_field.dart';
import '../../components/buttons/file_picker_button.dart';
import '../../components/buttons/multi_dropdown_field.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/buttons/secondary_button.dart';
import '../../components/buttons/time_picker_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import '../../components/textareas/rich_text_editor.dart';
import '../clinic_detail_approval/clinic_detail_approval_screen.dart';
import 'components/item_procedure.dart';
import 'components/label_text.dart';

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
    final departemen = context.watch<ReferenceProvider>().departemen;
    final jeniskegiatan = context.watch<ReferenceProvider>().jenisKegiatan;
    final penyakit = context.watch<ReferenceProvider>().penyakit;
    final keterampilan = context.watch<ReferenceProvider>().keterampilan;
    final prosedur = context.watch<ReferenceProvider>().prosedur;
    final gejala = context.watch<ReferenceProvider>().gejala;
    final preseptor = context.watch<UserProvider>().preseptor;

    return SafeStatusBar(
      child: Scaffold(
        body: Column(
          children: [
            const PrimaryAppBar(title: 'Kembali'),
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                      text: 'Departemen',
                    ).addMarginBottom(8),
                    DropdownField(
                      hint: 'Pilih Departemen',
                      controller: departmentController,
                      items: List.generate(
                        departemen.length,
                        (index) => DropDownItem(
                          title: departemen[index].name!,
                          value: departemen[index].id!,
                        ),
                      ),
                      onSelected: (item) {
                        activityTypeController.setSelected([]);
                        diseaseController.setSelected([]);
                        skillController.setSelected([]);
                        procedureController.setSelected([]);
                        symptomsController.setSelected([]);
                        doctorController.setSelected([]);

                        context
                            .read<ReferenceProvider>()
                            .getJenisKegiatan(departemenId: item.value);

                        context
                            .read<ReferenceProvider>()
                            .getPenyakit(departemenId: item.value);

                        context
                            .read<ReferenceProvider>()
                            .getGejala(departemenId: item.value);

                        context
                            .read<ReferenceProvider>()
                            .getKeterampilan(departemenId: item.value);

                        context
                            .read<ReferenceProvider>()
                            .getProsedur(departemenId: item.value);

                        context.read<UserProvider>().getPreseptor(
                              departemenId: item.value,
                            );
                      },
                    ).addMarginBottom(20),
                    const LabelText(
                      mandatory: true,
                      text: 'Jenis Kegiatan',
                    ).addMarginBottom(8),
                    MultiDropdownField(
                      hint: 'Pilih Jenis Kegiatan',
                      controller: activityTypeController,
                      enable: jeniskegiatan.isNotEmpty,
                      items: List.generate(
                        jeniskegiatan.length,
                        (index) => DropDownItem(
                          title: jeniskegiatan[index].name!,
                          value: jeniskegiatan[index].id!,
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
                      enable: preseptor.isNotEmpty,
                      items: List.generate(
                        preseptor.length,
                        (index) => Doctor(
                          title: preseptor[index].name!,
                          value: preseptor[index].id!,
                        ),
                      ),
                    ).addMarginBottom(20),
                    const LabelText(
                      text: 'Penyakit',
                    ).addMarginBottom(8),
                    MultiDropdownField(
                      hint: 'Pilih Jenis Penyakit',
                      otherHint: 'Tulis Penyakit',
                      controller: diseaseController,
                      enable: penyakit.isNotEmpty,
                      items: List.generate(
                        penyakit.length,
                        (index) => DropDownItem(
                          title: penyakit[index].name!,
                          value: penyakit[index].id!,
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
                      otherHint: 'Tulis Keterampilan',
                      hint: 'Pilih Jenis Keterampilan',
                      controller: skillController,
                      enable: keterampilan.isNotEmpty,
                      items: List.generate(
                        keterampilan.length,
                        (index) => DropDownItem(
                          title: keterampilan[index].name!,
                          value: keterampilan[index].id!,
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
                      otherHint: 'Tulis Prosedur',
                      hint: 'Pilih Jenis Prosedur',
                      controller: procedureController,
                      enable: prosedur.isNotEmpty,
                      customItem: (item, onRemoveItem) {
                        return ItemProcedure(
                          item: item,
                          onRemoveItem: onRemoveItem,
                          procedureController: procedureController,
                        ).addMarginBottom(8);
                      },
                      items: List.generate(
                        prosedur.length,
                        (index) => DropDownItem(
                          title: prosedur[index].name!,
                          value: prosedur[index].id!,
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
                      otherHint: 'Tulis Gejala',
                      hint: 'Pilih Jenis Gejala',
                      controller: symptomsController,
                      enable: gejala.isNotEmpty,
                      items: List.generate(
                        gejala.length,
                        (index) => DropDownItem(
                          title: gejala[index].name!,
                          value: gejala[index].id!,
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
                    ).addMarginBottom(24),
                    SecondaryButton(
                      onTap: () {
                        if (dateController.selected == null ||
                            timeController.selected == null ||
                            departmentController.selected == null) return;

                        context
                            .read<ClinicActivityProvider>()
                            .addClinicActivity(
                              tanggal: dateController.selected!,
                              jam: timeController.selected!,
                              departemen: departmentController.selected!,
                              jenisKegiatan:
                                  activityTypeController.selected ?? [],
                              catatan: noteController.selection,
                              gejala: symptomsController.selected,
                              keterampilan: skillController.selected,
                              lampiran: filePickerController.selectedFiles,
                              penyakit: diseaseController.selected,
                              prosedur: procedureController.selected,
                              preseptor: doctorController.selected,
                            );
                      },
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
                              NavHelper.navigateReplace(
                                const ClinicDetailApprovalScreen(),
                              );
                            });
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
