// To parse this JSON data, do
//
//     final itemScientific = itemScientificFromJson(jsonString);

import 'dart:convert';

List<ItemScientific?>? itemScientificFromJson(String str) =>
    json.decode(str) == null
        ? []
        : List<ItemScientific?>.from(
            json.decode(str)!.map((x) => ItemScientific.fromJson(x)));

String itemScientificToJson(List<ItemScientific?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class ItemScientific {
  ItemScientific({
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

  factory ItemScientific.fromJson(Map<String, dynamic> json) => ItemScientific(
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
