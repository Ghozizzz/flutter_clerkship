import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/survey_value.dart';
import '../../../../data/network/entity/survey_form_response.dart';
import '../../../../data/network/services/survey_service.dart';
import '../../../../main.dart';
import '../../../../utils/dialog_helper.dart';
import '../../../../utils/nav_helper.dart';
import '../../../components/buttons/dropdown_field.dart';
import '../../../components/buttons/survey_score_button.dart';
import '../../../components/dialog/custom_alert_dialog.dart';
import '../../clinic_activity/providers/item_list_all_provider.dart';
import '../../clinic_activity/providers/item_list_approve_provider.dart';
import '../../clinic_activity/providers/item_list_draft_provider.dart';
import '../../clinic_activity/providers/item_list_reject_provider.dart';
import '../../clinic_detail_approval/clinic_detail_approval_screen.dart';
import '../../scientific_event/providers/item_list_all_provider.dart';
import '../../scientific_event/providers/item_list_approve_provider.dart';
import '../../scientific_event/providers/item_list_draft_provider.dart';
import '../../scientific_event/providers/item_list_reject_provider.dart';
import '../../scientific_event_detail_approval/scientific_event_approval_screen.dart';

class SurveyApprovalProvider extends ChangeNotifier {
  final surveyService = getIt<SurveyService>();
  final approvalForm = <SurveyCexForm>[];
  final controllers = [];

  SurveyCexHeader? header;
  bool loading = true;

  void getSurveyFormDetail(String id, String tipeSurvey) async {
    loading = true;

    controllers.clear();
    approvalForm.clear();
    notifyListeners();

    final response = await surveyService.getSurveyFormDetail(id, tipeSurvey);
    if (response.statusCode != 200) {
      Fluttertoast.showToast(
        msg: response.data?.message ?? 'Gagal memuat form survey',
      );
    }
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
        case 4:
          controllers.add(SurveyScoreController());
          break;
        case 5:
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

  void approveSurveyApprovalForm({
    required BuildContext context,
    required String id,
    required int flow,
    required List<SurveyKeyValueData> formData,
    VoidCallback? onFinish,
  }) async {
    DialogHelper.showProgressDialog();

    await surveyService
        .approveSurveyApprovalForm(
      id: id,
      data: formData.map((e) => e.toJson(valueTitle: 'nilai')).toList(),
    )
        .then((response) {
      DialogHelper.closeDialog();
      onFinish?.call();
      if (response.statusCode == 200) {
        DialogHelper.closeDialog();
        if (flow == 1) {
          context.read<ItemListAllClinicProvider>().getListClinic();
          context.read<ItemListDraftClinicProvider>().getListClinic();
          context.read<ItemListApproveClinicProvider>().getListClinic();
          context.read<ItemListRejectClinicProvider>().getListClinic();
          NavHelper.navigateReplace(ClinicDetailApprovalScreen(
            id: int.parse(id),
          ));
        } else {
          context.read<ItemListAllScientificProvider>().getListScientific();
          context.read<ItemListDraftScientificProvider>().getListScientific();
          context.read<ItemListApproveScientificProvider>().getListScientific();
          context.read<ItemListRejectScientificProvider>().getListScientific();
          NavHelper.navigateReplace(ScientificEventDetailApprovalScreen(
            id: int.parse(id),
          ));
        }
        DialogHelper.showMessageDialog(
          title: 'Success',
          body: response.data!.message.toString(),
          alertType: AlertType.error,
        );
      } else {
        DialogHelper.showMessageDialog(
          title: 'Error',
          body: response.data?.message.toString() ??
              'Please Try Again or Contact Admin',
          alertType: AlertType.error,
        );
      }
    });
  }
}
