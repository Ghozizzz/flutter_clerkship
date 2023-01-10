import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/constant.dart';

class ApiClient extends InterceptorContract {
  SharedPreferences? prefs;

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    prefs ??= await SharedPreferences.getInstance();
    final token = prefs?.getString(Constant.token);

    final headers = <String, String>{};

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    debugPrint('Headers: ${jsonEncode(headers)}');

    request.headers.addAll(headers);
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    if (response.statusCode == 401) {
      Fluttertoast.showToast(msg: 'Unauthenticated');
    }

    return response;
  }
}
