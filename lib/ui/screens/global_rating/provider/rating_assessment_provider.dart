import 'package:clerkship/config/constant.dart';
import 'package:clerkship/utils/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/network/entity/scoring_detail_response.dart';
import '../../../../data/network/services/scoring_lecture_service.dart';
import '../../../../main.dart';
import '../../../components/dialog/custom_alert_dialog.dart';

class RatingAssessmentProvider extends ChangeNotifier {
  final _service = getIt<ScoringLectureService>();
  SharedPreferences? _prefs;

  void loadAnswer({
    required String id,
    required List<Assessment> data,
  }) async {
    _prefs ??= await SharedPreferences.getInstance();
    final answers = _prefs?.getStringList('${Constant.ratingData}_$id') ?? [];
    if (answers.length == data.length) {
      for (int i = 0; i < data.length; i++) {
        final selectedAnswers = data[i]
            .jawaban
            ?.where((element) => '${element.idJawaban}' == answers[i]);
        data[i].quizController.selected = selectedAnswers?.isNotEmpty ?? false
            ? selectedAnswers!.first
            : null;
      }
    }
  }

  void saveAnswer({
    required String id,
    required List<Assessment> data,
    required String notes,
  }) async {
    _prefs ??= await SharedPreferences.getInstance();

    final answers = <String>[];
    for (Assessment assessment in data) {
      answers.add(
        assessment.quizController.selected?.idJawaban.toString() ?? '',
      );
    }
    _prefs?.setStringList('${Constant.ratingData}_$id', answers);
    _prefs?.setString('${Constant.ratingNotes}_$id', notes);
  }

  void insertDetailScoring({
    required VoidCallback onFinish,
    required int idRatingType,
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
