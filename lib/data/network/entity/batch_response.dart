// To parse this JSON data, do
//
//     final batchResponse = batchResponseFromJson(jsonString);

import 'dart:convert';

import 'package:clerkship/data/network/entity/departemen_response.dart';

BatchResponse? batchResponseFromJson(String str) =>
    BatchResponse.fromJson(json.decode(str));

String batchResponseToJson(BatchResponse? data) => json.encode(data!.toJson());

class BatchResponse {
  BatchResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<Batch>? data;

  factory BatchResponse.fromJson(Map<String, dynamic> json) => BatchResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] == null
            ? []
            : json['data'] == null
                ? []
                : List<Batch>.from(json['data']!.map((x) => Batch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data == null
            ? []
            : data == null
                ? []
                : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Batch {
  Batch({
    this.id,
    this.idHeader,
    this.idFlow,
    this.idFeature,
    this.name,
    this.status,
    this.startDate,
    this.endDate,
    this.description,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.feature,
  });

  int? id;
  int? idHeader;
  int? idFlow;
  int? idFeature;
  String? name;
  int? status;
  String? startDate;
  String? endDate;
  String? description;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  Departemen? feature;

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
        id: json['id'],
        idHeader: json['id_header'],
        idFlow: json['id_flow'],
        idFeature: json['id_feature'],
        name: json['name'],
        status: json['status'],
        startDate: json['start_date'],
        endDate: json['end_date'],
        description: json['description'],
        createdBy: json['created_by'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
        feature: Departemen.fromJson(json['feature']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_header': idHeader,
        'id_flow': idFlow,
        'id_feature': idFeature,
        'name': name,
        'status': status,
        'start_date': startDate,
        'end_date': endDate,
        'description': description,
        'created_by': createdBy,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'feature': feature,
      };
}
