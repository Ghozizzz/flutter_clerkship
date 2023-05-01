// To parse this JSON data, do
//
//     final scientificResponse = scientificResponseFromJson(jsonString);

import 'dart:convert';

ScientificResponse? scientificResponseFromJson(String str) =>
    ScientificResponse.fromJson(json.decode(str));

String scientificResponseToJson(ScientificResponse? data) =>
    json.encode(data!.toJson());

class ScientificResponse {
  ScientificResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory ScientificResponse.fromJson(Map<String, dynamic> json) =>
      ScientificResponse(
        success: json['success'],
        message: json['message'],
        data: Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data,
      };
}

class Data {
  Data({
    this.nomor,
    this.list,
  });

  String? nomor;
  List<Scientific>? list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        nomor: json['nomor'],
        list: json['list'] == null
            ? []
            : json['list'] == null
                ? []
                : List<Scientific>.from(
                    json['list']!.map((x) => Scientific.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'nomor': nomor,
        'list': list == null
            ? []
            : list == null
                ? []
                : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class Scientific {
  Scientific({
    this.id,
    this.namaDepartment,
    this.tanggal,
    this.namaDokter,
    this.status,
    this.updatedAt
  });

  int? id;
  String? namaDepartment;
  DateTime? tanggal;
  String? namaDokter;
  int? status;
  DateTime? updatedAt;

  factory Scientific.fromJson(Map<String, dynamic> json) => Scientific(
        id: json['id'],
        namaDepartment: json['nama_department'],
        tanggal:
            json['tanggal'] == null ? null : DateTime.parse(json['tanggal']),
        namaDokter: json['nama_dokter'],
        status: json['status'],
        updatedAt:
            json['updated_at'] == null ? null : DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_department': namaDepartment,
        'tanggal': tanggal?.toIso8601String(),
        'nama_dokter': namaDokter,
        'status': status,
        'updated_at': updatedAt?.toIso8601String(),
      };
}
