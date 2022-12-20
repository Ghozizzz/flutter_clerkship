import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/constant.dart';

class ApiClient extends InterceptorContract {
  SharedPreferences? prefs;

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    prefs ??= await SharedPreferences.getInstance();
    final token = prefs?.getString(Constant.token);

    final headers = <String, String>{};

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    debugPrint('Headers: ${jsonEncode(headers)}');

    data.headers.addAll(headers);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == 401) {
      Fluttertoast.showToast(msg: 'Unauthenticated');
    }

    return data;
  }
}
