// To parse this JSON data, do
//
//     final itemReferenceResponse = itemReferenceResponseFromJson(jsonString);

import 'dart:convert';

ItemReferenceResponse itemReferenceResponseFromJson(String str) =>
    ItemReferenceResponse.fromJson(json.decode(str));

String itemReferenceResponseToJson(ItemReferenceResponse data) =>
    json.encode(data.toJson());

class ItemReferenceResponse {
  ItemReferenceResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<ItemReference>? data;

  factory ItemReferenceResponse.fromJson(Map<String, dynamic> json) =>
      ItemReferenceResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] == null
            ? null
            : List<ItemReference>.from(
                json['data'].map((x) => ItemReference.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ItemReference {
  ItemReference({
    this.id,
    this.idFeature,
    this.idJenis,
    this.idGroup,
    this.name,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idFeature;
  int? idJenis;
  int? idGroup;
  String? name;
  int? status;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ItemReference.fromJson(Map<String, dynamic> json) => ItemReference(
        id: json['id'],
        idFeature: json['id_feature'],
        idJenis: json['id_jenis'],
        idGroup: json['id_group'],
        name: json['name'],
        status: json['status'],
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
        'id_feature': idFeature,
        'id_jenis': idJenis,
        'id_group': idGroup,
        'name': name,
        'status': status,
        'created_by': createdBy,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
