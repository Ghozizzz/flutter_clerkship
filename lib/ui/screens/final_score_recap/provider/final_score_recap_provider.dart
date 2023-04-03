import 'package:clerkship/data/network/services/scoring_recap_response.dart';
import 'package:flutter/foundation.dart';

import '../../../../data/network/services/scoring_lecture_service.dart';
import '../../../../main.dart';

class FinalScoreRecapProvider extends ChangeNotifier {
  final _service = getIt<ScoringLectureService>();

  bool _loading = true;
  bool get loading => _loading;

  Header? _headerData;
  Header? get headerData => _headerData;

  String? _document;
  String? get document => _document;

  final List<Detail> _detailData = [];
  List<Detail> get detailData => _detailData;

  void getScoringRecap(int id) async {
    _loading = true;

    final result = await _service.getScoringRecap(id);
    _detailData.clear();
    _loading = false;

    _headerData = result.data?.data?.header;
    _document = result.data?.data?.dokumen;
    _detailData.addAll(result.data?.data?.detail ?? []);
    notifyListeners();
  }
}
