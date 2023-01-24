import 'dart:convert';

import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/api_interface.dart';
import 'package:clerkship/data/network/entity/users_response.dart';
import 'package:flutter/cupertino.dart';

import '../api_config.dart';
import '../entity/user_response.dart';

class UserService extends UserInterface {
  final apiClient = ApiConfig.client;

  @override
  Future<ResultData<UsersResponse>> getAllUser({
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

      final userResponse = usersResponseFromJson(response.body);
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

  @override
  Future<ResultData<UserResponse>> getCurrentUser() async {
    final endpoint = '${ApiConfig.baseUrl}/myaccount';
    debugPrint(endpoint);
    try {
      final response = await apiClient.get(Uri.parse(endpoint));
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
