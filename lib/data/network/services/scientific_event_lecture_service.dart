import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/api_interface.dart';
import 'package:clerkship/data/network/entity/scientifc_event_participant_response.dart';
import 'package:flutter/foundation.dart';

import '../api_config.dart';

class ScientificEventLectureService extends ScientificEventLectureInterface {
  final apiClient = ApiConfig.client;

  @override
  Future<ResultData<ScientificEventParticipantResponse>>
      getParticipant() async {
    final endpoint = '${ApiConfig.baseUrl}/dokter/acara_detail';
    debugPrint(endpoint);

    try {
      final response = await apiClient.post(Uri.parse(endpoint));
      debugPrint(response.body);

      final scientificEventParticipantResponse =
          scientifcEventParticipantResponseFromJson(response.body);
      return ResultData(
        data: scientificEventParticipantResponse,
        statusCode: response.statusCode,
      );
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
  }
}
