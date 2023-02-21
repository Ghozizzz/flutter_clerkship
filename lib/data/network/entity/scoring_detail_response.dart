// To parse this JSON data, do
//
//     final scoringDetailResponse = scoringDetailResponseFromJson(jsonString);

import 'dart:convert';

ScoringDetailResponse scoringDetailResponseFromJson(String str) =>
    ScoringDetailResponse.fromJson(json.decode(str));

String scoringDetailResponseToJson(ScoringDetailResponse data) =>
    json.encode(data.toJson());

class ScoringDetailResponse {
  ScoringDetailResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory ScoringDetailResponse.fromJson(Map<String, dynamic> json) =>
      ScoringDetailResponse(
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
    this.header,
    this.detail,
  });

  Header? header;
  List<ScoringDetail>? detail;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        header: json['header'] == null ? null : Header.fromJson(json['header']),
        detail: json['detail'] == null
            ? []
            : List<ScoringDetail>.from(
                json['detail']!.map((x) => ScoringDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'header': header?.toJson(),
        'detail': detail == null
            ? []
            : List<dynamic>.from(detail!.map((x) => x.toJson())),
      };
}

class ScoringDetail {
  ScoringDetail({
    this.idSection,
    this.idTipe,
    this.namaSection,
    this.dataDetail,
  });

  int? idSection;
  int? idTipe;
  String? namaSection;
  List<Quiz>? dataDetail;

  factory ScoringDetail.fromJson(Map<String, dynamic> json) => ScoringDetail(
        idSection: json['id_section'],
        idTipe: json['id_tipe'],
        namaSection: json['nama_section'],
        dataDetail: json['data_detail'] == null
            ? []
            : List<Quiz>.from(
                json['data_detail']!.map((x) => Quiz.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id_section': idSection,
        'id_tipe': idTipe,
        'nama_section': namaSection,
        'data_detail': dataDetail == null
            ? []
            : List<dynamic>.from(dataDetail!.map((x) => x.toJson())),
      };
}

class Quiz {
  Quiz({
    this.idPertanyaan,
    this.pertanyaan,
    this.jawaban,
  });

  int? idPertanyaan;
  String? pertanyaan;
  List<Jawaban>? jawaban;

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        idPertanyaan: json['id_pertanyaan'],
        pertanyaan: json['pertanyaan'],
        jawaban: json['jawaban'] == null
            ? []
            : List<Jawaban>.from(
                json['jawaban']!.map((x) => Jawaban.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id_pertanyaan': idPertanyaan,
        'pertanyaan': pertanyaan,
        'jawaban': jawaban == null
            ? []
            : List<dynamic>.from(jawaban!.map((x) => x.toJson())),
      };
}

class Jawaban {
  Jawaban({
    this.idJawaban,
    this.jawaban,
  });

  int? idJawaban;
  String? jawaban;

  factory Jawaban.fromJson(Map<String, dynamic> json) => Jawaban(
        idJawaban: json['id_jawaban'],
        jawaban: json['jawaban'],
      );

  Map<String, dynamic> toJson() => {
        'id_jawaban': idJawaban,
        'jawaban': jawaban,
      };
}

class Header {
  Header({
    this.id,
    this.idHeader,
    this.idFlow,
    this.idFeature,
    this.idRs,
    this.name,
    this.status,
    this.startDate,
    this.endDate,
    this.description,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idHeader;
  int? idFlow;
  int? idFeature;
  int? idRs;
  String? name;
  int? status;
  DateTime? startDate;
  DateTime? endDate;
  dynamic description;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        id: json['id'],
        idHeader: json['id_header'],
        idFlow: json['id_flow'],
        idFeature: json['id_feature'],
        idRs: json['id_rs'],
        name: json['name'],
        status: json['status'],
        startDate: json['start_date'] == null
            ? null
            : DateTime.parse(json['start_date']),
        endDate:
            json['end_date'] == null ? null : DateTime.parse(json['end_date']),
        description: json['description'],
        createdBy: json['created_by'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_header': idHeader,
        'id_flow': idFlow,
        'id_feature': idFeature,
        'id_rs': idRs,
        'name': name,
        'status': status,
        'start_date':
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        'end_date':
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        'description': description,
        'created_by': createdBy,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
