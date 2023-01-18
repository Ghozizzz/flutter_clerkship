// To parse this JSON data, do
//
//     final scientificDetailResponse = scientificDetailResponseFromJson(jsonString);

import 'dart:convert';

ScientificDetailResponse? scientificDetailResponseFromJson(String str) =>
    ScientificDetailResponse.fromJson(json.decode(str));

String scientificDetailResponseToJson(ScientificDetailResponse? data) =>
    json.encode(data!.toJson());

class ScientificDetailResponse {
  ScientificDetailResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  DetailScientific? data;

  factory ScientificDetailResponse.fromJson(Map<String, dynamic> json) =>
      ScientificDetailResponse(
        success: json['success'],
        message: json['message'],
        data: DetailScientific.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data,
      };
}

class DetailScientific {
  DetailScientific({
    this.header,
    this.detail,
    this.document,
  });

  HeaderScientific? header;
  List<ScientificDetailItem>? detail;
  List<ScientificDocument>? document;

  factory DetailScientific.fromJson(Map<String, dynamic> json) =>
      DetailScientific(
        header: HeaderScientific.fromJson(json['header']),
        detail: json['detail'] == null
            ? []
            : json['detail'] == null
                ? []
                : List<ScientificDetailItem>.from(json['detail']!
                    .map((x) => ScientificDetailItem.fromJson(x))),
        document: json['document'] == null
            ? []
            : json['document'] == null
                ? []
                : List<ScientificDocument>.from(json['document']!
                    .map((x) => ScientificDocument.fromJson(x))),
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

class ScientificDetailItem {
  ScientificDetailItem({
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

  factory ScientificDetailItem.fromJson(Map<String, dynamic> json) =>
      ScientificDetailItem(
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

class ScientificDocument {
  ScientificDocument({
    this.id,
    this.idTrx,
    this.fileName,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idTrx;
  String? fileName;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ScientificDocument.fromJson(Map<String, dynamic> json) =>
      ScientificDocument(
        id: json['id'],
        idTrx: json['id_trx'],
        fileName: json['file_name'],
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
        'created_by': createdBy,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

class HeaderScientific {
  HeaderScientific({
    this.id,
    this.idBatch,
    this.idUser,
    this.idPreseptor,
    this.idFeature,
    this.idPeran,
    this.topik,
    this.remarks,
    this.tanggal,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.namaDokter,
    this.namaDepartment,
    this.namaPeran,
  });

  int? id;
  int? idBatch;
  int? idUser;
  int? idPreseptor;
  int? idFeature;
  int? idPeran;
  String? topik;
  String? remarks;
  DateTime? tanggal;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? namaDokter;
  String? namaDepartment;
  String? namaPeran;

  factory HeaderScientific.fromJson(Map<String, dynamic> json) =>
      HeaderScientific(
        id: json['id'],
        idBatch: json['id_batch'],
        idUser: json['id_user'],
        idPreseptor: json['id_preseptor'],
        idFeature: json['id_feature'],
        idPeran: json['id_peran'],
        topik: json['topik'],
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
        namaPeran: json['nama_peran'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_batch': idBatch,
        'id_user': idUser,
        'id_preseptor': idPreseptor,
        'id_feature': idFeature,
        'id_peran': idPeran,
        'topik': topik,
        'remarks': remarks,
        'tanggal': tanggal,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'nama_dokter': namaDokter,
        'nama_department': namaDepartment,
      };
}
