import 'package:clerkship/data/network/entity/department_lecture_response.dart';
import 'package:clerkship/data/network/entity/sklist_group_detail.dart';
import 'package:clerkship/data/network/entity/sklist_jenis_response.dart';
import 'package:flutter/foundation.dart';

import '../../../../data/network/entity/sklist_group_response.dart';
import '../../../../data/network/services/standard_competency_service.dart';
import '../../../../data/network/services/standart_competency_lecture_service.dart';
import '../../../../main.dart';

class StandartCompetencyDataGroup {
  String title;
  String? subtitle;
  List<StandartCompetencyData> data;

  StandartCompetencyDataGroup({
    required this.title,
    this.subtitle,
    required this.data,
  });
}

class StandartCompetencyData {
  String id;
  String title;
  String? subtitle;
  String tipe;
  int count;

  StandartCompetencyData({
    required this.id,
    required this.title,
    this.subtitle,
    this.tipe = '0',
    this.count = 0,
  });
}

class StandartCompetencyProvider extends ChangeNotifier {
  final standardCompetencyService = getIt<StandardCompetencyService>();
  final standartCompetencyLectureService =
      getIt<StandartCompetencyLectureService>();
  final List<StandartCompetencyDataGroup> data = [
    StandartCompetencyDataGroup(title: '', data: []),
    StandartCompetencyDataGroup(title: '', data: []),
    StandartCompetencyDataGroup(title: '', data: []),
    StandartCompetencyDataGroup(title: '', data: []),
  ];
  final List<StandartCompetencyDataGroup> dataBackup = [
    StandartCompetencyDataGroup(title: '', data: []),
    StandartCompetencyDataGroup(title: '', data: []),
    StandartCompetencyDataGroup(title: '', data: []),
    StandartCompetencyDataGroup(title: '', data: []),
  ];
  final paths = [];
  final selectedId = <String, String>{};
  int index = 0;
  bool tipe = true;
  bool loading = true;

  void addSelectedId(String key, String value) {
    selectedId[key] = value;
  }

  void getDepartmentLecture({
    required int idUser,
  }) async {
    selectedId['id_user'] = '$idUser';
    loading = true;
    tipe = true;
    data[0].data.clear();
    notifyListeners();

    final response =
        await standartCompetencyLectureService.getDepartement(idUser);
    for (DepartmentLecture departement in response.data?.data?.list ?? []) {
      data[0].data.add(StandartCompetencyData(
            id: '${departement.id}',
            title: '${departement.namaBatch}',
            subtitle: '${departement.batchName}',
          ));
    }

    dataBackup[0].data.clear();
    for (StandartCompetencyData data in data[0].data) {
      dataBackup[0].data.add(data);
    }

    loading = false;
    notifyListeners();
  }

  void getListSKJenis() async {
    loading = true;
    data[1].data.clear();
    notifyListeners();

    final result = await standardCompetencyService.getListSkJenis();
    for (SKListJenis skListJenis in result.data?.data ?? []) {
      data[1].data.add(StandartCompetencyData(
          id: '${skListJenis.id}',
          title: '${skListJenis.namaJenis}',
          tipe: '${skListJenis.tipe}'));
    }

    dataBackup[1].data.clear();
    for (StandartCompetencyData data in data[1].data) {
      dataBackup[1].data.add(data);
    }

    loading = false;
    notifyListeners();
  }

  void getListSKGroup({
    required String idJenisSK,
    required String idBatch,
  }) async {
    loading = true;
    data[2].data.clear();
    notifyListeners();

    final result = await standardCompetencyService.getListGroup(
      idJenisSK: idJenisSK,
      idBatch: idBatch,
    );
    for (SKListGroup sklistGroup in result.data?.data ?? []) {
      data[2].data.add(StandartCompetencyData(
            id: '${sklistGroup.id}',
            title: '${sklistGroup.namaGroup}',
          ));
    }

    dataBackup[2].data.clear();
    for (StandartCompetencyData data in data[2].data) {
      dataBackup[2].data.add(data);
    }

    loading = false;
    notifyListeners();
  }

  void getListSKGroupDetail() async {
    loading = true;
    data[3].data.clear();
    notifyListeners();

    final result =
        await standartCompetencyLectureService.getListGroupDetail(selectedId);
    for (SKListGroupDetail sklistGroupDetail in result.data?.data ?? []) {
      data[3].data.add(StandartCompetencyData(
            id: '-1',
            title: '${sklistGroupDetail.name}',
            count: sklistGroupDetail.jumlah ?? 0,
          ));
    }

    dataBackup[3].data.clear();
    for (StandartCompetencyData data in data[3].data) {
      dataBackup[3].data.add(data);
    }

    loading = false;
    notifyListeners();
  }

  void getListSKGroupDetailBypass() async {
    loading = true;
    tipe = false;
    data[2].data.clear();
    notifyListeners();

    final result =
        await standartCompetencyLectureService.getListGroupDetail(selectedId);
    for (SKListGroupDetail sklistGroupDetail in result.data?.data ?? []) {
      data[2].data.add(StandartCompetencyData(
            id: '-1',
            title: '${sklistGroupDetail.name}',
            count: sklistGroupDetail.jumlah ?? 0,
          ));
    }

    dataBackup[2].data.clear();
    for (StandartCompetencyData data in data[2].data) {
      dataBackup[2].data.add(data);
    }
    loading = false;
    notifyListeners();
  }

  void searchSK(String query) {
    final List<StandartCompetencyData> filteredList = [];
    // save data before search
    if (dataBackup[index].data.isEmpty) {
      for (StandartCompetencyData data in data[index].data) {
        dataBackup[index].data.add(data);
      }
    } else {
      data[index].data.clear();
      data[index].data.addAll(dataBackup[index].data);
    }

    for (StandartCompetencyData data in data[index].data) {
      if (data.title.toLowerCase().contains(query.toLowerCase())) {
        filteredList.add(data);
      }
    }
    data[index].data = filteredList;
    notifyListeners();
  }

  void removeLastPath() {
    paths.removeAt(paths.length - 1);
    notifyListeners();
  }

  void setIndex(int index, String title) {
    this.index = index;
    paths.add(title);
    notifyListeners();
  }

  void goBack() {
    tipe = true;
    index = index - 1;
    removeLastPath();
    notifyListeners();
  }

  void clearPaths() {
    paths.clear();
    notifyListeners();
  }
}
