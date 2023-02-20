import 'package:flutter/foundation.dart';

import '../models/result_data.dart';
import 'api_config.dart';

class ApiHelper {
  static Future<ResultData<T>> post<T>({
    required String route,
    required T Function(String json) parseJson,
    String? baseUrl,
    Map<String, String>? headers,
    Map<String, dynamic>? params,
    Object? body,
  }) async {
    final apiClient = ApiConfig.client;

    final endpoint = '${baseUrl ?? ApiConfig.baseUrl}/$route';
    debugPrint(endpoint);

    try {
      final response = await apiClient.post(
        Uri.parse(endpoint),
        headers: headers,
        params: params,
        body: body,
      );
      debugPrint(response.body);

      final result = parseJson(response.body);
      return ResultData(
        data: result,
        statusCode: response.statusCode,
      );
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
  }

  static Future<ResultData<T>> get<T>({
    required String route,
    required T Function(String json) parseJson,
    String? baseUrl,
    Map<String, String>? headers,
    Map<String, dynamic>? params,
  }) async {
    final apiClient = ApiConfig.client;

    final endpoint = '${baseUrl ?? ApiConfig.baseUrl}/$route';
    debugPrint(endpoint);

    try {
      final response = await apiClient.get(
        Uri.parse(endpoint),
        headers: headers,
        params: params,
      );
      debugPrint(response.body);

      final result = parseJson(response.body);
      return ResultData(
        data: result,
        statusCode: response.statusCode,
      );
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
  }
}
