import 'dart:convert';
import 'dart:io';

import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/entity/scientific_response.dart';
import 'package:clerkship/data/network/entity/default_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../api_config.dart';
import '../api_interface.dart';
import '../entity/scientific_detail_response.dart';

class ScientificActivityService extends ScientificActivityInterface {
  final apiClient = ApiConfig.client;

  @override
  Future<ResultData<DefaultResponse>> addScientificActivity(
      {required int idBatch,
      required int idPreseptor,
      required String tanggal,
      required String jam,
      required String remarks,
      required String status,
      required String item,
      required String topik,
      required int idPeran,
      required List<File> lampiran}) async {
    final endpoint = '${ApiConfig.baseUrl}/logbook/insert';
    debugPrint(endpoint);

    final request = MultipartRequest('POST', Uri.parse(endpoint));

    for (var i = 0; i < lampiran.length; i++) {
      final imageFile =
          await MultipartFile.fromPath('lampiran[]', lampiran[i].path);
      request.files.add(imageFile);
    }

    final body = {
      'id_batch': idBatch.toString(),
      'id_preseptor': idPreseptor.toString(),
      'tanggal': tanggal,
      'jam': jam,
      'remarks': remarks,
      'status': status,
      'topik': topik,
      'item': item,
      'id_peran': idPeran.toString(),
    };

    request.fields.addAll(body);
    debugPrint(jsonEncode(body));

    try {
      final response = await apiClient.send(request);
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      debugPrint(responseString);

      final defaultResponse = defaultResponseFromJson(responseString);
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
  Future<ResultData<ScientificResponse>> getListScientific(
      {int? status, int? idFlow}) async {
    final endpoint = '${ApiConfig.baseUrl}/logbook/list';
    debugPrint(endpoint);
    final body = {};
    if (status != null) {
      body['status'] = status.toString();
    }

    if (idFlow != null) {
      body['id_flow'] = idFlow.toString();
    }

    debugPrint(jsonEncode(body));
    try {
      final response = await apiClient.post(Uri.parse(endpoint), body: body);
      debugPrint(response.body);

      final scientificResponse = scientificResponseFromJson(response.body);
      return ResultData(
        data: scientificResponse,
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
  Future<ResultData<ScientificDetailResponse>> getDetailScientific(
      {required int id}) async {
    final endpoint = '${ApiConfig.baseUrl}/logbook/get/$id';
    debugPrint(endpoint);

    try {
      final response = await apiClient.get(Uri.parse(endpoint));
      debugPrint(response.body);

      final scientificDetailResponse =
          scientificDetailResponseFromJson(response.body);
      return ResultData(
        data: scientificDetailResponse,
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
  Future<ResultData<DefaultResponse>> deleteScientific(
      {required int id}) async {
    final endpoint = '${ApiConfig.baseUrl}/logbook/delete';
    debugPrint(endpoint);
    final body = {
      'id': id.toString(),
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

  @override
  Future<ResultData<DefaultResponse>> updateScientificActivity(
      {required int id,
      required int idBatch,
      required int idPreseptor,
      required String tanggal,
      required String jam,
      required String remarks,
      required String status,
      required String item,
      required String existingLampiran,
      required String topik,
      required int idPeran,
      required List<File> lampiran}) async {
    final endpoint = '${ApiConfig.baseUrl}/logbook/update';
    debugPrint(endpoint);

    final request = MultipartRequest('POST', Uri.parse(endpoint));

    for (var i = 0; i < lampiran.length; i++) {
      final imageFile =
          await MultipartFile.fromPath('lampiran[]', lampiran[i].path);
      request.files.add(imageFile);
    }

    final body = {
      'id': id.toString(),
      'id_batch': idBatch.toString(),
      'id_preseptor': idPreseptor.toString(),
      'tanggal': tanggal,
      'jam': jam,
      'remarks': remarks,
      'status': status,
      'item': item,
      'id_peran': idPeran.toString(),
      'topik': topik,
      'existing_lampiran': existingLampiran,
    };

    request.fields.addAll(body);
    debugPrint(jsonEncode(body));

    try {
      final response = await apiClient.send(request);
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      debugPrint(responseString);

      final defaultResponse = defaultResponseFromJson(responseString);
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
