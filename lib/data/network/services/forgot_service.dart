import 'dart:convert';

import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/api_interface.dart';
import 'package:flutter/foundation.dart';

import '../api_config.dart';
import '../entity/forgot_response.dart';

class ForgotService extends ForgotPassInterface {
  final apiClient = ApiConfig.client;

  @override
  Future<ResultData<ForgotResponse>> doForgot({
    required String email,
  }) async {
    final endpoint = '${ApiConfig.baseUrl}/forgot';
    debugPrint(endpoint);

    final body = {
      'email': email,
    };
    debugPrint(jsonEncode(body));

    try {
      final response = await apiClient.post(
        Uri.parse(endpoint),
        body: body,
      );
      debugPrint(response.body);

      final forgotResponse = forgotResponseFromJson(response.body);
      return ResultData(
        data: forgotResponse,
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
  Future<ResultData<ForgotResponse>> doOtpCheck({
    required String email,
    required String otp,
  }) async {
    final endpoint = '${ApiConfig.baseUrl}/otp_check';
    debugPrint(endpoint);

    final body = {
      'email': email,
      'otp': otp,
    };
    debugPrint(jsonEncode(body));

    try {
      final response = await apiClient.post(
        Uri.parse(endpoint),
        body: body,
      );
      debugPrint(response.body);

      final otpCheckResponse = forgotResponseFromJson(response.body);
      return ResultData(
        data: otpCheckResponse,
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
  Future<ResultData<ForgotResponse>> doResetPassword(
      {required String email,
      required String password,
      required String confirmPassword}) async {
    final endpoint = '${ApiConfig.baseUrl}/reset_password';
    debugPrint(endpoint);

    final body = {
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
    };
    debugPrint(jsonEncode(body));

    try {
      final response = await apiClient.post(
        Uri.parse(endpoint),
        body: body,
      );
      debugPrint(response.body);

      final otpCheckResponse = forgotResponseFromJson(response.body);
      return ResultData(
        data: otpCheckResponse,
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
