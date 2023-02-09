import 'package:clerkship/data/network/entity/mini_cex_form_response.dart';
import 'package:clerkship/ui/components/buttons/dropdown_field.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';

import '../../../../data/network/services/clinic_activity_lecture_service.dart';
import '../../../../main.dart';
import '../../../components/buttons/rating_button.dart';

class MiniCexApprovalProvider extends ChangeNotifier {
  final service = getIt<ClinicActivityLectureService>();
  final approvalForm = <DetailCexForm>[];
  final controllers = [];

  CexHeader? header;
  bool loading = true;

  void getMiniCexFrom(String id) async {
    loading = true;
    controllers.clear();
    approvalForm.clear();
    notifyListeners();

    final response = await service.getMiniCexForm(id);
    header = response.data?.data?.header;
    for (DetailCexForm form in response.data?.data?.detail ?? []) {
      approvalForm.add(form);

      switch (form.tipeScoring) {
        case 0:
          controllers.add(TextEditingController());
          break;
        case 1:
          controllers.add(DropDownController());
          break;
        case 2:
          controllers.add(RatingController());
          break;
        case 3:
          controllers.add(FleatherController());
          break;
      }
    }
    loading = false;
    notifyListeners();
  }
}
