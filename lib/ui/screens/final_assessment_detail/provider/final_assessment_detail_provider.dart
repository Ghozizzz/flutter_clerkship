import 'package:clerkship/data/network/entity/scoring_detail_response.dart';
import 'package:flutter/foundation.dart';

import '../../../../data/network/services/scoring_lecture_service.dart';
import '../../../../main.dart';

class FinalAssessmentDetailProvder extends ChangeNotifier {
  final _service = getIt<ScoringLectureService>();
  bool _loading = true;
  bool get loading => _loading;

  Header? _headerData;
  Header? get headerData => _headerData;

  final List<ScoringDetail> _detailData = [];
  List<ScoringDetail> get detailData => _detailData;

  void getDetail({
    required String idBatch,
    required String idUser,
    required String idRatingType,
  }) async {
    _loading = true;
    _detailData.clear();
    notifyListeners();

    final result = await _service.getDetailScoring(
      idBatch: idBatch,
      idUser: idUser,
      idRatingType: idRatingType,
    );
    _loading = false;
    _detailData.addAll(result.data?.data?.detail ?? []);
    _headerData = result.data?.data?.header;
    notifyListeners();
  }
}
