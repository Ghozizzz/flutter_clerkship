// To parse this JSON data, do
//
//     final clinicDoctorResponse = clinicDoctorResponseFromJson(jsonString);

import 'dart:convert';

ClinicDoctorResponse clinicDoctorResponseFromJson(String str) =>
    ClinicDoctorResponse.fromJson(json.decode(str));

String clinicDoctorResponseToJson(ClinicDoctorResponse data) =>
    json.encode(data.toJson());

class ClinicDoctorResponse {
  ClinicDoctorResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<ClinicDoctorTglData>? data;

  factory ClinicDoctorResponse.fromJson(Map<String, dynamic> json) =>
      ClinicDoctorResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] == null
            ? []
            : List<ClinicDoctorTglData>.from(
                json['data']!.map((x) => ClinicDoctorTglData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ClinicDoctorTglData {
  ClinicDoctorTglData({
    this.tanggal,
    this.data,
  });

  DateTime? tanggal;
  List<ClinicData>? data;

  factory ClinicDoctorTglData.fromJson(Map<String, dynamic> json) =>
      ClinicDoctorTglData(
        tanggal:
            json['tanggal'] == null ? null : DateTime.parse(json['tanggal']),
        data: json['data'] == null
            ? []
            : List<ClinicData>.from(
                json['data']!.map((x) => ClinicData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'tanggal':
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ClinicData {
  ClinicData({
    this.header,
    this.detail,
    this.document,
  });

  Header? header;
  List<Detail>? detail;
  List<Document>? document;

  factory ClinicData.fromJson(Map<String, dynamic> json) => ClinicData(
        header: json['header'] == null ? null : Header.fromJson(json['header']),
        detail: json['detail'] == null
            ? []
            : List<Detail>.from(json['detail']!.map((x) => Detail.fromJson(x))),
        document: json['document'] == null
            ? []
            : List<Document>.from(
                json['document']!.map((x) => Document.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'header': header?.toJson(),
        'detail': detail == null
            ? []
            : List<dynamic>.from(detail!.map((x) => x.toJson())),
        'document': document == null
            ? []
            : List<dynamic>.from(document!.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    this.id,
    this.idJenis,
    this.namaJenis,
    this.namaItem,
  });

  int? id;
  int? idJenis;
  String? namaJenis;
  String? namaItem;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json['id'],
        idJenis: json['id_jenis'],
        namaJenis: json['nama_jenis'],
        namaItem: json['nama_item'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_jenis': idJenis,
        'nama_jenis': namaJenis,
        'nama_item': namaItem,
      };
}

class Document {
  Document({
    this.id,
    this.fileName,
    this.fileUrl,
  });

  int? id;
  String? fileName;
  String? fileUrl;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json['id'],
        fileName: json['file_name'],
        fileUrl: json['file_url'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'file_name': fileName,
        'file_url': fileUrl,
      };
}

class Header {
  Header({
    this.id,
    this.remarks,
    this.topik,
    this.tanggal,
    this.namaDokter,
    this.namaDepartment,
    this.namaPeran,
    this.isMinicex,
  });

  int? id;
  String? remarks;
  dynamic topik;
  DateTime? tanggal;
  String? namaDokter;
  String? namaDepartment;
  dynamic namaPeran;
  int? isMinicex;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        id: json['id'],
        remarks: json['remarks'],
        topik: json['topik'],
        tanggal:
            json['tanggal'] == null ? null : DateTime.parse(json['tanggal']),
        namaDokter: json['nama_dokter'],
        namaDepartment: json['nama_department'],
        namaPeran: json['nama_peran'],
        isMinicex: json['is_minicex'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'remarks': remarks,
        'topik': topik,
        'tanggal': tanggal?.toIso8601String(),
        'nama_dokter': namaDokter,
        'nama_department': namaDepartment,
        'nama_peran': namaPeran,
        'is_minicex': isMinicex,
      };
}
