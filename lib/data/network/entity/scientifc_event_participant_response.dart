// To parse this JSON data, do
//
//     final scientifcEventParticipantResponse = scientifcEventParticipantResponseFromJson(jsonString);

import 'dart:convert';

ScientificEventParticipantResponse scientifcEventParticipantResponseFromJson(
        String str) =>
    ScientificEventParticipantResponse.fromJson(json.decode(str));

String scientifcEventParticipantResponseToJson(
        ScientificEventParticipantResponse data) =>
    json.encode(data.toJson());

class ScientificEventParticipantResponse {
  ScientificEventParticipantResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<ScientificEventParticipant>? data;

  factory ScientificEventParticipantResponse.fromJson(
          Map<String, dynamic> json) =>
      ScientificEventParticipantResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] == null
            ? []
            : List<ScientificEventParticipant>.from(json['data']!
                .map((x) => ScientificEventParticipant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ScientificEventParticipant {
  ScientificEventParticipant({
    this.idUser,
    this.tanggal,
    this.namaStudent,
    this.pending,
  });

  int? idUser;
  DateTime? tanggal;
  String? namaStudent;
  int? pending;

  factory ScientificEventParticipant.fromJson(Map<String, dynamic> json) =>
      ScientificEventParticipant(
        idUser: json['id_user'],
        tanggal:
            json['tanggal'] == null ? null : DateTime.parse(json['tanggal']),
        namaStudent: json['nama_student'],
        pending: json['pending'],
      );

  Map<String, dynamic> toJson() => {
        'id_user': idUser,
        'tanggal':
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        'nama_student': namaStudent,
        'pending': pending
      };
}
