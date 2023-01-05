// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.message,
    this.user,
    this.token,
  });

  String? message;
  User? user;
  String? token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        message: json['message'],
        user: json['user'] == null ? null : User.fromJson(json['user']),
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'user': user?.toJson(),
        'token': token,
      };
}

class User {
  User({
    this.id,
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
