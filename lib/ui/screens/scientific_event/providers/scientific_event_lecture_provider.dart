import 'package:flutter/foundation.dart';

import '../../../../data/network/entity/scientific_event_lecture_response.dart';
import '../../../../data/network/services/scientific_event_lecture_service.dart';
import '../../../../main.dart';
import '../../../components/buttons/date_picker_button.dart';
import '../../../components/buttons/dropdown_field.dart';

class ScientificEventLectureProvider extends ChangeNotifier {
  final service = getIt<ScientificEventLectureService>();
  final scientificEvents = <ScientificEventData>[];
  final ratedScientificEvents = <ScientificEventData>[];

  final dateController = DatePickerController();
  final activityFilterController = DropDownController();
  final List<int> checkedId = [];

  int pageIndex = 0;

  bool loading = true;
  bool loadingRated = true;

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

  void getScientificEvent({
    required int idUser,
  }) async {
    loading = true;
    checkedId.clear();
    notifyListeners();

    final response = await service.getEvent(
      status: 2,
      idUser: idUser,
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

  void toggleCheckAll(bool checkAll) {
    checkedId.clear();
    for (ScientificEventData scientificEventData in scientificEvents) {
      if (scientificEventData.header == null) return;
      scientificEventData.checked = checkAll;
      if (checkAll) {
        checkedId.add(scientificEventData.header!.id!);
      }
    }
    notifyListeners();
  }
}
