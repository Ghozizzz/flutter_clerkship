// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  dynamic message;
  List<User>? data;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
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

class User {
  User({
    this.id,
    this.idFeature,
    this.nim,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.status,
    this.superuser,
    this.roleId,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idFeature;
  String? nim;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  int? status;
  int? superuser;
  int? roleId;
  dynamic rememberToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        idFeature: json['id_feature'],
        nim: json['nim'],
        name: json['name'],
        email: json['email'],
        emailVerifiedAt: json['email_verified_at'],
        status: json['status'],
        superuser: json['superuser'],
        roleId: json['role_id'],
        rememberToken: json['remember_token'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_feature': idFeature,
        'nim': nim,
        'name': name,
        'email': email,
        'email_verified_at': emailVerifiedAt,
        'status': status,
        'superuser': superuser,
        'role_id': roleId,
        'remember_token': rememberToken,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
