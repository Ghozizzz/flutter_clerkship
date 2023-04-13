// To parse this JSON data, do
//
//     final scientificEventLectureResponse = scientificEventLectureResponseFromJson(jsonString);

import 'dart:convert';

ScientificEventLectureResponse scientificEventLectureResponseFromJson(
        String str) =>
    ScientificEventLectureResponse.fromJson(json.decode(str));

String scientificEventLectureResponseToJson(
        ScientificEventLectureResponse data) =>
    json.encode(data.toJson());

class ScientificEventLectureResponse {
  ScientificEventLectureResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<ScientificEventLectureData>? data;

  factory ScientificEventLectureResponse.fromJson(Map<String, dynamic> json) =>
      ScientificEventLectureResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] == null
            ? []
            : List<ScientificEventLectureData>.from(json['data']!
                .map((x) => ScientificEventLectureData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ScientificEventLectureData {
  ScientificEventLectureData({
    this.tanggal,
    this.data,
  });

  DateTime? tanggal;
  List<ScientificEventData>? data;

  factory ScientificEventLectureData.fromJson(Map<String, dynamic> json) =>
      ScientificEventLectureData(
        tanggal:
            json['tanggal'] == null ? null : DateTime.parse(json['tanggal']),
        data: json['data'] == null
            ? []
            : List<ScientificEventData>.from(
                json['data']!.map((x) => ScientificEventData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'tanggal':
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ScientificEventData {
  ScientificEventData({
    this.checked = false,
    this.header,
    this.document,
    this.tinjauan,
  });

  bool checked;
  Header? header;
  List<Document>? document;
  List<Tinjauan>? tinjauan;

  factory ScientificEventData.fromJson(Map<String, dynamic> json) =>
      ScientificEventData(
        header: json['header'] == null ? null : Header.fromJson(json['header']),
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
        'document': document == null
            ? []
            : List<dynamic>.from(document!.map((x) => x.toJson())),
        'tinjauan': tinjauan == null
            ? []
            : List<dynamic>.from(tinjauan!.map((x) => x.toJson())),
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
    this.isForm,
    this.remarks,
    this.topik,
    this.tanggal,
    this.namaStudent,
    this.namaDepartment,
    this.namaPeran,
    this.namaKegiatan,
  });

  int? id;
  int? status;
  int? isForm;
  String? remarks;
  String? topik;
  DateTime? tanggal;
  String? namaStudent;
  String? namaDepartment;
  String? namaPeran;
  String? namaKegiatan;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        id: json['id'],
        status: json['status'],
        isForm: json['is_form'],
        remarks: json['remarks'],
        topik: json['topik'],
        tanggal:
            json['tanggal'] == null ? null : DateTime.parse(json['tanggal']),
        namaStudent: json['nama_student'],
        namaDepartment: json['nama_department'],
        namaPeran: json['nama_peran'],
        namaKegiatan: json['nama_kegiatan'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'is_form': isForm,
        'remarks': remarks,
        'topik': topik,
        'tanggal': tanggal?.toIso8601String(),
        'nama_student': namaStudent,
        'nama_department': namaDepartment,
        'nama_peran': namaPeran,
        'nama_kegiatan': namaKegiatan,
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
