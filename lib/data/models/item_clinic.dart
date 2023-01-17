// To parse this JSON data, do
//
//     final itemClinic = itemClinicFromJson(jsonString);

import 'dart:convert';

List<ItemClinic?>? itemClinicFromJson(String str) => json.decode(str) == null
    ? []
    : List<ItemClinic?>.from(
        json.decode(str)!.map((x) => ItemClinic.fromJson(x)));

String itemClinicToJson(List<ItemClinic?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class ItemClinic {
  ItemClinic({
    this.id,
    this.idJenis,
    this.idItem,
    this.type,
    this.remarks,
    this.counter,
    this.flagDelete,
  });

  int? id;
  int? idJenis;
  int? idItem;
  int? type;
  String? remarks;
  int? counter;
  int? flagDelete;

  factory ItemClinic.fromJson(Map<String, dynamic> json) => ItemClinic(
        id: json['id'],
        idJenis: json['id_jenis'],
        idItem: json['id_item'],
        type: json['type'],
        remarks: json['remarks'],
        counter: json['counter'],
        flagDelete: json['flag_delete'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_jenis': idJenis,
        'id_item': idItem,
        'type': type,
        'remarks': remarks,
        'counter': counter,
        'flag_delete': flagDelete,
      };
}
