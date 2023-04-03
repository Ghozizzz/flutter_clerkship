// To parse this JSON data, do
//
//     final getFeatureResponse = getFeatureResponseFromJson(jsonString);

import 'dart:convert';

GetFeatureResponse getFeatureDataResponseFromJson(String str) =>
    GetFeatureResponse.fromJson(json.decode(str));

String getFeatureDataResponseToJson(GetFeatureResponse data) => json.encode(data.toJson());

class GetFeatureResponse {
  GetFeatureResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  dynamic message;
  Feature? data;

  factory GetFeatureResponse.fromJson(Map<String, dynamic> json) => GetFeatureResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] == null ? null : Feature.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
      };
}

class Feature {
  Feature({
    this.id,
    this.name,
    this.news,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? news;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json['id'],
        name: json['name'],
        news: json['news'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'news': news,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
