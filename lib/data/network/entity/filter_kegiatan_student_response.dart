// To parse this JSON data, do
//
//     final filterKegiatanStudentResponse = filterKegiatanStudentResponseFromJson(jsonString);

import 'dart:convert';

FilterKegiatanStudentResponse filterKegiatanStudentResponseFromJson(
        String str) =>
    FilterKegiatanStudentResponse.fromJson(json.decode(str));

String filterKegiatanStudentResponseToJson(
        FilterKegiatanStudentResponse data) =>
    json.encode(data.toJson());

class FilterKegiatanStudentResponse {
  FilterKegiatanStudentResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<FilterKegiatanStudent>? data;

  factory FilterKegiatanStudentResponse.fromJson(Map<String, dynamic> json) =>
      FilterKegiatanStudentResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] == null
            ? []
            : List<FilterKegiatanStudent>.from(
                json['data']!.map((x) => FilterKegiatanStudent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FilterKegiatanStudent {
  FilterKegiatanStudent({
    this.id,
    this.name,
    this.idJenis,
  });

  int? id;
  String? name;
  int? idJenis;

  factory FilterKegiatanStudent.fromJson(Map<String, dynamic> json) =>
      FilterKegiatanStudent(
        id: json['id'],
        name: json['name'],
        idJenis: json['id_jenis'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'id_jenis': idJenis,
      };
}
