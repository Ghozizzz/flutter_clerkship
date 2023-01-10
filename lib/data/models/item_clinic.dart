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
    this.idJenis,
    this.idItem,
    this.type,
    this.remarks,
    this.counter,
  });

  int? idJenis;
  int? idItem;
  int? type;
  String? remarks;
  int? counter;

  factory ItemClinic.fromJson(Map<String, dynamic> json) => ItemClinic(
        idJenis: json['id_jenis'],
        idItem: json['id_item'],
        type: json['type'],
        remarks: json['remarks'],
        counter: json['counter'],
      );

  Map<String, dynamic> toJson() => {
        'id_jenis': idJenis,
        'id_item': idItem,
        'type': type,
        'remarks': remarks,
        'counter': counter,
      };
}
