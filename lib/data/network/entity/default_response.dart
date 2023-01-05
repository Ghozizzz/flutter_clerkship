// To parse this JSON data, do
//
//     final defaultResponse = defaultResponseFromJson(jsonString);

import 'dart:convert';

DefaultResponse defaultResponseFromJson(String str) =>
    DefaultResponse.fromJson(json.decode(str));

String defaultResponseToJson(DefaultResponse data) =>
    json.encode(data.toJson());

class DefaultResponse {
  DefaultResponse({
    this.meta,
    this.data,
    this.errors,
  });

  Meta? meta;
  dynamic data;
  dynamic errors;

  factory DefaultResponse.fromJson(Map<String, dynamic> json) =>
      DefaultResponse(
        meta: json['meta'] == null ? null : Meta.fromJson(json['meta']),
        data: json['data'],
        errors: json['errors'],
      );

  Map<String, dynamic> toJson() => {
        'meta': meta?.toJson(),
        'data': data,
        'errors': errors,
      };
}

class Meta {
  Meta({
    this.success,
    this.message,
    this.code,
    this.status,
  });

  bool? success;
  Message? message;
  int? code;
  String? status;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        success: json['success'],
        message:
            json['message'] == null ? null : Message.fromJson(json['message']),
        code: json['code'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message?.toJson(),
        'code': code,
        'status': status,
      };
}

class Message {
  Message({
    this.header,
    this.body,
  });

  String? header;
  String? body;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        header: json['header'],
        body: json['body'],
      );

  Map<String, dynamic> toJson() => {
        'header': header,
        'body': body,
      };
}
