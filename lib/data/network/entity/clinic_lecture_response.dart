// To parse this JSON data, do
//
//     final clinicLectureResponse = clinicLectureResponseFromJson(jsonString);

import 'dart:convert';

ClinicLectureResponse clinicLectureResponseFromJson(String str) =>
    ClinicLectureResponse.fromJson(json.decode(str));

String clinicLectureResponseToJson(ClinicLectureResponse data) =>
    json.encode(data.toJson());

class ClinicLectureResponse {
  ClinicLectureResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<ClinicActivityData>? data;

  factory ClinicLectureResponse.fromJson(Map<String, dynamic> json) =>
      ClinicLectureResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] == null
            ? []
            : List<ClinicActivityData>.from(
                json['data']!.map((x) => ClinicActivityData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ClinicActivityData {
  ClinicActivityData({
    this.tanggal,
    this.data,
  });

  DateTime? tanggal;
  List<ActivityData>? data;

  factory ClinicActivityData.fromJson(Map<String, dynamic> json) =>
      ClinicActivityData(
        tanggal:
            json['tanggal'] == null ? null : DateTime.parse(json['tanggal']),
        data: json['data'] == null
            ? []
            : List<ActivityData>.from(
                json['data']!.map((x) => ActivityData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'tanggal':
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ActivityData {
  ActivityData({
    this.header,
    this.detail,
    this.document,
    this.tinjauan,
    this.checked = false,
  });

  Header? header;
  List<Detail>? detail;
  List<Document>? document;
  List<Tinjauan>? tinjauan;
  bool checked;

  factory ActivityData.fromJson(Map<String, dynamic> json) => ActivityData(
        header: json['header'] == null ? null : Header.fromJson(json['header']),
        detail: json['detail'] == null
            ? []
            : List<Detail>.from(json['detail']!.map((x) => Detail.fromJson(x))),
        document: json['document'] == null
            ? []
            : List<Document>.from(
                json['document']!.map((x) => Document.fromJson(x))),
        tinjauan: json['tinjauan'] == null
            ? []
            : List<Tinjauan>.from(
                json['tinjauan']!.map((x) => Tinjauan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'header': header?.toJson(),
        'detail': detail == null
            ? []
            : List<dynamic>.from(detail!.map((x) => x.toJson())),
        'document': document == null
            ? []
            : List<dynamic>.from(document!.map((x) => x.toJson())),
        'tinjauan': tinjauan == null
            ? []
            : List<dynamic>.from(tinjauan!.map((x) => x.toJson())),
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
    this.status,
    this.remarks,
    this.topik,
    this.tanggal,
    this.namaStudent,
    this.namaDepartment,
    this.namaPeran,
    this.namaKegiatan,
    this.namaBatch,
    this.isMinicex,
  });

  int? id;
  int? status;
  String? remarks;
  dynamic topik;
  DateTime? tanggal;
  String? namaStudent;
  String? namaDepartment;
  dynamic namaPeran;
  String? namaKegiatan;
  String? namaBatch;
  int? isMinicex;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        id: json['id'],
        status: json['status'],
        remarks: json['remarks'],
        topik: json['topik'],
        tanggal:
            json['tanggal'] == null ? null : DateTime.parse(json['tanggal']),
        namaStudent: json['nama_student'],
        namaDepartment: json['nama_department'],
        namaPeran: json['nama_peran'],
        namaKegiatan: json['nama_kegiatan'],
        namaBatch: json['name'],
        isMinicex: json['is_minicex'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'remarks': remarks,
        'topik': topik,
        'tanggal': tanggal?.toIso8601String(),
        'nama_student': namaStudent,
        'nama_department': namaDepartment,
        'nama_peran': namaPeran,
        'nama_kegiatan': namaKegiatan,
        'name': namaBatch,
        'is_minicex': isMinicex,
      };
}

class Tinjauan {
  Tinjauan({
    this.keterangan,
    this.tipeScoring,
    this.nilai,
  });

  String? keterangan;
  int? tipeScoring;
  String? nilai;

  factory Tinjauan.fromJson(Map<String, dynamic> json) => Tinjauan(
        keterangan: json['keterangan'],
        tipeScoring: json['tipe_scoring'],
        nilai: json['nilai'],
      );

  Map<String, dynamic> toJson() => {
        'keterangan': keterangan,
        'tipe_scoring': tipeScoring,
        'nilai': nilai,
      };
}
