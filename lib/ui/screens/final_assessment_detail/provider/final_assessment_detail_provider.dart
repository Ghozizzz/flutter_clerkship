import 'package:clerkship/data/network/entity/scoring_detail_response.dart';
import 'package:flutter/foundation.dart';

import '../../../../data/network/services/scoring_lecture_service.dart';
import '../../../../main.dart';

class FinalAssessmentDetailProvder extends ChangeNotifier {
  final _service = getIt<ScoringLectureService>();
  bool _loading = true;
  bool get loading => _loading;

  Header? _headerDataMiddle;
  Header? _headerDataFinal;

  Header? get headerDataMiddle => _headerDataMiddle;
  Header? get headerDataFinal => _headerDataFinal;

  final List<ScoringDetail> _detailDataMiddle = [];
  final List<ScoringDetail> _detailDataFinal = [];

  List<ScoringDetail> get detailDataMiddle => _detailDataMiddle;
  List<ScoringDetail> get detailDataFinal => _detailDataFinal;

  void getDetail({
    required String id,
    required String idUser,
  }) {
    // getDetailMiddle(id: id, idUser: idUser);
    getDetailFinal(id: id, idUser: idUser);
  }

  void getDetailMiddle({
    required String id,
    required String idUser,
  }) async {
    _loading = true;
    _detailDataMiddle.clear();
    notifyListeners();

    final result = await _service.getDetailScoring(
      id: id,
      idUser: idUser,
      idRatingType: '0',
    );
    _loading = false;
    _detailDataMiddle.addAll(result.data?.data?.detail ?? []);
    _headerDataMiddle = result.data?.data?.header;
    notifyListeners();
  }

  void getDetailFinal({
    required String id,
    required String idUser,
  }) async {
    _loading = true;
    _detailDataFinal.clear();
    notifyListeners();

    final result = await _service.getDetailScoring(
      id: id,
      idUser: idUser,
      idRatingType: '1',
    );
    _loading = false;
    _detailDataFinal.addAll(result.data?.data?.detail ?? []);
    _headerDataFinal = result.data?.data?.header;
    notifyListeners();
  }
}
