import 'package:clerkship/data/network/entity/sklist_group_detail.dart';
import 'package:clerkship/data/network/entity/sklist_group_response.dart';
import 'package:clerkship/data/network/entity/sklist_jenis_response.dart';
import 'package:clerkship/data/network/entity/sklist_response.dart';
import 'package:clerkship/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../network/services/standard_competency_service.dart';

class StandardCompetencyProvider extends ChangeNotifier {
  final standardCompetencyService = getIt<StandardCompetencyService>();
  final List<SKList> skList = [];
  final List<SKListJenis> skListJenis = [];
  final List<SKListGroup> skListGroup = [];
  final List<SKListGroupDetail> skListGroupDetail = [];

  final List<SKList> skListBackup = [];
  final List<SKListJenis> skListJenisBackup = [];
  final List<SKListGroup> skListGroupBackup = [];
  final List<SKListGroupDetail> skListGroupDetailBackup = [];
  bool isloadingListSK = false;
  bool isloadingListSKJenis = false;
  bool isloadingListSKGroup = false;
  bool isloadingListSKGroupDetail = false;

  void getListSk() async {
    isloadingListSK = true;
    notifyListeners();
    final result = await standardCompetencyService.getListSk();
    if (result.statusCode == 200) {
      skList.clear();
      skList.addAll(result.data!.data!.list!);
      isloadingListSK = false;
      skListBackup.clear();
      skListBackup.addAll(skList);
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: result.data!.message!);
    }
  }

  void getListSKJenis() async {
    isloadingListSKJenis = true;
    notifyListeners();
    final result = await standardCompetencyService.getListSkJenis();
    if (result.statusCode == 200) {
      skListJenis.clear();
      skListJenis.addAll(result.data!.data!);
      isloadingListSKJenis = false;
      skListJenisBackup.clear();
      skListJenisBackup.addAll(skListJenis);
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: result.data!.message!);
    }
  }

  void getListSKGroup({
    required String idJenisSK,
    required String idbatch,
  }) async {
    isloadingListSKGroup = true;
    notifyListeners();
    final result = await standardCompetencyService.getListGroup(
      idJenisSK: idJenisSK,
      idBatch: idbatch,
    );
    if (result.statusCode == 200) {
      skListGroup.clear();
      skListGroup.addAll(result.data!.data!);
      isloadingListSKGroup = false;
      skListGroupBackup.clear();
      skListGroupBackup.addAll(skListGroup);
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: result.data!.message!);
    }
  }

  void getListSKGroupDetail({
    required int idGroup,
    required int idBatch,
    required int idJenisSK,
  }) async {
    isloadingListSKGroupDetail = true;
    notifyListeners();
    final result = await standardCompetencyService.getListGroupDetail(
      idGroup: idGroup,
      idBatch: idBatch,
      idJenisSK: idJenisSK,
    );
    if (result.statusCode == 200) {
      skListGroupDetail.clear();
      skListGroupDetail.addAll(result.data!.data!);
      isloadingListSKGroupDetail = false;
      skListGroupDetailBackup.clear();
      skListGroupDetailBackup.addAll(skListGroupDetail);
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: result.data!.message!);
    }
  }

  void searchSK(String type, String param) {
    switch (type) {
      case 'sklist':
        skList.clear();
        List<SKList> list = skListBackup.where((element) {
          return element.namaBatch!.toLowerCase().contains(param.toLowerCase());
        }).toList();

        skList.addAll(list);
        break;
      case 'sklistjenis':
        skListJenis.clear();
        List<SKListJenis> list = skListJenisBackup.where((element) {
          return element.namaJenis!.toLowerCase().contains(param.toLowerCase());
        }).toList();
        skListJenis.addAll(list);
        break;
      case 'sklistgroup':
        skListGroup.clear();
        List<SKListGroup> list = skListGroupBackup.where((element) {
          return element.namaGroup!.toLowerCase().contains(param.toLowerCase());
        }).toList();
        skListGroup.addAll(list);
        break;
      case 'sklistgroupdetail':
        skListGroupDetail.clear();
        List<SKListGroupDetail> list = skListGroupDetailBackup.where((element) {
          return element.name!.toLowerCase().contains(param.toLowerCase());
        }).toList();
        skListGroupDetail.addAll(list);
        break;
    }

    notifyListeners();
  }
}
