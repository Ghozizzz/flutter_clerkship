import 'dart:convert';

CheckVersionResponse checkVersionResponseFromJson(String str) =>
    CheckVersionResponse.fromJson(json.decode(str));

String checkVersionResponseToJson(CheckVersionResponse data) =>
    json.encode(data.toJson());

class CheckVersionResponse {
  CheckVersionResponse({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  VersionData? data;

  factory CheckVersionResponse.fromJson(Map<String, dynamic> json) =>
      CheckVersionResponse(
        error: json['error'],
        message: json['message'],
        data: json['data'] == null ? null : VersionData.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'data': data?.toJson(),
      };
}

class VersionData {
  VersionData({
    this.version,
    this.hasUpdate,
  });

  String? version;
  bool? hasUpdate;

  factory VersionData.fromJson(Map<String, dynamic> json) => VersionData(
        version: json['version'],
        hasUpdate: json['has_update'],
      );

  Map<String, dynamic> toJson() => {
        'version': version,
        'has_update': hasUpdate,
      };
}
