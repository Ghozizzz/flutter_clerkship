import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/survey_value.dart';
import '../../../../data/network/entity/survey_form_response.dart';
import '../../../../data/network/services/survey_service.dart';
import '../../../../main.dart';
import '../../../../utils/dialog_helper.dart';
import '../../../components/buttons/dropdown_field.dart';
import '../../../components/buttons/survey_score_button.dart';
import '../../../components/dialog/custom_alert_dialog.dart';

class SurveyApprovalProvider extends ChangeNotifier {
  final surveyService = getIt<SurveyService>();
  final approvalForm = <SurveyCexForm>[];
  final controllers = [];

  SurveyCexHeader? header;
  bool loading = true;

  void getSurveyFormDetail(String id) async {
    loading = true;

    controllers.clear();
    approvalForm.clear();
    notifyListeners();

    final response = await surveyService.getSurveyFormDetail(id);
    header = response.data?.data?.header;
    for (SurveyCexForm form in response.data?.data?.detail ?? []) {
      approvalForm.add(form);

      switch (form.jenisSurvey) {
        case 0:
          controllers.add(TextEditingController());
          break;
        case 1:
          controllers.add(DropDownController());
          break;
        case 2:
          controllers.add(SurveyScoreController());
          break;
        case 3:
          controllers.add(FleatherController());
          break;
      }
    }
    loading = false;
    notifyListeners();
  }

  void approveSurveyForm({
    required String id,
    required List<SurveyKeyValueData> formData,
    VoidCallback? onFinish,
  }) async {
    DialogHelper.showProgressDialog();

    final response = await surveyService.approveSurveyForm(
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
