import 'package:clerkship/data/network/entity/scoring_response.dart';
import 'package:flutter/foundation.dart';

import '../../../../data/network/services/scoring_lecture_service.dart';
import '../../../../main.dart';

class FinalAssessmentLectureProvider extends ChangeNotifier {
  final _service = getIt<ScoringLectureService>();

  final _finalAssessments = <ScoringData>[];
  final _doneAssessments = <ScoringData>[];

  bool _loading = true;
  int _pageIndex = 0;
  bool _doneLoading = true;

  List<ScoringData> get finalAssessments => _finalAssessments;
  List<ScoringData> get doneAssessments => _doneAssessments;
  bool get loading => _loading;
  int get pageIndex => _pageIndex;
  bool get doneLoading => _doneLoading;

  void setPageIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }

  void getScoring() async {
    _loading = true;
    notifyListeners();

    final response = await _service.getScoring(2);
    _finalAssessments.clear();
    _finalAssessments.addAll(response.data?.data ?? []);
    _loading = false;
    notifyListeners();
  }

  void getDoneScoring() async {
    _doneLoading = true;
    notifyListeners();

    final response = await _service.getScoring(1);
    _doneAssessments.clear();
    _doneAssessments.addAll(response.data?.data ?? []);
    _doneLoading = false;
    notifyListeners();
  }
}
