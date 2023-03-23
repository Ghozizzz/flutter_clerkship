// To parse this JSON data, do
//
//     final scoringDetailResponse = scoringDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:clerkship/ui/components/buttons/quiz_button.dart';
import 'package:fleather/fleather.dart';

ScoringDetailResponse scoringDetailResponseFromJson(String str) =>
    ScoringDetailResponse.fromJson(json.decode(str));

String scoringDetailResponseToJson(ScoringDetailResponse data) =>
    json.encode(data.toJson());

class ScoringDetailResponse {
  ScoringDetailResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory ScoringDetailResponse.fromJson(Map<String, dynamic> json) =>
      ScoringDetailResponse(
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

  Header? header;
  List<ScoringDetail>? detail;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        header: json['header'] == null ? null : Header.fromJson(json['header']),
        detail: json['detail'] == null
            ? []
            : List<ScoringDetail>.from(
                json['detail']!.map((x) => ScoringDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'header': header?.toJson(),
        'detail': detail == null
            ? []
            : List<dynamic>.from(detail!.map((x) => x.toJson())),
      };
}

class ScoringDetail {
  ScoringDetail({
    this.idSection,
    this.idTipe,
    this.namaSection,
    this.dataDetail,
  });

  int? idSection;
  int? idTipe;
  String? namaSection;
  List<Assessment>? dataDetail;

  factory ScoringDetail.fromJson(Map<String, dynamic> json) => ScoringDetail(
        idSection: json['id_section'],
        idTipe: json['id_tipe'],
        namaSection: json['nama_section'],
        dataDetail: json['data_detail'] == null
            ? []
            : List<Assessment>.from(
                json['data_detail']!.map((x) => Assessment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id_section': idSection,
        'id_tipe': idTipe,
        'nama_section': namaSection,
        'data_detail': dataDetail == null
            ? []
            : List<dynamic>.from(dataDetail!.map((x) => x.toJson())),
      };
}

class Assessment {
  Assessment({
    this.idPertanyaan,
    this.pertanyaan,
    this.jawaban,
    this.jawabanString,
    this.selected = false,
  });

  int? idPertanyaan;
  String? pertanyaan;
  List<Answer>? jawaban;
  String? jawabanString;
  QuizController quizController = QuizController();
  FleatherController notesController = FleatherController();
  bool selected;

  factory Assessment.fromJson(Map<String, dynamic> json) => Assessment(
        idPertanyaan: json['id_pertanyaan'],
        pertanyaan: json['pertanyaan'],
        jawaban: json['jawaban'] is List
            ? json['jawaban'] == null
                ? []
                : List<Answer>.from(
                    json['jawaban']!.map((x) => Answer.fromJson(x)))
            : [],
        jawabanString: json['jawaban'] is String ? json['jawaban'] : '',
      );

  Map<String, dynamic> toJson() => {
        'id_pertanyaan': idPertanyaan,
        'pertanyaan': pertanyaan,
        'jawaban': jawaban == null
            ? []
            : List<dynamic>.from(jawaban!.map((x) => x.toJson())),
      };
}

class Answer {
  Answer({
    this.idJawaban,
    this.jawaban,
    this.isTrue,
  });

  int? idJawaban;
  String? jawaban;
  bool? isTrue;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        idJawaban: json['id_jawaban'],
        jawaban: json['jawaban'],
        isTrue: json['is_true'],
      );

  Map<String, dynamic> toJson() => {
        'id_jawaban': idJawaban,
        'jawaban': jawaban,
        'is_true': isTrue,
      };
}

class Header {
  Header({
    this.startDate,
    this.endDate,
    this.id,
    this.idBatch,
    this.idFeature,
    this.idUser,
    this.namaRs,
    this.name,
    this.nim,
  });

  DateTime? startDate;
  DateTime? endDate;
  int? id;
  int? idBatch;
  int? idFeature;
  int? idUser;
  String? namaRs;
  String? name;
  String? nim;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        startDate: json['start_date'] == null
            ? null
            : DateTime.parse(json['start_date']),
        endDate:
            json['end_date'] == null ? null : DateTime.parse(json['end_date']),
        id: json['id'],
        idBatch: json['id_batch'],
        idFeature: json['id_feature'],
        idUser: json['id_user'],
        namaRs: json['nama_rs'],
        name: json['name'],
        nim: json['nim'],
      );

  Map<String, dynamic> toJson() => {
        'start_date':
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        'end_date':
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        'id': id,
        'id_batch': idBatch,
        'id_feature': idFeature,
        'id_user': idUser,
        'nama_rs': namaRs,
        'name': name,
        'nim': nim,
      };
}
