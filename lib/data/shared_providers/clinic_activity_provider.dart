import 'dart:convert';
import 'dart:io';

import 'package:clerkship/data/models/dropdown_item.dart';
import 'package:clerkship/data/models/existing_lampiran.dart';
import 'package:clerkship/ui/components/buttons/file_picker_button.dart';
import 'package:clerkship/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../ui/components/dialog/custom_alert_dialog.dart';
import '../../ui/screens/clinic_activity/providers/item_list_all_provider.dart';
import '../../ui/screens/clinic_activity/providers/item_list_approve_provider.dart';
import '../../ui/screens/clinic_activity/providers/item_list_draft_provider.dart';
import '../../ui/screens/clinic_activity/providers/item_list_reject_provider.dart';
import '../../ui/screens/clinic_detail_approval/clinic_detail_approval_screen.dart';
import '../../utils/dialog_helper.dart';
import '../../utils/nav_helper.dart';
import '../models/item_clinic.dart';
import '../network/entity/clinic_detail_response.dart';
import '../network/services/clinic_activity_service.dart';

class ClinicActivityProvider extends ChangeNotifier {
  final clinicActivityService = getIt<ClinicActivityService>();
  HeaderClinic headerClinic = HeaderClinic();
  final List<ClinicDetailItem> penyakit = [];
  final List<ClinicDetailItem> keterampilan = [];
  final List<ClinicDetailItem> prosedur = [];
  final List<ClinicDetailItem> gejala = [];
  final List<ClinicDocument> listDocument = [];
  ClinicDetailItem jenisKegiatan = ClinicDetailItem(
    namaItem: '',
  );

  Future deleteClinic({
    required int id,
  }) async {
    DialogHelper.showProgressDialog();

    final result = await clinicActivityService.deleteClinic(id: id);
    NavHelper.pop();
    if (result.statusCode == 200) {
      notifyListeners();
      NavHelper.pop();
      DialogHelper.showMessageDialog(
        title: 'Dihapus',
        body: result.data?.message.toString(),
        alertType: AlertType.sucecss,
      );
    } else {
      DialogHelper.showMessageDialog(
        title: 'Error',
        body: result.data?.message.toString(),
        alertType: AlertType.error,
      );
    }
  }

  Future getDetailClinic({
    required int id,
  }) async {
    // loading = true;
    // notifyListeners();
    final result = await clinicActivityService.getDetailClinic(id: id);
    if (result.statusCode == 200) {
      penyakit.clear();
      keterampilan.clear();
      prosedur.clear();
      gejala.clear();
      listDocument.clear();
      headerClinic = result.data!.data!.header!;
      for (ClinicDetailItem row in result.data!.data!.detail!) {
        switch (row.idJenis) {
          case 1:
            jenisKegiatan = row;
            break;
          case 2:
            penyakit.add(row);
            break;
          case 3:
            keterampilan.add(row);
            break;
          case 4:
            prosedur.add(row);
            break;
          case 5:
            gejala.add(row);
            break;
        }
      }

      listDocument.addAll(result.data!.data!.document!);
      // loading = false;
      notifyListeners();
    }
  }

  void updateClinicActivity({
    required BuildContext context,
    required int id,
    required DateTime tanggal,
    required TimeOfDay jam,
    required String status,
    required DropDownItem departemen,
    required DropDownItem jenisKegiatan,
    dynamic preseptor,
    List<DropDownItem>? penyakit,
    List<DropDownItem>? keterampilan,
    List<DropDownItem>? prosedur,
    List<DropDownItem>? gejala,
    String? catatan,
    List<ExistingLampiran>? existingDocument,
    List<SelectedFile>? lampiran,
  }) async {
    var bodyTgl = tanggal.formatDate('yyyy-MM-dd');
    var bodyJam =
        '${jam.hour.toString().padLeft(2, '0')}:${jam.minute.toString().padLeft(2, '0')}';
    var bodyDepartemen = departemen.value;
    var bodyPreseptor = preseptor;
    var bodyRemarks = catatan;
    List<ItemClinic> bodyItem = [];
    List<File> fileLampiran = [];

    for (SelectedFile item in lampiran!) {
      if (existingDocument!
          .where((element) => element.id.toString() != item.id)
          .isEmpty) {
        fileLampiran.add(item.file);
      }
    }

    bodyItem.add(ItemClinic(
      idJenis: 1,
      idItem: jenisKegiatan.value,
      type: 0,
      remarks: null,
      counter: 0,
      flagDelete: jenisKegiatan.flagDelete,
      id: jenisKegiatan.id,
    ));

    for (DropDownItem item in penyakit!) {
      if (item.value == -1) {
        bodyItem.add(ItemClinic(
          idJenis: 2,
          idItem: item.value,
          type: 1,
          remarks: item.title,
          counter: 0,
          flagDelete: item.flagDelete,
          id: item.id,
        ));
      } else {
        bodyItem.add(ItemClinic(
          idJenis: 2,
          idItem: item.value,
          type: 0,
          remarks: null,
          counter: 0,
          flagDelete: item.flagDelete,
          id: item.id,
        ));
      }
    }

    for (DropDownItem item in keterampilan!) {
      bodyItem.add(ItemClinic(
        idJenis: 3,
        idItem: item.value,
        type: 0,
        remarks: null,
        counter: 0,
        flagDelete: item.flagDelete,
        id: item.id,
      ));
    }

    for (DropDownItem item in prosedur!) {
      bodyItem.add(ItemClinic(
        idJenis: 4,
        idItem: item.value,
        type: 0,
        remarks: null,
        counter: item.count,
        flagDelete: item.flagDelete,
        id: item.id,
      ));
    }

    for (DropDownItem item in gejala!) {
      bodyItem.add(ItemClinic(
        idJenis: 5,
        idItem: item.value,
        type: 0,
        remarks: null,
        counter: 0,
        flagDelete: item.flagDelete,
        id: item.id,
      ));
    }

    var bodyItemJson =
        List.generate(bodyItem.length, (index) => bodyItem[index].toJson());
    var bodyExistingJson = List.generate(
        existingDocument!.length, (index) => existingDocument[index].toJson());

    DialogHelper.showProgressDialog();
    await clinicActivityService
        .updateClinicActivity(
            id: id,
            idPreseptor: bodyPreseptor,
            tanggal: bodyTgl,
            jam: bodyJam,
            remarks: bodyRemarks ?? '',
            status: status,
            item: jsonEncode(bodyItemJson),
            lampiran: fileLampiran,
            idBatch: bodyDepartemen,
            existingLampiran: jsonEncode(bodyExistingJson))
        .then((result) {
      context.read<ItemListAllClinicProvider>().getListClinic();
      context.read<ItemListDraftClinicProvider>().getListClinic();
      context.read<ItemListApproveClinicProvider>().getListClinic();
      context.read<ItemListRejectClinicProvider>().getListClinic();
      DialogHelper.closeDialog();

      if (result.statusCode == 200) {
        Fluttertoast.showToast(msg: result.data?.message ?? 'Success');
        if (status == '2') {
          NavHelper.navigateReplace(ClinicDetailApprovalScreen(
            id: result.data!.data,
          ));
        } else {
          NavHelper.pop();
        }
      } else {
        DialogHelper.showMessageDialog(
          title: 'Error',
          body: result.data?.message.toString(),
          alertType: AlertType.error,
        );
      }
    });
  }

  Future addClinicActivity({
    required BuildContext context,
    required DateTime tanggal,
    required TimeOfDay jam,
    required String status,
    required DropDownItem departemen,
    required DropDownItem jenisKegiatan,
    dynamic preseptor,
    List<DropDownItem>? penyakit,
    List<DropDownItem>? keterampilan,
    List<DropDownItem>? prosedur,
    List<DropDownItem>? gejala,
    String? catatan,
    List<SelectedFile>? lampiran,
  }) async {
    var bodyTgl = tanggal.formatDate('yyyy-MM-dd');
    var bodyJam =
        '${jam.hour.toString().padLeft(2, '0')}:${jam.minute.toString().padLeft(2, '0')}';
    var bodyDepartemen = departemen.value;
    var bodyPreseptor = preseptor;
    var bodyRemarks = catatan;
    List<ItemClinic> bodyItem = [];
    List<File> images = [];

    for (SelectedFile item in lampiran!) {
      images.add(item.file);
    }

    bodyItem.add(ItemClinic(
      idJenis: 1,
      idItem: jenisKegiatan.value,
      type: 0,
      remarks: null,
      counter: 0,
    ));

    for (DropDownItem item in penyakit!) {
      if (item.value == -1) {
        bodyItem.add(ItemClinic(
          idJenis: 2,
          idItem: item.value,
          type: 1,
          remarks: item.title,
          counter: 0,
        ));
      } else {
        bodyItem.add(ItemClinic(
          idJenis: 2,
          idItem: item.value,
          type: 0,
          remarks: null,
          counter: 0,
        ));
      }
    }

    for (DropDownItem item in keterampilan!) {
      bodyItem.add(ItemClinic(
        idJenis: 3,
        idItem: item.value,
        type: 0,
        remarks: null,
        counter: 0,
      ));
    }

    for (DropDownItem item in prosedur!) {
      bodyItem.add(ItemClinic(
        idJenis: 4,
        idItem: item.value,
        type: 0,
        remarks: null,
        counter: item.count,
      ));
    }

    for (DropDownItem item in gejala!) {
      bodyItem.add(ItemClinic(
        idJenis: 5,
        idItem: item.value,
        type: 0,
        remarks: null,
        counter: 0,
      ));
    }

    var bodyItemJson =
        List.generate(bodyItem.length, (index) => bodyItem[index].toJson());

    DialogHelper.showProgressDialog();
    clinicActivityService
        .addClinicActivity(
            idPreseptor: bodyPreseptor,
            tanggal: bodyTgl,
            jam: bodyJam,
            remarks: bodyRemarks ?? '',
            status: status,
            item: jsonEncode(bodyItemJson),
            lampiran: images,
            idBatch: bodyDepartemen)
        .then(
      (result) {
        context.read<ItemListAllClinicProvider>().getListClinic();
        context.read<ItemListDraftClinicProvider>().getListClinic();
        context.read<ItemListApproveClinicProvider>().getListClinic();
        context.read<ItemListRejectClinicProvider>().getListClinic();
        DialogHelper.closeDialog();

        if (result.statusCode == 200) {
          Fluttertoast.showToast(msg: result.data?.message ?? 'Success');
          if (status == '2') {
            NavHelper.navigateReplace(ClinicDetailApprovalScreen(
              id: result.data!.data,
            ));
          } else {
            NavHelper.pop();
          }
        } else {
          DialogHelper.showMessageDialog(
            title: 'Error',
            body: result.data?.message.toString(),
            alertType: AlertType.error,
          );
        }
      },
    );
  }
}
