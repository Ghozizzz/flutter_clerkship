import 'package:clerkship/data/network/entity/departemen_response.dart';
import 'package:clerkship/data/network/entity/item_reference_response.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../network/services/reference_service.dart';

class ReferenceProvider extends ChangeNotifier {
  final referenceService = getIt<ReferenceService>();
  final List<Departemen> departemen = [];
  final List<ItemReference> jenisKegiatan = [];
  final List<ItemReference> penyakit = [];
  final List<ItemReference> keterampilan = [];
  final List<ItemReference> prosedur = [];
  final List<ItemReference> gejala = [];

  ReferenceProvider() {
    getDepartemen();
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
}
