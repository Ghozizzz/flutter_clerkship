import 'dart:convert';


NotificationReadResponse notificationReadResponseFromJson(String str) =>
    NotificationReadResponse.fromJson(json.decode(str));

String notificationReadResponseToJson(NotificationReadResponse data) =>
    json.encode(data.toJson());

class NotificationReadResponse {
  NotificationReadResponse({
    this.message,
  });

  String? message;

  factory NotificationReadResponse.fromJson(Map<String, dynamic> json) =>
      NotificationReadResponse(
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
      };
}
