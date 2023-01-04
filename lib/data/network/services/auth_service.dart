import 'dart:convert';

import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/api_interface.dart';
import 'package:clerkship/data/network/entity/default_response.dart';
import 'package:flutter/foundation.dart';

import '../api_config.dart';

class AuthService extends AuthApiInterface {
  final apiClient = ApiConfig.client;

  @override
  Future<ResultData<DefaultResponse>> doLogin({
    required String email,
    required String password,
  }) async {
    final endpoint = '${ApiConfig.baseUrl}/login';
    debugPrint(endpoint);

    final body = {
      'email': email,
      'password': password,
    };
    debugPrint(jsonEncode(body));

    try {
      final response = await apiClient.post(
        Uri.parse(endpoint),
        body: body,
      );
      debugPrint(response.body);

      final loginResponse = defaultResponseFromJson(response.body);
      return ResultData(
        data: loginResponse,
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
