import 'dart:convert';

import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/api_interface.dart';
import 'package:clerkship/data/network/entity/survey_response.dart';
import 'package:clerkship/data/network/entity/survey_form_response.dart';
import 'package:flutter/cupertino.dart';

import '../entity/default_response.dart';
import '../../../utils/extensions.dart';
import '../api_config.dart';
import '../api_helper.dart';

class SurveyService extends SurveyInterface {
  final apiClient = ApiConfig.client;

  @override
  Future<ResultData<SurveyResponse>> getSurveyList() async {
    final endpoint = '${ApiConfig.baseUrl}/survey_list';
    debugPrint(endpoint);

    try {
      final response = await apiClient.post(Uri.parse(endpoint));
      debugPrint(response.body);

      final surveyResponse = surveyResponseFromJson(response.body);
      return ResultData(
        data: surveyResponse,
        statusCode: response.statusCode,
      );
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
  }

  @override
  Future<ResultData<SurveyFormResponse>> getSurveyFormDetail(String id) async {
    final endpoint = '${ApiConfig.baseUrl}/survey_form/$id';
    debugPrint(endpoint);

    try {
      final response = await apiClient.get(
        Uri.parse(endpoint),
      );
      debugPrint(response.body);

      final surveyFormResponse = surveyFormResponseFromJson(response.body);
      return ResultData(
        data: surveyFormResponse,
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
  Future<ResultData<DefaultResponse>> approveSurveyForm({
    required String id,
    required List<Map<String, String>> data,
  }) async {
    final endpoint = '${ApiConfig.baseUrl}/survey/approve';
    debugPrint(endpoint);

    final body = {
      'id': id,
      'detail': data,
    };

    debugPrint(jsonEncode(body));
    try {
      final response = await apiClient.post(
        Uri.parse(endpoint),
        body: jsonEncode(body),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      debugPrint(response.body);

      final defaultResponse = defaultResponseFromJson(response.body);
      return ResultData(
        data: defaultResponse,
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
