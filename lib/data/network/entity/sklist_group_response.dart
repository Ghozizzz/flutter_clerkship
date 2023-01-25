// To parse this JSON data, do
//
//     final skListGroupResponse = skListGroupResponseFromJson(jsonString);

import 'dart:convert';

SkListGroupResponse skListGroupResponseFromJson(String str) =>
    SkListGroupResponse.fromJson(json.decode(str));

String skListGroupResponseToJson(SkListGroupResponse data) =>
    json.encode(data.toJson());

class SkListGroupResponse {
  SkListGroupResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<SKListGroup>? data;

  factory SkListGroupResponse.fromJson(Map<String, dynamic> json) =>
      SkListGroupResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] == null
            ? []
            : List<SKListGroup>.from(
                json['data']!.map((x) => SKListGroup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SKListGroup {
  SKListGroup({
    this.id,
    this.namaGroup,
  });

  int? id;
  String? namaGroup;

  factory SKListGroup.fromJson(Map<String, dynamic> json) => SKListGroup(
        id: json['id'],
        namaGroup: json['nama_group'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_group': namaGroup,
      };
}
