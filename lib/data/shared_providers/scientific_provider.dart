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
import '../../ui/screens/scientific_event/providers/item_list_all_provider.dart';
import '../../ui/screens/scientific_event/providers/item_list_approve_provider.dart';
import '../../ui/screens/scientific_event/providers/item_list_draft_provider.dart';
import '../../ui/screens/scientific_event/providers/item_list_reject_provider.dart';
import '../../ui/screens/scientific_event_detail_approval/scientific_event_approval_screen.dart';
import '../../utils/dialog_helper.dart';
import '../../utils/nav_helper.dart';
import '../models/item_scientific.dart';
import '../network/entity/scientific_detail_response.dart';
import '../network/services/scientific_activity_service.dart';

class ScientificActivityProvider extends ChangeNotifier {
  final scientificActivityService = getIt<ScientificActivityService>();
  HeaderScientific headerScientific = HeaderScientific();
  final List<ScientificDocument> listDocument = [];
  ScientificDetailItem jenisKegiatan = ScientificDetailItem(
    namaItem: '',
  );

  Future deleteScientific({
    required BuildContext context,
    required int id,
  }) async {
    DialogHelper.showProgressDialog();

    await scientificActivityService.deleteScientific(id: id).then((result) {
      context.read<ItemListAllScientificProvider>().getListScientific();
      context.read<ItemListDraftScientificProvider>().getListScientific();
      context.read<ItemListApproveScientificProvider>().getListScientific();
      context.read<ItemListRejectScientificProvider>().getListScientific();
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
    });
  }

  Future getDetailScientific({
    required int id,
  }) async {
    // loading = true;
    // notifyListeners();
    final result = await scientificActivityService.getDetailScientific(id: id);
    if (result.statusCode == 200) {
      listDocument.clear();
      headerScientific = result.data!.data!.header!;
      for (ScientificDetailItem row in result.data!.data!.detail!) {
        switch (row.idJenis) {
          case 7:
            jenisKegiatan = row;
            break;
        }
      }

      listDocument.addAll(result.data!.data!.document!);
      // loading = false;
      notifyListeners();
    }
  }

  void updateScientificActivity({
    required BuildContext context,
    required int id,
    required DateTime tanggal,
    required TimeOfDay jam,
    required String status,
    required DropDownItem departemen,
    required DropDownItem jenisKegiatan,
    required DropDownItem peran,
    required String topik,
    dynamic preseptor,
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
    List<ItemScientific> bodyItem = [];
    List<File> fileLampiran = [];

    for (SelectedFile item in lampiran!) {
      if (existingDocument!
          .where((element) => element.id.toString() != item.id)
          .isEmpty) {
        fileLampiran.add(item.file);
      }
    }

    bodyItem.add(ItemScientific(
      idJenis: 7,
      idItem: jenisKegiatan.value,
      type: 0,
      remarks: null,
      counter: 0,
      flagDelete: jenisKegiatan.flagDelete,
      id: jenisKegiatan.id,
    ));

    var bodyItemJson =
        List.generate(bodyItem.length, (index) => bodyItem[index].toJson());
    var bodyExistingJson = List.generate(
        existingDocument!.length, (index) => existingDocument[index].toJson());

    DialogHelper.showProgressDialog();
    await scientificActivityService
        .updateScientificActivity(
            id: id,
            idPreseptor: bodyPreseptor,
            tanggal: bodyTgl,
            jam: bodyJam,
            remarks: bodyRemarks ?? '',
            status: status,
            item: jsonEncode(bodyItemJson),
            lampiran: fileLampiran,
            idBatch: bodyDepartemen,
            topik: topik,
            idPeran: peran.value!,
            existingLampiran: jsonEncode(bodyExistingJson))
        .then((result) {
      context.read<ItemListAllScientificProvider>().getListScientific();
      context.read<ItemListDraftScientificProvider>().getListScientific();
      context.read<ItemListApproveScientificProvider>().getListScientific();
      context.read<ItemListRejectScientificProvider>().getListScientific();
      DialogHelper.closeDialog();

      if (result.statusCode == 200) {
        Fluttertoast.showToast(msg: result.data?.message ?? 'Success');
        if (status == '2') {
          NavHelper.navigateReplace(ScientificEventDetailApprovalScreen(
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

  Future addScientificActivity({
    required BuildContext context,
    required DateTime tanggal,
    required TimeOfDay jam,
    required String status,
    required DropDownItem departemen,
    required DropDownItem jenisKegiatan,
    required DropDownItem peran,
    required String topik,
    dynamic preseptor,
    String? catatan,
    List<SelectedFile>? lampiran,
  }) async {
    var bodyTgl = tanggal.formatDate('yyyy-MM-dd');
    var bodyJam =
        '${jam.hour.toString().padLeft(2, '0')}:${jam.minute.toString().padLeft(2, '0')}';
    var bodyDepartemen = departemen.value;
    var bodyPreseptor = preseptor;
    var bodyRemarks = catatan;
    List<ItemScientific> bodyItem = [];
    List<File> lampiranFile = [];

    for (SelectedFile item in lampiran!) {
      lampiranFile.add(item.file);
    }

    bodyItem.add(ItemScientific(
      idJenis: 7,
      idItem: jenisKegiatan.value,
      type: 0,
      remarks: null,
      counter: 0,
    ));

    var bodyItemJson =
        List.generate(bodyItem.length, (index) => bodyItem[index].toJson());

    DialogHelper.showProgressDialog();
    scientificActivityService
        .addScientificActivity(
            idPreseptor: bodyPreseptor,
            tanggal: bodyTgl,
            jam: bodyJam,
            remarks: bodyRemarks ?? '',
            status: status,
            item: jsonEncode(bodyItemJson),
            lampiran: lampiranFile,
            topik: topik,
            idPeran: peran.value!,
            idBatch: bodyDepartemen)
        .then(
      (result) {
        context.read<ItemListAllScientificProvider>().getListScientific();
        context.read<ItemListDraftScientificProvider>().getListScientific();
        context.read<ItemListApproveScientificProvider>().getListScientific();
        context.read<ItemListRejectScientificProvider>().getListScientific();
        DialogHelper.closeDialog();

        if (result.statusCode == 200) {
          Fluttertoast.showToast(msg: result.data?.message ?? 'Success');
          if (status == '2') {
            NavHelper.navigateReplace(ScientificEventDetailApprovalScreen(
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
