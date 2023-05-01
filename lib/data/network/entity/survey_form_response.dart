// To parse this JSON data, do
//
//     final surveyFormResponse = surveyFormResponseFromJson(jsonString);

import 'dart:convert';

SurveyFormResponse surveyFormResponseFromJson(String str) =>
    SurveyFormResponse.fromJson(json.decode(str));

String surveyFormResponseToJson(SurveyFormResponse data) =>
    json.encode(data.toJson());

class SurveyFormResponse {
  SurveyFormResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory SurveyFormResponse.fromJson(Map<String, dynamic> json) =>
      SurveyFormResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
      };
}

class Data {
  Data({
    this.header,
    this.detail,
  });

  SurveyCexHeader? header;
  List<SurveyCexForm>? detail;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        header:
            json['header'] == null ? null : SurveyCexHeader.fromJson(json['header']),
        detail: json['detail'] == null
            ? []
            : List<SurveyCexForm>.from(
                json['detail']!.map((x) => SurveyCexForm.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'header': header?.toJson(),
        'detail': detail == null
            ? []
            : List<dynamic>.from(detail!.map((x) => x.toJson())),
      };
}

class SurveyCexForm {
  SurveyCexForm({
    this.id,
    this.jenisSurvey,
    this.description,
    this.nilai
  });

  int? id;
  int? jenisSurvey;
  String? description;
  String? nilai;

  factory SurveyCexForm.fromJson(Map<String, dynamic> json) => SurveyCexForm(
        id: json['id'],
        jenisSurvey: json['jenis_survey'],
        description: json['description'],
        nilai: json['nilai'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'jenis_survey': jenisSurvey,
        'keterangan': description,
        'nilai': nilai,
      };
}

class SurveyCexHeader {
  SurveyCexHeader({
    this.id,
    this.namaDepartment,
    this.namaBatch,
    this.startDate,
    this.endDate,
  });

  int? id;
  String? namaDepartment;
  String? namaBatch;
  String? startDate;
  String? endDate;

  factory SurveyCexHeader.fromJson(Map<String, dynamic> json) => SurveyCexHeader(
        id: json['id'],
        namaDepartment: json['nama_department'],
        namaBatch: json['nama_batch'],
        startDate: json['start_Date'],
        endDate: json['end_date'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_department': namaDepartment,
        'nama_batch': namaBatch,
        'start_Date': startDate,
        'end_date': endDate,
      };
}
