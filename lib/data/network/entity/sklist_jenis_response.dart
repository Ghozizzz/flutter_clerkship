// To parse this JSON data, do
//
//     final skListJenisResponse = skListJenisResponseFromJson(jsonString);

import 'dart:convert';

SkListJenisResponse skListJenisResponseFromJson(String str) =>
    SkListJenisResponse.fromJson(json.decode(str));

String skListJenisResponseToJson(SkListJenisResponse data) =>
    json.encode(data.toJson());

class SkListJenisResponse {
  SkListJenisResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<SKListJenis>? data;

  factory SkListJenisResponse.fromJson(Map<String, dynamic> json) =>
      SkListJenisResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] == null
            ? []
            : List<SKListJenis>.from(
                json['data']!.map((x) => SKListJenis.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SKListJenis {
  SKListJenis({
    this.id,
    this.namaJenis,
    this.tipe,
  });

  int? id;
  String? namaJenis;
  int? tipe;

  factory SKListJenis.fromJson(Map<String, dynamic> json) => SKListJenis(
        id: json['id'],
        namaJenis: json['nama_jenis'],
        tipe: json['tipe'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_jenis': namaJenis,
        'tipe': tipe
      };
}
