// To parse this JSON data, do
//
//     final standartCompetencyLectureResponse = standartCompetencyLectureResponseFromJson(jsonString);

import 'dart:convert';

StandartCompetencyLectureResponse standartCompetencyLectureResponseFromJson(
        String str) =>
    StandartCompetencyLectureResponse.fromJson(json.decode(str));

String standartCompetencyLectureResponseToJson(
        StandartCompetencyLectureResponse data) =>
    json.encode(data.toJson());

class StandartCompetencyLectureResponse {
  StandartCompetencyLectureResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory StandartCompetencyLectureResponse.fromJson(
          Map<String, dynamic> json) =>
      StandartCompetencyLectureResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
      };
}

class Data {
  Data({
    this.list,
  });

  List<StandartCompetencyLecture>? list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: json['list'] == null
            ? []
            : List<StandartCompetencyLecture>.from(json['list']!
                .map((x) => StandartCompetencyLecture.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'list': list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class StandartCompetencyLecture {
  StandartCompetencyLecture({
    this.id,
    this.namaBatch,
    this.nomorBatch,
    this.namaDepartment,
    this.status,
  });

  int? id;
  String? namaBatch;
  String? nomorBatch;
  String? namaDepartment;
  int? status;

  factory StandartCompetencyLecture.fromJson(Map<String, dynamic> json) =>
      StandartCompetencyLecture(
        id: json['id'],
        namaBatch: json['nama_batch'],
        nomorBatch: json['nomor_batch'],
        namaDepartment: json['nama_department'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_batch': namaBatch,
        'nomor_batch': nomorBatch,
        'nama_department': namaDepartment,
        'status': status,
      };
}
