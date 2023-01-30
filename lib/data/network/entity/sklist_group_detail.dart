// To parse this JSON data, do
//
//     final skListGroupDetailResponse = skListGroupDetailResponseFromJson(jsonString);

import 'dart:convert';

SkListGroupDetailResponse skListGroupDetailResponseFromJson(String str) =>
    SkListGroupDetailResponse.fromJson(json.decode(str));

String skListGroupDetailResponseToJson(SkListGroupDetailResponse data) =>
    json.encode(data.toJson());

class SkListGroupDetailResponse {
  SkListGroupDetailResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<SKListGroupDetail>? data;

  factory SkListGroupDetailResponse.fromJson(Map<String, dynamic> json) =>
      SkListGroupDetailResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] == null
            ? []
            : List<SKListGroupDetail>.from(
                json['data']!.map((x) => SKListGroupDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SKListGroupDetail {
  SKListGroupDetail({
    this.name,
    this.jumlah,
  });

  String? name;
  int? jumlah;

  factory SKListGroupDetail.fromJson(Map<String, dynamic> json) =>
      SKListGroupDetail(
        name: json['name'],
        jumlah: json['jumlah'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'jumlah': jumlah,
      };
}
