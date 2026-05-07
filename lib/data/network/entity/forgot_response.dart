import 'dart:convert';

ForgotResponse forgotResponseFromJson(String str) =>
    ForgotResponse.fromJson(json.decode(str));

String forgotResponseToJson(ForgotResponse data) => json.encode(data.toJson());

class ForgotResponse {
  ForgotResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  String? data;

  factory ForgotResponse.fromJson(Map<String, dynamic> json) => ForgotResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'],
      );

  Map<String, dynamic> toJson() =>
      {'success': success, 'message': message, 'data': data};
}
