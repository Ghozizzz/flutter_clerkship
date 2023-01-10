import 'dart:convert';
import 'dart:io';

import 'package:clerkship/data/models/dropdown_item.dart';
import 'package:clerkship/ui/components/buttons/file_picker_button.dart';
import 'package:clerkship/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../main.dart';
import '../../ui/components/dialog/custom_alert_dialog.dart';
import '../../ui/screens/clinic_detail_approval/clinic_detail_approval_screen.dart';
import '../../utils/dialog_helper.dart';
import '../../utils/nav_helper.dart';
import '../models/item_clinic.dart';
import '../network/services/clinic_activity_service.dart';

class ClinicActivityProvider extends ChangeNotifier {
  final clinicActivityService = getIt<ClinicActivityService>();

  void addClinicActivity({
    required DateTime tanggal,
    required TimeOfDay jam,
    required DropDownItem departemen,
    List<DropDownItem>? jenisKegiatan,
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

    for (DropDownItem item in jenisKegiatan!) {
      bodyItem.add(ItemClinic(
        idJenis: 1,
        idItem: item.value,
        type: 0,
        remarks: null,
        counter: 0,
      ));
    }

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
    final result = await clinicActivityService.addClinicActivity(
        idPreseptor: bodyPreseptor,
        tanggal: bodyTgl,
        jam: bodyJam,
        remarks: bodyRemarks ?? '',
        status: '0',
        item: jsonEncode(bodyItemJson),
        lampiran: images,
        idBatch: bodyDepartemen);
    DialogHelper.closeDialog();

    if (result.statusCode == 200) {
      Fluttertoast.showToast(msg: result.data?.message ?? 'Success');
      NavHelper.navigateReplace(const ClinicDetailApprovalScreen());
    } else {
      DialogHelper.showMessageDialog(
        title: 'Error',
        body: result.data?.message.toString(),
        alertType: AlertType.error,
      );
    }
  }
}
