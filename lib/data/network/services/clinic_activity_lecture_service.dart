import 'dart:convert';

import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/api_interface.dart';
import 'package:clerkship/data/network/entity/clinic_doctor_response.dart';
import 'package:flutter/cupertino.dart';

import '../api_config.dart';

class ClinicLectureService extends ClinicActivityLectureInterface {
  final apiClient = ApiConfig.client;

  @override
  Future<ResultData<ClinicDoctorResponse>> getListClinicLecture({
    required int status,
    int? idFeature,
    DateTime? date,
  }) async {
    final endpoint = '${ApiConfig.baseUrl}/dokter/list';
    debugPrint(endpoint);

    final body = {
      'status': status.toString(),
    };

    if (idFeature != null) {
      body['id_kegiatan'] = idFeature.toString();
    }

    if (date != null) {
      body['tanggal'] = date.toString();
    }

    debugPrint(jsonEncode(body));
    try {
      final response = await apiClient.post(Uri.parse(endpoint), body: body);
      debugPrint(response.body);

      final clinicLectureResponse = clinicDoctorResponseFromJson(response.body);
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
}
