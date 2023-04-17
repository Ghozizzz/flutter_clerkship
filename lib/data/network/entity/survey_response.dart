// To parse this JSON data, do
//
//     final SurveyResponse = surveyResponseFromJson(jsonString);

import 'dart:convert';

SurveyResponse surveyResponseFromJson(String str) =>
    SurveyResponse.fromJson(json.decode(str));

String surveyResponseToJson(SurveyResponse data) =>
    json.encode(data.toJson());

class SurveyResponse {
  SurveyResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<SurveyList>? data;

  factory SurveyResponse.fromJson(
          Map<String, dynamic> json) =>
      SurveyResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] == null
            ? []
            : List<SurveyList>.from(json['data']!
                .map((x) => SurveyList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SurveyList {
  SurveyList({
    this.id,
    this.startDate,
    this.endDate,
    this.namaDepartment,
    this.status,
    this.flagSurvey,
  });

  int? id;
  DateTime? startDate;
  DateTime? endDate;
  String? namaDepartment;
  int? status;
  int? flagSurvey;

  factory SurveyList.fromJson(Map<String, dynamic> json) =>
      SurveyList(
        id: json['id'],
        startDate:
            json['start_date'] == null ? null : DateTime.parse(json['start_date']),
        endDate:
            json['end_date'] == null ? null : DateTime.parse(json['end_date']),
        namaDepartment: json['nama_department'],
        status: json['status'],
        flagSurvey: json['flag_survey'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'start_date':
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        'end_date':
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        'nama_department': namaDepartment,
        'status': status,
        'flag_survey': flagSurvey
      };
}
