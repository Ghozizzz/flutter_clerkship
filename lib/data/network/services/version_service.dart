import 'dart:convert';

import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/api_interface.dart';
import 'package:clerkship/data/network/entity/check_version_response.dart';
import 'package:flutter/foundation.dart';

import '../api_config.dart';

class VersionService extends VersionInterface {
  final apiClient = ApiConfig.client;

  @override
  Future<ResultData<CheckVersionResponse>> checkVersion({
    required String version,
  }) async {
    final endpoint = '${ApiConfig.baseUrl}/apk-list';
    debugPrint(endpoint);

    final body = {
      'version': version,
    };
    debugPrint(jsonEncode(body));

    try {
      final response = await apiClient.post(
        Uri.parse(endpoint),
        body: body,
      );
      debugPrint(response.body);

      final checkVersionResponse = checkVersionResponseFromJson(response.body);
      return ResultData(
        data: checkVersionResponse,
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
