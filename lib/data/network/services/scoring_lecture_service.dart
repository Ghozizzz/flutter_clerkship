import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/api_interface.dart';
import 'package:clerkship/data/network/entity/scoring_response.dart';

import '../api_helper.dart';

class ScoringLectureService extends ScoringLectureInterface {
  @override
  Future<ResultData<ScoringResponse>> getScoring(int status) {
    return ApiHelper.post(
      route: 'dokter/scoring',
      parseJson: scoringResponseFromJson,
    );
  }
}
