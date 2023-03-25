// To parse this JSON data, do
//
//     final scoringRecapResponse = scoringRecapResponseFromJson(jsonString);

import 'dart:convert';

ScoringRecapResponse scoringRecapResponseFromJson(String str) =>
    ScoringRecapResponse.fromJson(json.decode(str));

String scoringRecapResponseToJson(ScoringRecapResponse data) =>
    json.encode(data.toJson());

class ScoringRecapResponse {
  ScoringRecapResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory ScoringRecapResponse.fromJson(Map<String, dynamic> json) =>
      ScoringRecapResponse(
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
    this.dokumen,
  });

  Header? header;
  List<Detail>? detail;
  String? dokumen;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        header: json['header'] == null ? null : Header.fromJson(json['header']),
        detail: json['detail'] == null
            ? []
            : List<Detail>.from(json['detail']!.map((x) => Detail.fromJson(x))),
        dokumen: json['dokumen'],
      );

  Map<String, dynamic> toJson() => {
        'header': header?.toJson(),
        'detail': detail == null
            ? []
            : List<dynamic>.from(detail!.map((x) => x.toJson())),
        'dokumen': dokumen,
      };
}

class Detail {
  Detail({
    this.id,
    this.namaKeterangan,
    this.percentage,
    this.nilai,
  });

  int? id;
  String? namaKeterangan;
  int? percentage;
  String? nilai;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json['id'],
        namaKeterangan: json['nama_keterangan'],
        percentage: json['percentage'],
        nilai: json['nilai'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_keterangan': namaKeterangan,
        'percentage': percentage,
        'nilai': nilai,
      };
}

class Header {
  Header({
    this.id,
    this.idBatch,
    this.idFeature,
    this.startDate,
    this.endDate,
    this.idUser,
    this.namaRs,
    this.name,
    this.nim,
  });

  int? id;
  int? idBatch;
  int? idFeature;
  DateTime? startDate;
  DateTime? endDate;
  int? idUser;
  String? namaRs;
  String? name;
  String? nim;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        id: json['id'],
        idBatch: json['id_batch'],
        idFeature: json['id_feature'],
        startDate: json['start_date'] == null
            ? null
            : DateTime.parse(json['start_date']),
        endDate:
            json['end_date'] == null ? null : DateTime.parse(json['end_date']),
        idUser: json['id_user'],
        namaRs: json['nama_rs'],
        name: json['name'],
        nim: json['nim'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_batch': idBatch,
        'id_feature': idFeature,
        'start_date':
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        'end_date':
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        'id_user': idUser,
        'nama_rs': namaRs,
        'name': name,
        'nim': nim,
      };
}
