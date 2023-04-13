// To parse this JSON data, do
//
//     final filterKegiatanResponse = filterKegiatanResponseFromJson(jsonString);

import 'dart:convert';

FilterKegiatanResponse filterKegiatanResponseFromJson(String str) =>
    FilterKegiatanResponse.fromJson(json.decode(str));

String filterKegiatanResponseToJson(FilterKegiatanResponse data) =>
    json.encode(data.toJson());

class FilterKegiatanResponse {
  FilterKegiatanResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<FilterKegiatan>? data;

  factory FilterKegiatanResponse.fromJson(Map<String, dynamic> json) =>
      FilterKegiatanResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] == null
            ? []
            : List<FilterKegiatan>.from(
                json['data']!.map((x) => FilterKegiatan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FilterKegiatan {
  FilterKegiatan({
    this.id,
    this.name,
    this.idJenis,
  });

  int? id;
  String? name;
  int? idJenis;

  factory FilterKegiatan.fromJson(Map<String, dynamic> json) => FilterKegiatan(
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
