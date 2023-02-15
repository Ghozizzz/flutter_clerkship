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
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: result.data!.message!);
    }
  }

  void getListSKGroup({
    required String idJenisSK,
  }) async {
    isloadingListSKGroup = true;
    notifyListeners();
    final result = await standardCompetencyService.getListGroup(
      idJenisSK: idJenisSK,
    );
    if (result.statusCode == 200) {
      skListGroup.clear();
      skListGroup.addAll(result.data!.data!);
      isloadingListSKGroup = false;
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
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: result.data!.message!);
    }
  }
}
