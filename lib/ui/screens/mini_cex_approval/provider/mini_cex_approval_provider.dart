import 'package:clerkship/data/network/entity/clinic_detail_response.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/key_value_data.dart';
import '../../../../data/network/entity/mini_cex_form_response.dart';
import '../../../../data/network/services/clinic_activity_lecture_service.dart';
import '../../../../main.dart';
import '../../../../utils/dialog_helper.dart';
import '../../../components/buttons/dropdown_field.dart';
import '../../../components/buttons/rating_button.dart';
import '../../../components/dialog/custom_alert_dialog.dart';

class MiniCexApprovalProvider extends ChangeNotifier {
  final service = getIt<ClinicActivityLectureService>();
  final approvalForm = <DetailCexForm>[];
  final controllers = [];

  CexHeader? header;
  bool loading = true;
  Trxmini? trxmini;
  List<String?> listtrx = [];

  void getMiniCexFrom(String id) async {
    loading = true;
    controllers.clear();
    approvalForm.clear();
    notifyListeners();

    final response = await service.getMiniCexForm(id);
    header = response.data?.data?.header;
    trxmini = response.data?.data?.trxmini;
    if (trxmini != null) {
      listtrx.add(trxmini!.masalah);
      listtrx.add(trxmini!.umur);
      listtrx.add(trxmini!.gender);
      listtrx.add(trxmini!.deskripsi);
      listtrx.add(trxmini!.kerumitanMasalah);
    }

    for (DetailCexForm form in response.data?.data?.detail ?? []) {
      if (form.id! <= 5 && trxmini != null) {
        form.isEnable = false;
        form.defaultValue = listtrx[form.id! - 1];
      }
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

  void approveMiniCexForm({
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
