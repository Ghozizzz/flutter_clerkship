import 'package:clerkship/utils/dialog_helper.dart';
import 'package:flutter/material.dart';

import '../../../../data/network/entity/scoring_detail_response.dart';
import '../../../../data/network/services/scoring_lecture_service.dart';
import '../../../../main.dart';
import '../../../components/dialog/custom_alert_dialog.dart';

class RatingAssessmentProvider extends ChangeNotifier {
  final _service = getIt<ScoringLectureService>();

  void insertDetailScoring({
    required VoidCallback onFinish,
    required String idRatingType,
    required int id,
    required int idBatch,
    required int idUser,
    required int status,
    required List<ScoringDetail> data,
  }) async {
    DialogHelper.showProgressDialog();
    final result = await _service.insertDetailScoring(
      idRatingType: idRatingType,
      id: id,
      idBatch: idBatch,
      idUser: idUser,
      status: status,
      data: data,
    );
    DialogHelper.closeDialog();

    await DialogHelper.showMessageDialog(
      title: result.statusCode == 200 ? 'Dinilai' : 'Error',
      body: result.data?.message,
      alertType: result.statusCode == 200 ? AlertType.success : AlertType.error,
    );

    if (result.statusCode == 200) {
      onFinish();
      DialogHelper.closeDialog();
    }
  }
}
