import 'dart:convert';
import 'dart:io';

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
import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../data/models/existing_lampiran.dart';
import '../../../data/network/entity/batch_response.dart';
import '../../../data/network/entity/scientific_detail_response.dart';
import '../../../data/shared_providers/reference_provider.dart';
import '../../../data/shared_providers/scientific_provider.dart';
import '../../../data/shared_providers/user_provider.dart';
import '../../../utils/dialog_helper.dart';
import '../../../utils/nav_helper.dart';
import '../../../utils/tools.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/buttons/secondary_button.dart';
import '../add_clinic_activity/components/label_text.dart';

class AddScientificEventScreen extends StatefulWidget {
  final int? id;
  const AddScientificEventScreen({super.key, this.id});

  @override
  State<AddScientificEventScreen> createState() =>
      _AddScientificEventScreenState();
}

class _AddScientificEventScreenState extends State<AddScientificEventScreen> {
  final dateController = DatePickerController();

  final timeController = TimePickerController();

  final activityController = DropDownController();

  final roleController = DropDownController();

  final departementController = DropDownController();

  final mentorController = DoctorController();

  FleatherController? noteController;

  final attachmentController = FilePickerController();

  final topicController = TextEditingController();

  bool loadingPage = false;
  bool isEdit = false;

  // exisiting data
  List<ExistingLampiran> listExistingLampiran = [];

  @override
  void initState() {
    super.initState();

    loadingPage = widget.id != null;
    Tools.onViewCreated(() async {
      if (widget.id != null) {
        isEdit = true;
        await context
            .read<ScientificActivityProvider>()
            .getDetailScientific(id: widget.id!);

        loadingPage = false;
        getdataupdate();
      } else {
        noteController = FleatherController();
        context.read<ReferenceProvider>().resetData();
        context.read<UserProvider>().resetPreseptor();
      }
    });
    loadingPage = widget.id != null;
  }

  @override
  Widget build(BuildContext context) {
    final batch = context.watch<ReferenceProvider>().batch;
    final jeniskegiatan =
        context.watch<ReferenceProvider>().jenisKegiatanScientific;
    final peran = context.watch<ReferenceProvider>().peran;
    final preseptor = context.watch<UserProvider>().preseptor;

    checkBtnEnable();

    return SafeStatusBar(
      child: Scaffold(
        body: Column(
          children: [
            const PrimaryAppBar(
              title: 'Kembali',
            ),
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
                        '${isEdit ? 'Edit' : 'Tambah'} Acara Ilmiah',
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
                        mandatory: true,
                        text: 'Departemen',
                      ).addMarginBottom(8),
                      selectDepartement(batch, context).addMarginBottom(20),
                      const LabelText(
                        text: 'Kegiatan Acara',
                        mandatory: true,
                      ).addMarginBottom(8),
                      DropdownField(
                        controller: activityController,
                        hint: 'Pilih Jenis Acara',
                        enable: jeniskegiatan.isNotEmpty,
                        items: List.generate(
                          jeniskegiatan.length,
                          (index) => DropDownItem(
                            title: jeniskegiatan[index].name!,
                            value: jeniskegiatan[index].id!,
                          ),
                        ),
                      ).addMarginBottom(20),
                      const LabelText(
                        text: 'Peran',
                        mandatory: true,
                      ).addMarginBottom(8),
                      DropdownField(
                        controller: roleController,
                        enable: peran.isNotEmpty,
                        hint: 'Pilih Peran',
                        items: List.generate(
                          peran.length,
                          (index) => DropDownItem(
                            title: peran[index].name!,
                            value: peran[index].id!,
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
                          preseptor.length,
                          (index) => Doctor(
                            title: preseptor[index].name!,
                            value: preseptor[index].id!,
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
                          controller: noteController ?? FleatherController(),
                        ),
                      ).addMarginBottom(20),
                      const LabelText(
                        text: 'Tautan',
                      ).addMarginBottom(8),
                      FilePickerButton(
                        controller: attachmentController,
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
                      SecondaryButton(
                        onTap: () {
                          if (dateController.selected == null ||
                              timeController.selected == null ||
                              departementController.selected == null ||
                              activityController.selected == null ||
                              roleController.selected == null ||
                              topicController.text.isEmpty) {
                            return;
                          }

                          if (widget.id == null) {
                            context
                                .read<ScientificActivityProvider>()
                                .addScientificActivity(
                                  context: context,
                                  status: '0',
                                  tanggal: dateController.selected!,
                                  jam: timeController.selected!,
                                  departemen: departementController.selected!,
                                  jenisKegiatan: activityController.selected!,
                                  catatan: jsonEncode(
                                      noteController?.document.toJson()),
                                  preseptor: mentorController.selected,
                                  peran: roleController.selected!,
                                  topik: topicController.text,
                                  lampiran: attachmentController.selectedFiles,
                                );
                          } else {
                            doUpdateScientific(context, '0');
                          }
                        },
                        text: 'Simpan Perubahan',
                        enable: (dateController.selected != null &&
                            timeController.selected != null &&
                            departementController.selected != null &&
                            activityController.selected != null &&
                            roleController.selected != null &&
                            topicController.text.isNotEmpty),
                      ).addMarginBottom(18),
                      PrimaryButton(
                        enable: (dateController.selected != null &&
                            timeController.selected != null &&
                            departementController.selected != null &&
                            activityController.selected != null &&
                            roleController.selected != null &&
                            topicController.text.isNotEmpty),
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
                                  departementController.selected == null ||
                                  activityController.selected == null ||
                                  roleController.selected == null ||
                                  topicController.text.isEmpty) {
                                return;
                              }
                              if (widget.id != null) {
                                doUpdateScientific(context, '2');
                              } else {
                                context
                                    .read<ScientificActivityProvider>()
                                    .addScientificActivity(
                                      context: context,
                                      status: '2',
                                      tanggal: dateController.selected!,
                                      jam: timeController.selected!,
                                      departemen:
                                          departementController.selected!,
                                      jenisKegiatan:
                                          activityController.selected!,
                                      catatan: jsonEncode(
                                          noteController?.document.toJson()),
                                      preseptor: mentorController.selected,
                                      peran: roleController.selected!,
                                      topik: topicController.text,
                                      lampiran:
                                          attachmentController.selectedFiles,
                                    );
                              }
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

  DropdownField selectDepartement(List<Batch> batch, BuildContext context) {
    return DropdownField(
      hint: 'Pilih Departemen',
      controller: departementController,
      items: List.generate(
        batch.length,
        (index) => DropDownItem(
          title: batch[index].feature!.name!,
          value: batch[index].id!,
        ),
      ),
      onSelected: (item) {
        loadingPage = widget.id != null;

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
    context
        .read<ReferenceProvider>()
        .getJenisKegiatanScientific(departemenId: id);
    context.read<ReferenceProvider>().getPeran();
    context.read<UserProvider>().getPreseptor(
          departemenId: id,
        );
  }

  void doUpdateScientific(BuildContext context, String status) {
    List<SelectedFile> newFile = [];
    if (attachmentController.selectedFiles.isNotEmpty &&
        listExistingLampiran.isNotEmpty) {
      attachmentController.selectedFiles.where((element) {
        return listExistingLampiran
            .where((e) => e.id.toString() != element.id)
            .isNotEmpty;
      }).forEach((element) {
        newFile.add(element);
      });
    } else {
      newFile.addAll(attachmentController.selectedFiles);
    }

    context.read<ScientificActivityProvider>().updateScientificActivity(
          context: context,
          id: widget.id!,
          status: status,
          tanggal: dateController.selected!,
          jam: timeController.selected!,
          departemen: departementController.selected!,
          jenisKegiatan: activityController.selected!,
          catatan: jsonEncode(noteController?.document.toJson()),
          existingDocument: listExistingLampiran,
          preseptor: mentorController.selected,
          topik: topicController.text,
          lampiran: newFile,
          peran: roleController.selected!,
        );
  }

  void checkBtnEnable() {
    dateController.addListener(() {
      setState(() {});
    });
    timeController.addListener(() {
      setState(() {});
    });
    activityController.addListener(() {
      setState(() {});
    });
    mentorController.addListener(() {
      setState(() {});
    });
    departementController.addListener(() {
      setState(() {});
    });
    roleController.addListener(() {
      setState(() {});
    });
    topicController.addListener(() {
      setState(() {});
    });
  }

  void getdataupdate() {
    final headerData =
        context.read<ScientificActivityProvider>().headerScientific;
    final jenisKegiatan =
        context.read<ScientificActivityProvider>().jenisKegiatan;
    final listDocument =
        context.read<ScientificActivityProvider>().listDocument;
    noteController = FleatherController(
        ParchmentDocument.fromJson(jsonDecode(headerData.remarks!)));

    showOtherRef(context, headerData.idFeature!);

    for (ScientificDocument element in listDocument) {
      listExistingLampiran.add(ExistingLampiran(
          id: element.id, fileName: element.fileName!, flagDelete: 0));

      attachmentController.addFile(File(element.fileName!),
          id: element.id.toString());
    }

    dateController.setValue(headerData.tanggal!);
    timeController.setValue(TimeOfDay(
        hour: headerData.tanggal!.hour, minute: headerData.tanggal!.minute));
    departementController.setSelected(DropDownItem(
        title: headerData.namaDepartment!, value: headerData.idBatch));
    activityController.setSelected(DropDownItem(
      title: jenisKegiatan.namaItem!,
      value: jenisKegiatan.idItem,
      id: jenisKegiatan.id,
    ));

    mentorController.setSelected(headerData.idPreseptor);
    roleController.setSelected(
        DropDownItem(title: headerData.namaPeran!, value: headerData.idPeran));
    topicController.text = headerData.topik!;
  }
}
