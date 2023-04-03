import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../utils/extensions.dart';
import '../../models/result_data.dart';
import '../api_config.dart';
import '../api_interface.dart';
import '../entity/clinic_lecture_response.dart';
import '../entity/default_response.dart';
import '../entity/mini_cex_form_response.dart';

class ClinicActivityLectureService extends ClinicActivityLectureInterface {
  final apiClient = ApiConfig.client;

  @override
  Future<ResultData<ClinicLectureResponse>> getListActivities({
    required int status,
    int? idKegiatan,
    DateTime? date,
  }) async {
    final endpoint = '${ApiConfig.baseUrl}/dokter/list';
    debugPrint(endpoint);

    final body = {
      'status': '$status',
      if (idKegiatan != null) 'id_kegiatan': '$idKegiatan',
      if (date != null) 'tanggal': date.formatDate('yyyy-MM-dd'),
    };

    debugPrint(jsonEncode(body));
    try {
      final response = await apiClient.post(Uri.parse(endpoint), body: body);
      debugPrint(response.body);

      final clinicLectureResponse =
          clinicLectureResponseFromJson(response.body);
      return ResultData(
        data: clinicLectureResponse,
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
  Future<ResultData<DefaultResponse>> approveActivity({
    required List<Map<String, String>> data,
  }) async {
    final endpoint = '${ApiConfig.baseUrl}/dokter/approve';
    debugPrint(endpoint);

    final body = {
      'data': data,
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

  @override
  Future<ResultData<MiniCexFormResponse>> getMiniCexForm(String id) async {
    final endpoint = '${ApiConfig.baseUrl}/dokter/form/$id';
    debugPrint(endpoint);

    try {
      final response = await apiClient.get(
        Uri.parse(endpoint),
      );
      debugPrint(response.body);

      final miniCexFormResponse = miniCexFormResponseFromJson(response.body);
      return ResultData(
        data: miniCexFormResponse,
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
  Future<ResultData<DefaultResponse>> approveMiniCexForm({
    required String id,
    required List<Map<String, String>> data,
  }) async {
    final endpoint = '${ApiConfig.baseUrl}/dokter/approve_form';
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

  @override
  Future<ResultData<DefaultResponse>> rejectActivity({
    required List<Map<String, String>> data,
  }) async {
    final endpoint = '${ApiConfig.baseUrl}/dokter/reject';
    debugPrint(endpoint);

    final body = {
      'data': data,
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
