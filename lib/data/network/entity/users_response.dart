// To parse this JSON data, do
//
//     final userResponse = usersResponseFromJson(jsonString);

import 'dart:convert';

import 'package:clerkship/data/network/entity/user_response.dart';

UsersResponse usersResponseFromJson(String str) =>
    UsersResponse.fromJson(json.decode(str));

String usersResponseToJson(UsersResponse data) => json.encode(data.toJson());

class UsersResponse {
  UsersResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  dynamic message;
  List<User>? data;

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] == null
            ? null
            : List<User>.from(json['data'].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
