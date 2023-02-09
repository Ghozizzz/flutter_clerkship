// To parse this JSON data, do
//
//     final miniCexFormResponse = miniCexFormResponseFromJson(jsonString);

import 'dart:convert';

MiniCexFormResponse miniCexFormResponseFromJson(String str) =>
    MiniCexFormResponse.fromJson(json.decode(str));

String miniCexFormResponseToJson(MiniCexFormResponse data) =>
    json.encode(data.toJson());

class MiniCexFormResponse {
  MiniCexFormResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory MiniCexFormResponse.fromJson(Map<String, dynamic> json) =>
      MiniCexFormResponse(
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
    this.header,
    this.detail,
  });

  CexHeader? header;
  List<DetailCexForm>? detail;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        header:
            json['header'] == null ? null : CexHeader.fromJson(json['header']),
        detail: json['detail'] == null
            ? []
            : List<DetailCexForm>.from(
                json['detail']!.map((x) => DetailCexForm.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'header': header?.toJson(),
        'detail': detail == null
            ? []
            : List<dynamic>.from(detail!.map((x) => x.toJson())),
      };
}

class DetailCexForm {
  DetailCexForm({
    this.id,
    this.tipeScoring,
    this.keterangan,
    this.placeholder,
  });

  int? id;
  int? tipeScoring;
  String? keterangan;
  String? placeholder;

  factory DetailCexForm.fromJson(Map<String, dynamic> json) => DetailCexForm(
        id: json['id'],
        tipeScoring: json['tipe_scoring'],
        keterangan: json['keterangan'],
        placeholder: json['placeholder'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'tipe_scoring': tipeScoring,
        'keterangan': keterangan,
        'placeholder': placeholder,
      };
}

class CexHeader {
  CexHeader({
    this.id,
    this.nama,
    this.nim,
    this.namaKegiatan,
  });

  int? id;
  String? nama;
  String? nim;
  String? namaKegiatan;

  factory CexHeader.fromJson(Map<String, dynamic> json) => CexHeader(
        id: json['id'],
        nama: json['nama'],
        nim: json['nim'],
        namaKegiatan: json['nama_kegiatan'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'nim': nim,
        'nama_kegiatan': namaKegiatan,
      };
}
