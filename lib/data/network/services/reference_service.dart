import 'dart:convert';

import 'package:clerkship/data/network/entity/batch_response.dart';
import 'package:clerkship/data/network/entity/item_reference_response.dart';
import 'package:flutter/cupertino.dart';

import '../../models/result_data.dart';
import '../api_config.dart';
import '../api_interface.dart';
import '../entity/departemen_response.dart';

class ReferenceService extends ReferenceApiInterface {
  final apiClient = ApiConfig.client;

  @override
  Future<ResultData<DepartemenResponse>> getDepartemen() async {
    final endpoint = '${ApiConfig.baseUrl}/feature';
    debugPrint(endpoint);

    try {
      final response = await apiClient.get(Uri.parse(endpoint));
      debugPrint(response.body);

      final departemenResponse = departemenResponseFromJson(response.body);
      return ResultData(
        data: departemenResponse,
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
  Future<ResultData<BatchResponse>> getBatch({
    final int? idFlow,
    final int? idFeature,
    final int? status,
  }) async {
    final endpoint = '${ApiConfig.baseUrl}/list_batch';
    debugPrint(endpoint);
    final body = {
      'id_flow': (idFlow != null) ? idFlow.toString() : '',
      'id_feature': (idFeature != null) ? idFeature.toString() : '',
      'status': status ?? '1',
    };
    debugPrint(jsonEncode(body));
    try {
      final response = await apiClient.post(Uri.parse(endpoint), body: body);
      debugPrint(response.body);

      final batchResponse = batchResponseFromJson(response.body);
      return ResultData(
        data: batchResponse,
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
  Future<ResultData<ItemReferenceResponse>> getReferenceItem({
    required int idFeature,
    required int idJenis,
  }) async {
    final endpoint = '${ApiConfig.baseUrl}/item/get';
    debugPrint(endpoint);
    final body = {
      'id_feature': idFeature.toString(),
      'id_jenis': idJenis.toString(),
    };
    debugPrint(jsonEncode(body));
    try {
      final response = await apiClient.post(Uri.parse(endpoint), body: body);
      debugPrint(response.body);

      final itemReferenceResponse =
          itemReferenceResponseFromJson(response.body);
      return ResultData(
        data: itemReferenceResponse,
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
