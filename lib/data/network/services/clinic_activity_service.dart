import 'dart:convert';

import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/api_interface.dart';
import 'package:clerkship/data/network/entity/default_response.dart';
import 'package:flutter/cupertino.dart';

import '../api_config.dart';

class ClinicActivityService extends ClinicActivityInterface {
  final apiClient = ApiConfig.client;

  @override
  Future<ResultData<DefaultResponse>> addClinicActivity(
      {required int idBatch,
      required int idFeature,
      required int idPreseptor,
      required String tanggal,
      required String jam,
      required String remarks,
      required String status,
      required String item,
      required String lampiran}) async {
    final endpoint = '${ApiConfig.baseUrl}/user';
    debugPrint(endpoint);
    final body = {
      'id_batch': idBatch.toString(),
      'id_feature': idFeature.toString(),
      'id_preseptor': idPreseptor.toString(),
      'tanggal': tanggal,
      'jam': jam,
      'remarks': remarks,
      'status': status,
      'item': item,
      'lampiran': lampiran,
    };
    debugPrint(jsonEncode(body));

    try {
      final response = await apiClient.post(Uri.parse(endpoint), body: body);
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
