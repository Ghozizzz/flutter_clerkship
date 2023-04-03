// To parse this JSON data, do
//
//     final skListResponse = skListResponseFromJson(jsonString);

import 'dart:convert';

SkListResponse skListResponseFromJson(String str) =>
    SkListResponse.fromJson(json.decode(str));

String skListResponseToJson(SkListResponse data) => json.encode(data.toJson());

class SkListResponse {
  SkListResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory SkListResponse.fromJson(Map<String, dynamic> json) => SkListResponse(
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

  List<SKList>? list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: json['list'] == null
            ? []
            : List<SKList>.from(json['list']!.map((x) => SKList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'list': list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class SKList {
  SKList({
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

  factory SKList.fromJson(Map<String, dynamic> json) => SKList(
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
