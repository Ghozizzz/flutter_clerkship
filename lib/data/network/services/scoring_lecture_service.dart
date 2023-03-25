import 'dart:convert';

import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/api_interface.dart';
import 'package:clerkship/data/network/entity/default_response.dart';
import 'package:clerkship/data/network/entity/scoring_response.dart';
import 'package:flutter/material.dart';

import '../api_helper.dart';
import '../entity/scoring_detail_response.dart';

class ScoringLectureService extends ScoringLectureInterface {
  @override
  Future<ResultData<ScoringResponse>> getScoring(int status) {
    return ApiHelper.post(
      route: 'dokter/scoring',
      parseJson: scoringResponseFromJson,
      body: {'status': '$status'},
    );
  }

  @override
  Future<ResultData<ScoringDetailResponse>> getDetailScoring({
    required String id,
    required String idUser,
    required String idRatingType,
  }) {
    final body = {
      'id': id,
      'id_user': idUser,
      'id_jenis_rating': idRatingType,
    };
    debugPrint(jsonEncode(body));
    return ApiHelper.post(
      route: 'dokter/scoring_rotasi',
      parseJson: scoringDetailResponseFromJson,
      body: body,
    );
  }

  @override
  Future<ResultData<DefaultResponse>> insertDetailScoring({
    required String idRatingType,
    required int id,
    required int idBatch,
    required int idUser,
    required int status,
    required List<ScoringDetail> data,
  }) {
    final answer = [];

    for (ScoringDetail itemData in data) {
      if (itemData.idTipe == 0) {
        for (Assessment assessment in itemData.dataDetail ?? []) {
          answer.add({
            'id_section': itemData.idSection,
            'id_tipe': itemData.idTipe,
            'pertanyaan': assessment.idPertanyaan,
            'jawaban': assessment.quizController.selected?.idJawaban,
          });
        }
      } else {
        answer.add({
          'id_section': itemData.idSection,
          'id_tipe': itemData.idTipe,
          'pertanyaan': itemData.dataDetail?.first.idPertanyaan,
          'jawaban': jsonEncode(
              itemData.dataDetail?.first.notesController.document.toJson()),
        });
      }
    }

    final body = {
      'id_jenis_rating': idRatingType,
      'id': id,
      'id_batch': idBatch,
      'id_user': idUser,
      'status': status,
      'detail': answer,
    };

    debugPrint(jsonEncode(body));

    return ApiHelper.post(
      route: 'dokter/scoring_insert',
      parseJson: defaultResponseFromJson,
      body: jsonEncode(body),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
  }
}
