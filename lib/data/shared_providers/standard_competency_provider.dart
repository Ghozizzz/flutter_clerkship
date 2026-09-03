import 'package:clerkship/data/network/entity/sk_detail_response.dart';
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

  SKDetail? skDetail;
  bool isloadingSkDetail = false;
  // Guards against a slower, earlier getSkDetail(id: A) response landing
  // after a newer getSkDetail(id: B) already started — without this, A's
  // stale result could overwrite B's once it finally resolves.
  String? _skDetailRequestedId;

  void getListSk() async {
    isloadingListSK = true;
    notifyListeners();
    try {
      final result = await standardCompetencyService.getListSk();
      if (result.statusCode == 200) {
        skList.clear();
        skList.addAll(result.data!.data!.list!);
        skListBackup.clear();
        skListBackup.addAll(skList);
      } else {
        Fluttertoast.showToast(
          msg: result.data?.message ?? 'Gagal memuat data',
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Gagal memuat data');
    } finally {
      isloadingListSK = false;
      notifyListeners();
    }
  }

  void getListSKJenis({required String idBatch}) async {
    isloadingListSKJenis = true;
    notifyListeners();
    try {
      final result =
          await standardCompetencyService.getListSkJenis(idBatch: idBatch);
      if (result.statusCode == 200) {
        skListJenis.clear();
        skListJenis.addAll(result.data!.data!);
        skListJenisBackup.clear();
        skListJenisBackup.addAll(skListJenis);
      } else {
        Fluttertoast.showToast(
          msg: result.data?.message ?? 'Gagal memuat data',
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Gagal memuat data');
    } finally {
      isloadingListSKJenis = false;
      notifyListeners();
    }
  }

  void getSkDetail({required String id}) async {
    _skDetailRequestedId = id;
    isloadingSkDetail = true;
    skDetail = null;
    notifyListeners();
    try {
      final result = await standardCompetencyService.getSkDetail(id: id);
      if (_skDetailRequestedId != id) return; // superseded by a newer call
      if (result.statusCode == 200) {
        skDetail = result.data?.data;
      } else {
        Fluttertoast.showToast(
          msg: result.data?.message ?? 'Gagal memuat deskripsi',
        );
      }
    } catch (e) {
      // Server sedang bermasalah / respons bukan JSON (mis. halaman error
      // HTML) — jangan crash, cukup gagal senyap dan biarkan bagian
      // deskripsi tidak tampil.
      if (_skDetailRequestedId != id) return;
      Fluttertoast.showToast(msg: 'Gagal memuat deskripsi');
    } finally {
      if (_skDetailRequestedId == id) {
        isloadingSkDetail = false;
        notifyListeners();
      }
    }
  }

  void getListSKGroup({
    required String idJenisSK,
    required String idbatch,
  }) async {
    isloadingListSKGroup = true;
    notifyListeners();
    try {
      final result = await standardCompetencyService.getListGroup(
        idJenisSK: idJenisSK,
        idBatch: idbatch,
      );
      if (result.statusCode == 200) {
        skListGroup.clear();
        skListGroup.addAll(result.data!.data!);
        skListGroupBackup.clear();
        skListGroupBackup.addAll(skListGroup);
      } else {
        Fluttertoast.showToast(
          msg: result.data?.message ?? 'Gagal memuat data',
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Gagal memuat data');
    } finally {
      isloadingListSKGroup = false;
      notifyListeners();
    }
  }

  void getListSKGroupDetail({
    required int idGroup,
    required int idBatch,
    required int idJenisSK,
  }) async {
    isloadingListSKGroupDetail = true;
    notifyListeners();
    try {
      final result = await standardCompetencyService.getListGroupDetail(
        idGroup: idGroup,
        idBatch: idBatch,
        idJenisSK: idJenisSK,
      );
      if (result.statusCode == 200) {
        skListGroupDetail.clear();
        skListGroupDetail.addAll(result.data!.data!);
        skListGroupDetailBackup.clear();
        skListGroupDetailBackup.addAll(skListGroupDetail);
      } else {
        Fluttertoast.showToast(
          msg: result.data?.message ?? 'Gagal memuat data',
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Gagal memuat data');
    } finally {
      isloadingListSKGroupDetail = false;
      notifyListeners();
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
