import 'dart:convert';

import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/api_interface.dart';
import 'package:clerkship/data/network/entity/notification_read_response.dart';
import 'package:clerkship/data/network/entity/notification_response.dart';
import 'package:flutter/cupertino.dart';

import '../api_config.dart';

class NotificationService extends NotificationInterface {
  final apiClient = ApiConfig.client;

  @override
  Future<ResultData<NotificationResponse>> getNotification({
    required int role,
  }) async {
    final endpoint = '${ApiConfig.baseUrl}/notif';
    debugPrint(endpoint);
    final body = {
      'role_id': role.toString(),
    };
    debugPrint(jsonEncode(body));
    try {
      final response = await apiClient.post(Uri.parse(endpoint), body: body);
      debugPrint(response.body);

      final notificationResponse = notificationResponseFromJson(response.body);
      return ResultData(
        data: notificationResponse,
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

  Future<ResultData<NotificationReadResponse>> readNotification() async {
    final endpoint = '${ApiConfig.baseUrl}/notif_read';
    debugPrint(endpoint);

    try {
      final response = await apiClient.post(
        Uri.parse(endpoint),
      );
      debugPrint(response.body);

      final readResponse = notificationReadResponseFromJson(response.body);
      return ResultData(
        data: readResponse,
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
