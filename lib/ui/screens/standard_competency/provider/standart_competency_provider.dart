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
  List<StandartCompetencyData> data;

  StandartCompetencyDataGroup({
    required this.title,
    required this.data,
  });
}

class StandartCompetencyData {
  String id;
  String title;
  int count;

  StandartCompetencyData({
    required this.id,
    required this.title,
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
  final paths = [];
  final selectedId = <String, String>{};
  int index = 0;
  bool loading = true;

  void addSelectedId(String key, String value) {
    selectedId[key] = value;
  }

  void getDepartmentLecture({
    required int idUser,
  }) async {
    selectedId['id_user'] = '$idUser';
    loading = true;
    data[0].data.clear();
    notifyListeners();

    final response =
        await standartCompetencyLectureService.getDepartement(idUser);
    for (DepartmentLecture departement in response.data?.data?.list ?? []) {
      data[0].data.add(StandartCompetencyData(
            id: '${departement.id}',
            title: '${departement.namaBatch}',
          ));
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
          ));
    }
    loading = false;
    notifyListeners();
  }

  void getListSKGroup({
    required String idJenisSK,
  }) async {
    loading = true;
    data[2].data.clear();
    notifyListeners();

    final result = await standardCompetencyService.getListGroup(
      idJenisSK: idJenisSK,
    );
    for (SKListGroup sklistGroup in result.data?.data ?? []) {
      data[2].data.add(StandartCompetencyData(
            id: '${sklistGroup.id}',
            title: '${sklistGroup.namaGroup}',
          ));
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
    loading = false;
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
    index = index - 1;
    removeLastPath();
    notifyListeners();
  }

  void clearPaths() {
    paths.clear();
    notifyListeners();
  }
}
