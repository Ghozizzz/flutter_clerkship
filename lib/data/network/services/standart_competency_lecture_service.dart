import 'dart:convert';

import 'package:clerkship/data/network/entity/department_lecture_response.dart';
import 'package:clerkship/data/network/entity/sklist_group_detail.dart';
import 'package:flutter/cupertino.dart';

import '../../models/result_data.dart';
import '../api_config.dart';
import '../api_interface.dart';

class StandartCompetencyLectureService
    extends StandartCompetencyLectureInterface {
  final apiClient = ApiConfig.client;

  @override
  Future<ResultData<DepartmentLectureResponse>> getDepartement(
    int userId,
  ) async {
    final endpoint = '${ApiConfig.baseUrl}/sk/list_dokter';
    debugPrint(endpoint);

    final body = {
      'id_user': '$userId',
    };

    debugPrint(jsonEncode(body));
    try {
      final response = await apiClient.post(Uri.parse(endpoint), body: body);
      debugPrint(response.body);

      final responseJson = departmentLectureResponseFromJson(response.body);
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

  @override
  Future<ResultData<SkListGroupDetailResponse>> getListGroupDetail(
    Map<String, String> dataIds,
  ) async {
    final endpoint = '${ApiConfig.baseUrl}/sk/list_detailed_dokter';
    debugPrint(endpoint);

    debugPrint(jsonEncode(dataIds));
    try {
      final response = await apiClient.post(
        Uri.parse(endpoint),
        body: dataIds,
      );
      debugPrint(response.body);

      final skListGroupDetailResponse = skListGroupDetailResponseFromJson(
        response.body,
      );
      return ResultData(
        data: skListGroupDetailResponse,
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
