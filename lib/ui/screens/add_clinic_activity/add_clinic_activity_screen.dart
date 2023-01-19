import 'dart:convert';
import 'dart:io';

import 'package:clerkship/data/models/existing_lampiran.dart';
import 'package:clerkship/data/network/entity/batch_response.dart';
import 'package:clerkship/data/network/entity/clinic_detail_response.dart';
import 'package:clerkship/data/shared_providers/reference_provider.dart';
import 'package:clerkship/data/shared_providers/user_provider.dart';
import 'package:clerkship/utils/tools.dart';
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
import 'components/item_procedure.dart';
import 'components/label_text.dart';

class AddClinicActivityScreen extends StatefulWidget {
  final int? id;
  const AddClinicActivityScreen({super.key, this.id});

  @override
  State<AddClinicActivityScreen> createState() =>
      _AddClinicActivityScreenState();
}

class _AddClinicActivityScreenState extends State<AddClinicActivityScreen> {
  final dateController = DatePickerController();
  final timeController = TimePickerController();
  final activityTypeController = DropDownController();
  final doctorController = DoctorController();
  final departmentController = DropDownController();
  final diseaseController = MultiDropDownController();
  final skillController = MultiDropDownController();
  final procedureController = MultiDropDownController();
  final symptomsController = MultiDropDownController();
  FleatherController? noteController;
  final filePickerController = FilePickerController();
  bool loadingPage = false;
  bool isEdit = false;
  // exisiting data
  List<ExistingLampiran> listExistingLampiran = [];
  List<DropDownItem> listPenyakitSelected = [];
  List<DropDownItem> listProsedurSelected = [];
  List<DropDownItem> listKeterampilanSelected = [];
  List<DropDownItem> listGejalaSelected = [];

  @override
  void initState() {
    super.initState();

    diseaseController.setSelected([]);
    skillController.setSelected([]);
    procedureController.setSelected([]);
    symptomsController.setSelected([]);
    doctorController.setSelected([]);
    loadingPage = widget.id != null;

    Tools.onViewCreated(() async {
      if (widget.id != null) {
        isEdit = true;
        await context
            .read<ClinicActivityProvider>()
            .getDetailClinic(id: widget.id!);

        loadingPage = false;

        getdataupdate();
      } else {
        noteController = FleatherController();
        context.read<ReferenceProvider>().resetData();
        context.read<UserProvider>().resetPreseptor();
      }
    });
  }

  void getdataupdate() {
    final headerData = context.read<ClinicActivityProvider>().headerClinic;
    final jenisKegiatan = context.read<ClinicActivityProvider>().jenisKegiatan;
    final listPenyakit = context.read<ClinicActivityProvider>().penyakit;
    final listProsedur = context.read<ClinicActivityProvider>().prosedur;
    final listKeterampilan =
        context.read<ClinicActivityProvider>().keterampilan;
    final listGejala = context.read<ClinicActivityProvider>().gejala;
    final listDocument = context.read<ClinicActivityProvider>().listDocument;
    noteController = FleatherController(
        ParchmentDocument.fromJson(jsonDecode(headerData.remarks!)));

    showOtherRef(context, headerData.idFeature!);

    for (ClinicDetailItem element in listPenyakit) {
      listPenyakitSelected.add(DropDownItem(
          title: element.namaItem!, value: element.idItem, id: element.id));
    }

    for (ClinicDetailItem element in listProsedur) {
      listProsedurSelected.add(DropDownItem(
        title: element.namaItem!,
        value: element.idItem,
        count: element.counter!,
        id: element.id,
      ));
    }

    for (ClinicDetailItem element in listKeterampilan) {
      listKeterampilanSelected.add(DropDownItem(
          title: element.namaItem!, value: element.idItem, id: element.id));
    }

    for (ClinicDetailItem element in listGejala) {
      listGejalaSelected.add(DropDownItem(
          title: element.namaItem!,
          value: element.idItem,
          flagDelete: 0,
          id: element.id));
    }

    for (ClinicDocument element in listDocument) {
      listExistingLampiran.add(ExistingLampiran(
          id: element.id, fileName: element.fileName!, flagDelete: 0));

      filePickerController.addFile(File(element.fileName!),
          id: element.id.toString());
    }

    dateController.setValue(headerData.tanggal!);
    timeController.setValue(TimeOfDay(
        hour: headerData.tanggal!.hour, minute: headerData.tanggal!.minute));
    departmentController.setSelected(DropDownItem(
        title: headerData.namaDepartment!, value: headerData.idBatch));
    activityTypeController.setSelected(DropDownItem(
      title: jenisKegiatan.namaItem!,
      value: jenisKegiatan.idItem,
      id: jenisKegiatan.id,
    ));

    doctorController.setSelected(headerData.idPreseptor);
    diseaseController.setSelected(listPenyakitSelected.toList());
    skillController.setSelected(listKeterampilanSelected.toList());
    procedureController.setSelected(listProsedurSelected.toList());

    symptomsController.setSelected(listGejalaSelected.toList());
  }

  @override
  Widget build(BuildContext context) {
    final batch = context.watch<ReferenceProvider>().batch;
    final jeniskegiatan = context.watch<ReferenceProvider>().jenisKegiatan;
    final penyakit = context.watch<ReferenceProvider>().penyakit;
    final keterampilan = context.watch<ReferenceProvider>().keterampilan;
    final prosedur = context.watch<ReferenceProvider>().prosedur;
    final gejala = context.watch<ReferenceProvider>().gejala;
    final preseptor = context.watch<UserProvider>().preseptor;

    checkBtnEnable();

    return SafeStatusBar(
      child: Scaffold(
        body: Column(
          children: [
            const PrimaryAppBar(title: 'Kembali'),
            if (loadingPage)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else
              SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${isEdit ? 'Edit' : 'Tambah'} Kegiatan Klinik',
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
                      selectDepartement(batch, context).addMarginBottom(20),
                      const LabelText(
                        mandatory: true,
                        text: 'Jenis Kegiatan',
                      ).addMarginBottom(8),
                      DropdownField(
                        hint: 'Pilih Jenis Kegiatan',
                        controller: activityTypeController,
                        enable: jeniskegiatan.isNotEmpty,
                        onSelected: (item) {
                          activityTypeController.selected!.flagDelete = 1;
                        },
                        items: List.generate(
                          jeniskegiatan.length,
                          (index) => DropDownItem(
                            title: jeniskegiatan[index].name!,
                            value: jeniskegiatan[index].id!,
                          ),
                        ),
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
                        onRemoveItem: (item) {
                          diseaseController.selected!
                              .firstWhere(
                                (element) => element.value == item.value,
                              )
                              .flagDelete = 1;
                        },
                        isOtherItem: true,
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
                        onRemoveItem: (item) {
                          skillController.selected!
                              .firstWhere(
                                (element) => element.value == item.value,
                              )
                              .flagDelete = 1;
                        },
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
                            onRemoveItem: (item) {
                              procedureController.selected!
                                  .firstWhere(
                                    (element) => element.value == item.value,
                                  )
                                  .flagDelete = 1;
                              onRemoveItem(item);
                            },
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
                        onRemoveItem: (item) {
                          if (widget.id != null) {
                            listGejalaSelected
                                .firstWhere(
                                  (element) => element.value == item.value,
                                )
                                .flagDelete = 1;
                          }
                        },
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
                          controller: noteController ?? FleatherController(),
                        ),
                      ).addMarginBottom(20),
                      const LabelText(
                        text: 'Lampiran',
                      ).addMarginBottom(8),
                      FilePickerButton(
                        controller: filePickerController,
                        onDelete: (SelectedFile file) {
                          listExistingLampiran
                              .where(
                                  (element) => element.id.toString() == file.id)
                              .first
                              .flagDelete = 1;
                        },
                      ).addMarginBottom(8),
                      Text(
                        'pdf, jpg, png, xlsx, xls, jpeg, docx, doc, csv, txt, ppt, pptx with maximum size 10MB',
                        style: Themes().gray12,
                      ).addMarginBottom(24),
                      btnSimpanClinic(context).addMarginBottom(18),
                      PrimaryButton(
                        enable: (dateController.selected != null &&
                            timeController.selected != null &&
                            departmentController.selected != null &&
                            activityTypeController.selected != null),
                        onTap: () {
                          DialogHelper.showModalConfirmation(
                              title: 'Konfirmasi Pengiriman',
                              message:
                                  'Data yang dimasukkan\ntidak akan bisa diubah lagi.',
                              positiveText: 'Kirim untuk Disetujui',
                              negativeText: 'Batal',
                              onPositiveTap: () {
                                NavHelper.pop();

                                if (dateController.selected == null ||
                                    timeController.selected == null ||
                                    departmentController.selected == null) {
                                  return;
                                }
                                if (widget.id != null) {
                                  doUpdateClinic(context, '2');
                                } else {
                                  context
                                      .read<ClinicActivityProvider>()
                                      .addClinicActivity(
                                        context: context,
                                        status: '2',
                                        tanggal: dateController.selected!,
                                        jam: timeController.selected!,
                                        departemen:
                                            departmentController.selected!,
                                        jenisKegiatan:
                                            activityTypeController.selected!,
                                        catatan: jsonEncode(
                                            noteController?.document.toJson()),
                                        gejala: symptomsController.selected,
                                        keterampilan: skillController.selected,
                                        lampiran:
                                            filePickerController.selectedFiles,
                                        penyakit: diseaseController.selected,
                                        prosedur: procedureController.selected,
                                        preseptor: doctorController.selected,
                                      );
                                }
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

  SecondaryButton btnSimpanClinic(BuildContext context) {
    return SecondaryButton(
      onTap: () {
        if (dateController.selected == null ||
            timeController.selected == null ||
            departmentController.selected == null) return;

        if (widget.id == null) {
          context.read<ClinicActivityProvider>().addClinicActivity(
                context: context,
                status: '0',
                tanggal: dateController.selected!,
                jam: timeController.selected!,
                departemen: departmentController.selected!,
                jenisKegiatan: activityTypeController.selected!,
                catatan: jsonEncode(noteController?.document.toJson()),
                gejala: symptomsController.selected,
                keterampilan: skillController.selected,
                lampiran: filePickerController.selectedFiles,
                penyakit: diseaseController.selected,
                prosedur: procedureController.selected,
                preseptor: doctorController.selected,
              );
        } else {
          doUpdateClinic(context, '0');
        }
      },
      text: 'Simpan Perubahan',
      enable: (dateController.selected != null &&
          timeController.selected != null &&
          departmentController.selected != null &&
          activityTypeController.selected != null),
    );
  }

  void doUpdateClinic(BuildContext context, String status) {
    listProsedurSelected.removeWhere((element) => element.flagDelete == 0);
    listProsedurSelected.addAll(procedureController.selected ?? []);

    listPenyakitSelected.removeWhere((element) => element.flagDelete == 0);
    listPenyakitSelected.addAll(diseaseController.selected ?? []);

    listKeterampilanSelected.removeWhere((element) => element.flagDelete == 0);
    listKeterampilanSelected.addAll(skillController.selected ?? []);

    listGejalaSelected.removeWhere((element) => element.flagDelete == 0);
    listGejalaSelected.addAll(symptomsController.selected ?? []);

    List<SelectedFile> newFile = [];
    if (filePickerController.selectedFiles.isNotEmpty &&
        listExistingLampiran.isNotEmpty) {
      filePickerController.selectedFiles.where((element) {
        return listExistingLampiran
            .where((e) => e.id.toString() != element.id)
            .isNotEmpty;
      }).forEach((element) {
        newFile.add(element);
      });
    } else {
      newFile.addAll(filePickerController.selectedFiles);
    }

    context.read<ClinicActivityProvider>().updateClinicActivity(
        context: context,
        id: widget.id!,
        status: status,
        tanggal: dateController.selected!,
        jam: timeController.selected!,
        departemen: departmentController.selected!,
        jenisKegiatan: activityTypeController.selected!,
        catatan: jsonEncode(noteController?.document.toJson()),
        gejala: listGejalaSelected,
        keterampilan: listKeterampilanSelected,
        lampiran: newFile,
        existingDocument: listExistingLampiran,
        penyakit: listPenyakitSelected,
        prosedur: listProsedurSelected,
        preseptor: doctorController.selected);
  }

  void checkBtnEnable() {
    dateController.addListener(() {
      setState(() {});
    });
    timeController.addListener(() {
      setState(() {});
    });
    activityTypeController.addListener(() {
      setState(() {});
    });
    doctorController.addListener(() {
      setState(() {});
    });
    departmentController.addListener(() {
      setState(() {});
    });
  }

  DropdownField selectDepartement(List<Batch> batch, BuildContext context) {
    return DropdownField(
      hint: 'Pilih Departemen',
      controller: departmentController,
      items: List.generate(
        batch.length,
        (index) => DropDownItem(
          title: batch[index].feature!.name!,
          value: batch[index].id!,
        ),
      ),
      onSelected: (item) {
        diseaseController.setSelected([]);
        skillController.setSelected([]);
        procedureController.setSelected([]);
        symptomsController.setSelected([]);
        doctorController.setSelected([]);

        var idDepartemen = batch.where((element) => element.id == item.value);

        if (idDepartemen.isEmpty) {
          return;
        }
        showOtherRef(context, idDepartemen.first.feature!.id!);

        setState(() {});
      },
    );
  }

  void showOtherRef(BuildContext context, int id) {
    context.read<ReferenceProvider>().getJenisKegiatan(departemenId: id);

    context.read<ReferenceProvider>().getPenyakit(departemenId: id);

    context.read<ReferenceProvider>().getGejala(departemenId: id);

    context.read<ReferenceProvider>().getKeterampilan(departemenId: id);

    context.read<ReferenceProvider>().getProsedur(departemenId: id);

    context.read<UserProvider>().getPreseptor(
          departemenId: id,
        );
  }
}
