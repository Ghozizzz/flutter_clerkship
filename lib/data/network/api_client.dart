import 'dart:convert';

import 'package:clerkship/ui/screens/login/login_screen.dart';
import 'package:clerkship/utils/nav_helper.dart';
import 'package:clerkship/utils/tools.dart';
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
    debugPrint(token);

    final headers = <String, String>{};

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    debugPrint('Headers: ${jsonEncode(headers)}');

    request.headers.addAll(headers);
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    if (response.statusCode == 401) {
      Fluttertoast.showToast(msg: 'Unauthenticated');
      Tools.onViewCreated(() {
        NavHelper.navigateRefresh(LoginScreen(), '/login');
      });
    }

    return response;
  }
}
