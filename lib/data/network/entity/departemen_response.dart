// To parse this JSON data, do
//
//     final departemenResponse = departemenResponseFromJson(jsonString);

import 'dart:convert';

DepartemenResponse departemenResponseFromJson(String str) =>
    DepartemenResponse.fromJson(json.decode(str));

String departemenResponseToJson(DepartemenResponse data) =>
    json.encode(data.toJson());

class DepartemenResponse {
  DepartemenResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  dynamic message;
  List<Departemen>? data;

  factory DepartemenResponse.fromJson(Map<String, dynamic> json) =>
      DepartemenResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] == null
            ? null
            : List<Departemen>.from(
                json['data'].map((x) => Departemen.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Departemen {
  Departemen({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  dynamic createdAt;
  dynamic updatedAt;

  factory Departemen.fromJson(Map<String, dynamic> json) => Departemen(
        id: json['id'],
        name: json['name'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
