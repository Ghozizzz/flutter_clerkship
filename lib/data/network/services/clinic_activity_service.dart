import 'dart:convert';
import 'dart:io';

import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/api_interface.dart';
import 'package:clerkship/data/network/entity/default_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../api_config.dart';

class ClinicActivityService extends ClinicActivityInterface {
  final apiClient = ApiConfig.client;

  @override
  Future<ResultData<DefaultResponse>> addClinicActivity(
      {required int idBatch,
      required int idPreseptor,
      required String tanggal,
      required String jam,
      required String remarks,
      required String status,
      required String item,
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
      'item': item,
    };

    request.fields.addAll(body);
    print(request.headers);

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
