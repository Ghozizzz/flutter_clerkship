// To parse this JSON data, do
//
//     final skDetailResponse = skDetailResponseFromJson(jsonString);

import 'dart:convert';

SkDetailResponse skDetailResponseFromJson(String str) =>
    SkDetailResponse.fromJson(json.decode(str));

String skDetailResponseToJson(SkDetailResponse data) =>
    json.encode(data.toJson());

class SkDetailResponse {
  SkDetailResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  SKDetail? data;

  factory SkDetailResponse.fromJson(Map<String, dynamic> json) =>
      SkDetailResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] == null ? null : SKDetail.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
      };
}

class SKDetail {
  SKDetail({
    this.id,
    this.namaBatch,
    this.batchName,
    this.nomorBatch,
    this.namaDepartment,
    this.status,
    this.description,
  });

  int? id;
  String? namaBatch;
  String? batchName;
  String? nomorBatch;
  String? namaDepartment;
  int? status;
  String? description;

  factory SKDetail.fromJson(Map<String, dynamic> json) => SKDetail(
        id: json['id'],
        namaBatch: json['nama_batch'],
        batchName: json['batch_name'],
        nomorBatch: json['nomor_batch'],
        namaDepartment: json['nama_department'],
        status: json['status'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_batch': namaBatch,
        'batch_name': batchName,
        'nomor_batch': nomorBatch,
        'nama_department': namaDepartment,
        'status': status,
        'description': description,
      };
}
