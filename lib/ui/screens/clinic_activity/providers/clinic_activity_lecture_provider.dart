import 'package:clerkship/data/network/entity/clinic_lecture_response.dart';
import 'package:clerkship/ui/components/buttons/date_picker_button.dart';
import 'package:clerkship/ui/components/buttons/dropdown_field.dart';
import 'package:clerkship/ui/components/dialog/custom_alert_dialog.dart';
import 'package:clerkship/utils/dialog_helper.dart';
import 'package:flutter/foundation.dart';

import '../../../../data/models/key_value_data.dart';
import '../../../../data/network/services/clinic_activity_lecture_service.dart';
import '../../../../main.dart';

class ClinicActivityLectureProvider extends ChangeNotifier {
  final service = getIt<ClinicActivityLectureService>();

  final List<ClinicActivityData> clinicActivities = [];
  final List<ClinicActivityData> ratedClinicActivities = [];

  // final clinicActivity = <ActivityData>[];
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
  
  void toggleCheckAll(bool checkAll) {
    checkedId.clear();
    notifyListeners();
    for (ClinicActivityData clinicActivityData in clinicActivities) {
      for (ActivityData activityData in clinicActivityData.data!) {
        if (activityData.header == null) return;

        if (activityData.header!.isForm == 0){
          activityData.checked = checkAll;
          if (checkAll) {
            // debugPrint(activityData.header!.id!.toString());
            checkedId.add(activityData.header!.id!);
          }
        }
      }
    }
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
    clinicActivities.addAll(response.data?.data ?? []);
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
    ratedClinicActivities.addAll(response.data?.data ?? []);
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
          response.statusCode == 200 ? AlertType.success : AlertType.error,
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
          response.statusCode == 200 ? AlertType.success : AlertType.error,
    );
    onFinish?.call(response.statusCode == 200);
  }
}
