import 'package:clerkship/data/network/entity/clinic_lecture_response.dart';
import 'package:clerkship/ui/components/buttons/date_picker_button.dart';
import 'package:clerkship/ui/components/buttons/dropdown_field.dart';
import 'package:clerkship/ui/components/dialog/custom_alert_dialog.dart';
import 'package:clerkship/utils/dialog_helper.dart';
import 'package:clerkship/utils/extensions.dart';
import 'package:flutter/foundation.dart';

import '../../../../data/models/key_value_data.dart';
import '../../../../data/network/services/clinic_activity_lecture_service.dart';
import '../../../../main.dart';

class ClinicActivityLectureProvider extends ChangeNotifier {
  final service = getIt<ClinicActivityLectureService>();
  final Map<String, List<ClinicActivityData>> clinicActivities = {};
  final Map<String, List<ClinicActivityData>> ratedClinicActivities = {};
  final List<int> checkedId = [];

  final dateController = DatePickerController();
  final activityFilterController = DropDownController();
  int pageIndex = 0;

  bool loading = true;
  bool loadingRated = true;

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

  void getClinicActivities() async {
    loading = true;
    checkedId.clear();
    notifyListeners();

    final response = await service.getListActivities(
      status: 2,
      date: dateController.selected,
      idKegiatan: activityFilterController.selected?.value,
    );

    clinicActivities.clear();
    for (ClinicActivityData data in response.data?.data ?? []) {
      if (data.tanggal != null) {
        String date = data.tanggal!.formatDate('dd MMMM yyyy');
        if (clinicActivities.containsKey(date)) {
          clinicActivities[date]!.add(data);
        } else {
          clinicActivities[date] = [data];
        }
      }
    }
    loading = false;
    notifyListeners();
  }

  void getRatedClinicActivities() async {
    loadingRated = true;
    notifyListeners();

    final response = await service.getListActivities(
      status: 1,
      date: dateController.selected,
      idKegiatan: activityFilterController.selected?.value,
    );

    ratedClinicActivities.clear();
    for (ClinicActivityData data in response.data?.data ?? []) {
      if (data.tanggal != null) {
        String date = data.tanggal!.formatDate('dd MMMM yyyy');
        if (ratedClinicActivities.containsKey(date)) {
          ratedClinicActivities[date]!.add(data);
        } else {
          ratedClinicActivities[date] = [data];
        }
      }
    }
    loadingRated = false;
    notifyListeners();
  }

  void reloadActivities() {
    getClinicActivities();
    getRatedClinicActivities();
  }

  void approveActivity(List<KeyValueData> activityData) async {
    DialogHelper.showProgressDialog();

    final response = await service.approveActivity(
      data: activityData.map((e) => e.toJson()).toList(),
    );
    DialogHelper.closeDialog();
    reloadActivities();

    DialogHelper.showMessageDialog(
      title: response.statusCode == 200 ? 'Berhasil' : 'Terjadi Kesalahan',
      body: response.data?.message ?? response.unexpectedErrorMessage,
      alertType:
          response.statusCode == 200 ? AlertType.sucecss : AlertType.error,
    );
  }

  void rejectActivity(
    List<KeyValueData> activityData, {
    Function(bool success)? onFinish,
  }) async {
    DialogHelper.showProgressDialog();

    final response = await service.rejectActivity(
      data: activityData.map((e) => e.toJson()).toList(),
    );
    DialogHelper.closeDialog();
    reloadActivities();

    await DialogHelper.showMessageDialog(
      title: response.statusCode == 200 ? 'Berhasil' : 'Terjadi Kesalahan',
      body: response.data?.message ?? response.unexpectedErrorMessage,
      alertType:
          response.statusCode == 200 ? AlertType.sucecss : AlertType.error,
    );
    onFinish?.call(response.statusCode == 200);
  }
}
