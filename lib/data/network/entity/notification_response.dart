// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

NotificationResponse notificationResponseFromJson(String str) =>
    NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) =>
    json.encode(data.toJson());

class NotificationResponse {
  bool? success;
  String? message;
  DataNotif? data;

  NotificationResponse({
    this.success,
    this.message,
    this.data,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        success: json['success'],
        message: json['message'],
        data: DataNotif.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data,
      };
}

class DataNotif {
  List<Notifications>? today;
  List<Notifications>? yesterday;
  List<Notifications>? other;
  int? jumlah;

  DataNotif({this.today, this.yesterday, this.other, this.jumlah});

  factory DataNotif.fromJson(Map<String, dynamic> json) => DataNotif(
        today: List<Notifications>.from(
            json['Today'].map((x) => Notifications.fromJson(x))),
        yesterday: List<Notifications>.from(
            json['Yesterday'].map((x) => Notifications.fromJson(x))),
        other: List<Notifications>.from(
            json['Other'].map((x) => Notifications.fromJson(x))),
        jumlah: json['jumlah'],
      );

  Map<String, dynamic> toJson() => {
        'Today': today == null
            ? []
            : today == null
                ? []
                : List<dynamic>.from(today!.map((x) => x.toJson())),
        'Yesterday': yesterday == null
            ? []
            : yesterday == null
                ? []
                : List<dynamic>.from(yesterday!.map((x) => x.toJson())),
        'Other': other == null
            ? []
            : other == null
                ? []
                : List<dynamic>.from(other!.map((x) => x.toJson())),
        'jumlah': jumlah,
      };
}

class Notifications {
  int? idTrx;
  int? notifType;
  String? remarks;
  int? isRead;
  DateTime? createdAt;
  String? totalDuration;

  Notifications({
    this.idTrx,
    this.notifType,
    this.remarks,
    this.isRead,
    this.createdAt,
    this.totalDuration,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        idTrx: json['id_trx'],
        notifType: json['notif_type'],
        remarks: json['remarks'],
        isRead: json['is_read'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        totalDuration: json['total_duration'],
      );

  Map<String, dynamic> toJson() => {
        'id_trx': idTrx,
        'notif_type': notifType,
        'remarks': remarks,
        'is_read': isRead,
        'created_at': createdAt?.toIso8601String(),
        'total_duration': totalDuration,
      };
}
