// To parse this JSON data, do
//
//     final departmentLectureResponse = departmentLectureResponseFromJson(jsonString);

import 'dart:convert';

DepartmentLectureResponse departmentLectureResponseFromJson(String str) =>
    DepartmentLectureResponse.fromJson(json.decode(str));

String departmentLectureResponseToJson(DepartmentLectureResponse data) =>
    json.encode(data.toJson());

class DepartmentLectureResponse {
  DepartmentLectureResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory DepartmentLectureResponse.fromJson(Map<String, dynamic> json) =>
      DepartmentLectureResponse(
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

  List<DepartmentLecture>? list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: json['list'] == null
            ? []
            : List<DepartmentLecture>.from(
                json['list']!.map((x) => DepartmentLecture.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'list': list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class DepartmentLecture {
  DepartmentLecture({
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

  factory DepartmentLecture.fromJson(Map<String, dynamic> json) =>
      DepartmentLecture(
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
