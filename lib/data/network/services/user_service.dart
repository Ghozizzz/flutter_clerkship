import 'dart:convert';

import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/api_interface.dart';
import 'package:clerkship/data/network/entity/user_response.dart';
import 'package:flutter/cupertino.dart';

import '../api_config.dart';

class UserService extends UserInterface {
  final apiClient = ApiConfig.client;

  @override
  Future<ResultData<UserResponse>> getAllUser({
    required int role,
    required int idFeature,
  }) async {
    final endpoint = '${ApiConfig.baseUrl}/user';
    debugPrint(endpoint);
    final body = {
      'role': role.toString(),
      'id_feature': idFeature.toString(),
    };
    debugPrint(jsonEncode(body));
    try {
      final response = await apiClient.post(Uri.parse(endpoint), body: body);
      debugPrint(response.body);

      final userResponse = userResponseFromJson(response.body);
      return ResultData(
        data: userResponse,
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
