import 'package:flutter/foundation.dart';

import '../../../../data/models/key_value_data.dart';
import '../../../../data/network/entity/scientific_event_lecture_response.dart';
import '../../../../data/network/services/clinic_activity_lecture_service.dart';
import '../../../../data/network/services/scientific_event_lecture_service.dart';
import '../../../../main.dart';
import '../../../../utils/dialog_helper.dart';
import '../../../components/buttons/date_picker_button.dart';
import '../../../components/buttons/dropdown_field.dart';
import '../../../components/dialog/custom_alert_dialog.dart';

class ScientificEventLectureProvider extends ChangeNotifier {
  final service = getIt<ScientificEventLectureService>();
  final clinicActivityLectureService = getIt<ClinicActivityLectureService>();

  final scientificEvents = <ScientificEventData>[];
  final ratedScientificEvents = <ScientificEventData>[];

  final dateController = DatePickerController();
  final activityFilterController = DropDownController();
  final List<int> checkedId = [];

  int pageIndex = 0;

  bool loading = true;
  bool loadingRated = true;
  int? idUser;

  void setUserId(int idUser) {
    this.idUser = idUser;
    notifyListeners();
  }

  void reset() {
    pageIndex = 0;
    dateController.resetValue();
    activityFilterController.resetValue();
    notifyListeners();
  }

  void setPageIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }

  void addCheckId(int id) {
    checkedId.add(id);
    notifyListeners();
  }

  void removeCheckId(int id) {
    if (checkedId.contains(id)) checkedId.remove(id);
    notifyListeners();
  }

  void getScientificEvent() async {
    if (idUser == null) return;

    loading = true;
    checkedId.clear();
    notifyListeners();

    final response = await service.getEvent(
      status: 2,
      idUser: idUser!,
      date: dateController.selected,
      idKegiatan: activityFilterController.selected?.value,
    );

    scientificEvents.clear();
    for (ScientificEventLectureData data in response.data?.data ?? []) {
      scientificEvents.addAll(data.data ?? []);
    }
    loading = false;
    notifyListeners();
  }

  void getRatedScientificEvent() async {
    if (idUser == null) return;

    loadingRated = true;
    notifyListeners();

    final response = await service.getEvent(
      status: 1,
      idUser: idUser!,
      date: dateController.selected,
      idKegiatan: activityFilterController.selected?.value,
    );

    ratedScientificEvents.clear();
    for (ScientificEventLectureData data in response.data?.data ?? []) {
      ratedScientificEvents.addAll(data.data ?? []);
    }
    loadingRated = false;
    notifyListeners();
  }

  void toggleCheckAll(bool checkAll) {
    checkedId.clear();
    for (ScientificEventData scientificEventData in scientificEvents) {
      if (scientificEventData.header == null) return;

      if(scientificEventData.header!.isForm! == 0){
        scientificEventData.checked = checkAll;
        if (checkAll) {
          // debugPrint(scientificEventData.header!.id!.toString());
          checkedId.add(scientificEventData.header!.id!);
        }
      }
    }
    notifyListeners();
  }

  void approveEvent(List<KeyValueData> activityData) async {
    DialogHelper.showProgressDialog();

    final response = await clinicActivityLectureService.approveActivity(
      data: activityData.map((e) => e.toJson()).toList(),
    );
    DialogHelper.closeDialog();
    reloadEvents();

    DialogHelper.showMessageDialog(
      title: response.statusCode == 200 ? 'Berhasil' : 'Terjadi Kesalahan',
      body: response.data?.message ?? response.unexpectedErrorMessage,
      alertType:
          response.statusCode == 200 ? AlertType.success : AlertType.error,
    );
  }

  void rejectEvent(
    List<KeyValueData> activityData, {
    Function(bool success)? onFinish,
  }) async {
    DialogHelper.showProgressDialog();

    final response = await clinicActivityLectureService.rejectActivity(
      data: activityData.map((e) => e.toJson()).toList(),
    );
    DialogHelper.closeDialog();
    reloadEvents();

    await DialogHelper.showMessageDialog(
      title: response.statusCode == 200 ? 'Berhasil' : 'Terjadi Kesalahan',
      body: response.data?.message ?? response.unexpectedErrorMessage,
      alertType:
          response.statusCode == 200 ? AlertType.success : AlertType.error,
    );
    onFinish?.call(response.statusCode == 200);
  }

  void reloadEvents() {
    getScientificEvent();
    getRatedScientificEvent();
  }
}
