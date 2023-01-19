// To parse this JSON data, do
//
//     final clinicDetailResponse = clinicDetailResponseFromJson(jsonString);

import 'dart:convert';

ClinicDetailResponse? clinicDetailResponseFromJson(String str) =>
    ClinicDetailResponse.fromJson(json.decode(str));

String clinicDetailResponseToJson(ClinicDetailResponse? data) =>
    json.encode(data!.toJson());

class ClinicDetailResponse {
  ClinicDetailResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  DetailClinic? data;

  factory ClinicDetailResponse.fromJson(Map<String, dynamic> json) =>
      ClinicDetailResponse(
        success: json['success'],
        message: json['message'],
        data: DetailClinic.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data,
      };
}

class DetailClinic {
  DetailClinic({
    this.header,
    this.detail,
    this.document,
  });

  HeaderClinic? header;
  List<ClinicDetailItem>? detail;
  List<ClinicDocument>? document;

  factory DetailClinic.fromJson(Map<String, dynamic> json) => DetailClinic(
        header: HeaderClinic.fromJson(json['header']),
        detail: json['detail'] == null
            ? []
            : json['detail'] == null
                ? []
                : List<ClinicDetailItem>.from(
                    json['detail']!.map((x) => ClinicDetailItem.fromJson(x))),
        document: json['document'] == null
            ? []
            : json['document'] == null
                ? []
                : List<ClinicDocument>.from(
                    json['document']!.map((x) => ClinicDocument.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'header': header,
        'detail': detail == null
            ? []
            : detail == null
                ? []
                : List<dynamic>.from(detail!.map((x) => x.toJson())),
        'document': document == null
            ? []
            : document == null
                ? []
                : List<dynamic>.from(document!.map((x) => x.toJson())),
      };
}

class ClinicDetailItem {
  ClinicDetailItem({
    this.id,
    this.idTrx,
    this.idJenis,
    this.idItem,
    this.type,
    this.counter,
    this.remarks,
    this.createdAt,
    this.updatedAt,
    this.namaJenis,
    this.namaItem,
  });

  int? id;
  int? idTrx;
  int? idJenis;
  int? idItem;
  int? type;
  int? counter;
  String? remarks;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? namaJenis;
  String? namaItem;

  factory ClinicDetailItem.fromJson(Map<String, dynamic> json) =>
      ClinicDetailItem(
        id: json['id'],
        idTrx: json['id_trx'],
        idJenis: json['id_jenis'],
        idItem: json['id_item'],
        type: json['type'],
        counter: json['counter'],
        remarks: json['remarks'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
        namaJenis: json['nama_jenis'],
        namaItem: json['nama_item'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_trx': idTrx,
        'id_jenis': idJenis,
        'id_item': idItem,
        'type': type,
        'counter': counter,
        'remarks': remarks,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'nama_jenis': namaJenis,
        'nama_item': namaItem,
      };
}

class ClinicDocument {
  ClinicDocument({
    this.id,
    this.idTrx,
    this.fileName,
    this.fileUrl,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idTrx;
  String? fileName;
  String? fileUrl;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ClinicDocument.fromJson(Map<String, dynamic> json) => ClinicDocument(
        id: json['id'],
        idTrx: json['id_trx'],
        fileName: json['file_name'],
        fileUrl: json['file_url'],
        createdBy: json['created_by'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_trx': idTrx,
        'file_name': fileName,
        'file_url': fileUrl,
        'created_by': createdBy,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

class HeaderClinic {
  HeaderClinic({
    this.id,
    this.idBatch,
    this.idUser,
    this.idPreseptor,
    this.idFeature,
    this.remarks,
    this.tanggal,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.namaDokter,
    this.namaDepartment,
  });

  int? id;
  int? idBatch;
  int? idUser;
  int? idPreseptor;
  int? idFeature;
  String? remarks;
  DateTime? tanggal;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? namaDokter;
  String? namaDepartment;

  factory HeaderClinic.fromJson(Map<String, dynamic> json) => HeaderClinic(
        id: json['id'],
        idBatch: json['id_batch'],
        idUser: json['id_user'],
        idPreseptor: json['id_preseptor'],
        idFeature: json['id_feature'],
        remarks: json['remarks'],
        tanggal:
            json['tanggal'] == null ? null : DateTime.parse(json['tanggal']),
        status: json['status'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
        namaDokter: json['nama_dokter'],
        namaDepartment: json['nama_department'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_batch': idBatch,
        'id_user': idUser,
        'id_preseptor': idPreseptor,
        'id_feature': idFeature,
        'remarks': remarks,
        'tanggal': tanggal,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'nama_dokter': namaDokter,
        'nama_department': namaDepartment,
      };
}
