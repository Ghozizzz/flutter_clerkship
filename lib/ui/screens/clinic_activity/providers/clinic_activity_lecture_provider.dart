import 'package:clerkship/data/network/entity/clinic_lecture_response.dart';
import 'package:clerkship/ui/components/buttons/date_picker_button.dart';
import 'package:clerkship/ui/components/buttons/dropdown_field.dart';
import 'package:clerkship/utils/extensions.dart';
import 'package:flutter/foundation.dart';

import '../../../../data/network/services/clinic_activity_service.dart';
import '../../../../main.dart';

class ClinicActivityLectureProvider extends ChangeNotifier {
  final clinicActivityService = getIt<ClinicActivityService>();
  final Map<String, List<ClinicActivityData>> clinicActivities = {};
  final Map<String, List<ClinicActivityData>> ratedClinicActivities = {};

  final List<int> checkedId = [];

  final dateController = DatePickerController();
  final activityFilterController = DropDownController();
  int pageIndex = 0;

  bool loading = true;

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

    final response = await clinicActivityService.getListLectureClinicActivities(
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
}
