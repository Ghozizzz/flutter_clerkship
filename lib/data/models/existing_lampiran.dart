// To parse this JSON data, do
//
//     final existingLampiran = existingLampiranFromJson(jsonString);

import 'dart:convert';

List<ExistingLampiran?>? existingLampiranFromJson(String str) =>
    json.decode(str) == null
        ? []
        : List<ExistingLampiran?>.from(
            json.decode(str)!.map((x) => ExistingLampiran.fromJson(x)));

String existingLampiranToJson(List<ExistingLampiran?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class ExistingLampiran {
  ExistingLampiran({
    this.id,
    this.fileName,
    this.flagDelete,
  });

  int? id;
  String? fileName;
  int? flagDelete;

  factory ExistingLampiran.fromJson(Map<String, dynamic> json) =>
      ExistingLampiran(
        id: json['id'],
        fileName: json['file_name'],
        flagDelete: json['flag_delete'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'file_name': fileName,
        'flag_delete': flagDelete,
      };
}
