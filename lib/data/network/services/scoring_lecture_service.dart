import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/api_interface.dart';
import 'package:clerkship/data/network/entity/scoring_response.dart';

import '../api_helper.dart';
import '../entity/scoring_detail_response.dart';

class ScoringLectureService extends ScoringLectureInterface {
  @override
  Future<ResultData<ScoringResponse>> getScoring(int status) {
    return ApiHelper.post(
      route: 'dokter/scoring',
      parseJson: scoringResponseFromJson,
    );
  }

  @override
  Future<ResultData<ScoringDetailResponse>> getDetailScoring({
    required String idBatch,
    required String idUser,
  }) {
    final body = {
      'id_batch': idBatch,
      'id_user': idUser,
    };
    return ApiHelper.post(
      route: 'dokter/scoring_rotasi',
      parseJson: scoringDetailResponseFromJson,
      body: body,
    );
  }
}
