import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/key_value_data.dart';
import '../../../../data/network/entity/mini_cex_form_response.dart';
import '../../../../data/network/services/clinic_activity_lecture_service.dart';
import '../../../../main.dart';
import '../../../../utils/dialog_helper.dart';
import '../../../components/buttons/dropdown_field.dart';
import '../../../components/buttons/score_button.dart';
import '../../../components/dialog/custom_alert_dialog.dart';

class ScientificEventApprovalProvider extends ChangeNotifier {
  final service = getIt<ClinicActivityLectureService>();
  final approvalForm = <DetailCexForm>[];
  final controllers = [];

  CexHeader? header;
  bool loading = true;

  void getScientificEventFrom(String id) async {
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
          controllers.add(ScoreController());
          break;
        case 3:
          controllers.add(FleatherController());
          break;
      }
    }
    loading = false;
    notifyListeners();
  }

  void approveScientificEvent({
    required String id,
    required List<KeyValueData> formData,
    VoidCallback? onFinish,
  }) async {
    DialogHelper.showProgressDialog();

    final response = await service.approveMiniCexForm(
      id: id,
      data: formData.map((e) => e.toJson(valueTitle: 'nilai')).toList(),
    );
    DialogHelper.closeDialog();
    onFinish?.call();

    await DialogHelper.showMessageDialog(
      title: response.statusCode == 200
          ? 'Berhasil Disetujui'
          : 'Terjadi Kesalahan',
      body: response.data?.message ?? response.unexpectedErrorMessage,
      alertType:
          response.statusCode == 200 ? AlertType.success : AlertType.error,
    );
    DialogHelper.closeDialog();
  }
}
