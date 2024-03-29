import 'package:clerkship/data/network/entity/departemen_response.dart';
import 'package:clerkship/data/network/entity/filter_kegiatan_response.dart';
import 'package:clerkship/data/network/entity/item_reference_response.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../network/entity/batch_response.dart';
import '../network/services/reference_service.dart';

class ReferenceProvider extends ChangeNotifier {
  final referenceService = getIt<ReferenceService>();
  final List<Departemen> departemen = [];
  final List<ItemReference> jenisKegiatan = [];
  final List<ItemReference> jenisKegiatanScientific = [];
  final List<ItemReference> peran = [];
  final List<ItemReference> penyakit = [];
  final List<ItemReference> keterampilan = [];
  final List<ItemReference> prosedur = [];
  final List<ItemReference> gejala = [];
  final List<Batch> batch = [];
  final List<FilterKegiatan> filterKegiatan = [];

  void resetData() {
    departemen.clear();
    jenisKegiatan.clear();
    jenisKegiatanScientific.clear();
    penyakit.clear();
    keterampilan.clear();
    prosedur.clear();
    gejala.clear();
    peran.clear();
    notifyListeners();
  }

  void getDepartemen() async {
    final result = await referenceService.getDepartemen();
    if (result.statusCode == 200) {
      departemen.clear();
      departemen.addAll(result.data!.data!);
      notifyListeners();
    }
  }

  void getJenisKegiatan({required int departemenId}) async {
    final result = await referenceService.getReferenceItem(
        idFeature: departemenId, idJenis: 1);
    if (result.statusCode == 200) {
      jenisKegiatan.clear();
      jenisKegiatan.addAll(result.data!.data!);
      notifyListeners();
    }
  }

  void getPenyakit({required int departemenId}) async {
    final result = await referenceService.getReferenceItem(
        idFeature: departemenId, idJenis: 2);
    if (result.statusCode == 200) {
      penyakit.clear();
      penyakit.addAll(result.data!.data!);
      notifyListeners();
    }
  }

  void setPenyakit({required ItemReference data}) {
    penyakit.add(data);
    notifyListeners();
  }

  void getKeterampilan({required int departemenId}) async {
    final result = await referenceService.getReferenceItem(
        idFeature: departemenId, idJenis: 3);
    if (result.statusCode == 200) {
      keterampilan.clear();
      keterampilan.addAll(result.data!.data!);
      notifyListeners();
    }
  }

  void getProsedur({required int departemenId}) async {
    final result = await referenceService.getReferenceItem(
        idFeature: departemenId, idJenis: 4);
    if (result.statusCode == 200) {
      prosedur.clear();
      prosedur.addAll(result.data!.data!);
      notifyListeners();
    }
  }

  void getGejala({required int departemenId}) async {
    final result = await referenceService.getReferenceItem(
        idFeature: departemenId, idJenis: 5);
    if (result.statusCode == 200) {
      gejala.clear();
      gejala.addAll(result.data!.data!);
      notifyListeners();
    }
  }

  void getJenisKegiatanScientific({required int departemenId}) async {
    final result = await referenceService.getReferenceItem(
        idFeature: departemenId, idJenis: 7);
    if (result.statusCode == 200) {
      jenisKegiatanScientific.clear();
      jenisKegiatanScientific.addAll(result.data!.data!);
      notifyListeners();
    }
  }

  void getPeran() async {
    final result = await referenceService.getReferenceItem(idJenis: 6);
    if (result.statusCode == 200) {
      peran.clear();
      peran.addAll(result.data!.data!);
      notifyListeners();
    }
  }

  void getBatch({
    final int? idFlow,
    final int? idFeature,
    final int? status,
  }) async {
    final result = await referenceService.getBatch(
      idFlow: idFlow,
      idFeature: idFeature,
      status: status,
    );
    if (result.statusCode == 200) {
      batch.clear();
      batch.addAll(result.data!.data!);
      notifyListeners();
    }
  }

  void getFilterKegiatan() async {
    final result = await referenceService.getFilterKegiatan();
    if (result.statusCode == 200) {
      filterKegiatan.clear();
      filterKegiatan.addAll(result.data!.data!);
      notifyListeners();
    }
  }
}
