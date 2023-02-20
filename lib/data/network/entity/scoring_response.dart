// To parse this JSON data, do
//
//     final scoringResponse = scoringResponseFromJson(jsonString);

import 'dart:convert';

ScoringResponse scoringResponseFromJson(String str) =>
    ScoringResponse.fromJson(json.decode(str));

String scoringResponseToJson(ScoringResponse data) =>
    json.encode(data.toJson());

class ScoringResponse {
  ScoringResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<ScoringData>? data;

  factory ScoringResponse.fromJson(Map<String, dynamic> json) =>
      ScoringResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] == null
            ? []
            : List<ScoringData>.from(
                json['data']!.map((x) => ScoringData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ScoringData {
  ScoringData({
    this.id,
    this.idFeature,
    this.idUser,
    this.startDate,
    this.endDate,
    this.name,
    this.namaRs,
  });

  int? id;
  int? idFeature;
  int? idUser;
  DateTime? startDate;
  DateTime? endDate;
  String? name;
  String? namaRs;

  factory ScoringData.fromJson(Map<String, dynamic> json) => ScoringData(
        id: json['id'],
        idFeature: json['id_feature'],
        idUser: json['id_user'],
        startDate: json['start_date'] == null
            ? null
            : DateTime.parse(json['start_date']),
        endDate:
            json['end_date'] == null ? null : DateTime.parse(json['end_date']),
        name: json['name'],
        namaRs: json['nama_rs'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_feature': idFeature,
        'id_user': idUser,
        'start_date':
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        'end_date':
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        'name': name,
        'nama_rs': namaRs,
      };
}
