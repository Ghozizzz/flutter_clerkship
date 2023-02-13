import 'dart:convert';

import 'package:clerkship/data/network/entity/standart_competency_lecture_response.dart';
import 'package:flutter/cupertino.dart';

import '../../models/result_data.dart';
import '../api_config.dart';
import '../api_interface.dart';

class StandartCompetencyLectureService
    extends StandartCompetencyLectureInterface {
  final apiClient = ApiConfig.client;

  @override
  Future<ResultData<StandartCompetencyLectureResponse>> getStandartCompetency(
    String userId,
  ) async {
    final endpoint = '${ApiConfig.baseUrl}/sk/list_dokter';
    debugPrint(endpoint);

    final body = {
      'id_user': userId,
    };

    debugPrint(jsonEncode(body));
    try {
      final response = await apiClient.post(Uri.parse(endpoint), body: body);
      debugPrint(response.body);

      final responseJson =
          standartCompetencyLectureResponseFromJson(response.body);
      return ResultData(
        data: responseJson,
        statusCode: response.statusCode,
      );
    } catch (e) {
      debugPrint(e.toString());
      return ResultData(
        statusCode: 500,
        unexpectedErrorMessage: e.toString(),
      );
    }
  }
}
