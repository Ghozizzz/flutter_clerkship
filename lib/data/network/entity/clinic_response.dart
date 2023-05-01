// To parse this JSON data, do
//
//     final clinicResponse = clinicResponseFromJson(jsonString);

import 'dart:convert';

ClinicResponse? clinicResponseFromJson(String str) =>
    ClinicResponse.fromJson(json.decode(str));

String clinicResponseToJson(ClinicResponse? data) =>
    json.encode(data!.toJson());

class ClinicResponse {
  ClinicResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory ClinicResponse.fromJson(Map<String, dynamic> json) => ClinicResponse(
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
  List<Clinic>? list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        nomor: json['nomor'],
        list: json['list'] == null
            ? []
            : json['list'] == null
                ? []
                : List<Clinic>.from(
                    json['list']!.map((x) => Clinic.fromJson(x))),
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

class Clinic {
  Clinic({
    this.id,
    this.namaDepartment,
    this.tanggal,
    this.namaDokter,
    this.status,
    this.updatedAt,
  });

  int? id;
  String? namaDepartment;
  DateTime? tanggal;
  String? namaDokter;
  int? status;
  DateTime? updatedAt;

  factory Clinic.fromJson(Map<String, dynamic> json) => Clinic(
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
