import 'dart:io';

import 'package:clerkship/data/network/entity/department_lecture_response.dart';
import 'package:clerkship/data/network/entity/get_feature_response.dart';
import 'package:clerkship/data/network/entity/scientific_event_lecture_response.dart';
import 'package:clerkship/data/network/entity/scoring_response.dart';
import 'package:clerkship/data/network/services/scoring_recap_response.dart';

import '../models/result_data.dart';
import 'entity/batch_response.dart';
import 'entity/clinic_detail_response.dart';
import 'entity/clinic_lecture_response.dart';
import 'entity/clinic_response.dart';
import 'entity/default_response.dart';
import 'entity/departemen_response.dart';
import 'entity/filter_kegiatan_response.dart';
import 'entity/item_reference_response.dart';
import 'entity/login_response.dart';
import 'entity/mini_cex_form_response.dart';
import 'entity/scientifc_event_participant_response.dart';
import 'entity/scientific_detail_response.dart';
import 'entity/scientific_response.dart';
import 'entity/scoring_detail_response.dart';
import 'entity/sklist_group_detail.dart';
import 'entity/sklist_group_response.dart';
import 'entity/sklist_jenis_response.dart';
import 'entity/sklist_response.dart';
import 'entity/user_response.dart';
import 'entity/users_response.dart';
import 'entity/survey_response.dart';
import 'entity/survey_form_response.dart';

abstract class AuthApiInterface {
  Future<ResultData<LoginResponse>> doLogin({
    required String email,
    required String password,
  });

  Future<ResultData> doLogout();
}

abstract class UserInterface {
  Future<ResultData<UsersResponse>> getAllUser({
    required int role,
    required int idFeature,
  });

  Future<ResultData<UserResponse>> getCurrentUser();
}

abstract class ReferenceApiInterface {
  Future<ResultData<DepartemenResponse>> getDepartemen();
  Future<ResultData<BatchResponse>> getBatch({
    final int? idFlow,
    final int? idFeature,
    final int? status,
  });
  Future<ResultData<ItemReferenceResponse>> getReferenceItem({
    required int idFeature,
    required int idJenis,
  });
  Future<ResultData<FilterKegiatanResponse>> getFilterKegiatan();
}

abstract class ClinicActivityInterface {
  Future<ResultData<DefaultResponse>> addClinicActivity({
    required int idBatch,
    required int idPreseptor,
    required String tanggal,
    required String jam,
    required String remarks,
    required String status,
    required String item,
    required List<File> lampiran,
  });
  Future<ResultData<DefaultResponse>> updateClinicActivity({
    required int id,
    required int idBatch,
    required int idPreseptor,
    required String tanggal,
    required String jam,
    required String remarks,
    required String status,
    required String item,
    required String existingLampiran,
    required List<File> lampiran,
  });
  Future<ResultData<ClinicDetailResponse>> getDetailClinic({required int id});
  Future<ResultData<ClinicResponse>> getListClinic({final int? status});
  Future<ResultData<DefaultResponse>> deleteClinic({required int id});
}

abstract class ClinicActivityLectureInterface {
  Future<ResultData<ClinicLectureResponse>> getListActivities({
    required int status,
    int? idKegiatan,
    DateTime? date,
  });

  Future<ResultData<DefaultResponse>> approveActivity({
    required List<Map<String, String>> data,
  });

  Future<ResultData<DefaultResponse>> rejectActivity({
    required List<Map<String, String>> data,
  });

  Future<ResultData<MiniCexFormResponse>> getMiniCexForm(String id);

  Future<ResultData<DefaultResponse>> approveMiniCexForm({
    required String id,
    required List<Map<String, String>> data,
  });
}

abstract class ScientificActivityInterface {
  Future<ResultData<DefaultResponse>> addScientificActivity({
    required int idBatch,
    required int idPreseptor,
    required String tanggal,
    required String jam,
    required String remarks,
    required String status,
    required String topik,
    required int idPeran,
    required String item,
    required List<File> lampiran,
  });
  Future<ResultData<DefaultResponse>> updateScientificActivity({
    required int id,
    required int idBatch,
    required int idPreseptor,
    required String tanggal,
    required String jam,
    required String remarks,
    required String status,
    required String item,
    required String existingLampiran,
    required String topik,
    required int idPeran,
    required List<File> lampiran,
  });
  Future<ResultData<ScientificDetailResponse>> getDetailScientific(
      {required int id});
  Future<ResultData<ScientificResponse>> getListScientific({final int? status});
  Future<ResultData<DefaultResponse>> deleteScientific({required int id});
}

abstract class ScientificEventLectureInterface {
  Future<ResultData<ScientificEventParticipantResponse>> getParticipant();

  Future<ResultData<ScientificEventLectureResponse>> getEvent({
    required int status,
    required int idUser,
    required int idKegiatan,
    DateTime? date,
  });
}

abstract class StandardCompetencyInterface {
  Future<ResultData<SkListResponse>> getListSk();
  Future<ResultData<SkListJenisResponse>> getListSkJenis();
  Future<ResultData<SkListGroupResponse>> getListGroup({
    required String idJenisSK,
    required String idBatch,
  });
  Future<ResultData<SkListGroupDetailResponse>> getListGroupDetail(
      {required int idGroup, required int idJenisSK, required int idBatch});
}

abstract class StandartCompetencyLectureInterface {
  Future<ResultData<DepartmentLectureResponse>> getDepartement(
    int userId,
  );
  Future<ResultData<SkListGroupDetailResponse>> getListGroupDetail(
    Map<String, String> dataIds,
  );
}

abstract class ScoringLectureInterface {
  Future<ResultData<ScoringResponse>> getScoring(int status);

  Future<ResultData<ScoringRecapResponse>> getScoringRecap(int id);

  Future<ResultData<ScoringDetailResponse>> getDetailScoring({
    required String id,
    required String idUser,
    required String idRatingType,
  });

  Future<ResultData<DefaultResponse>> insertDetailScoring({
    required String idRatingType,
    required int id,
    required int idBatch,
    required int idUser,
    required int status,
    required List<ScoringDetail> data,
  });
}

abstract class GetFeatureInterface {
  Future<ResultData<GetFeatureResponse>> getFeature({required int idBatch});
}

abstract class SurveyInterface {
  Future<ResultData<SurveyResponse>> getSurveyList();
  Future<ResultData<SurveyFormResponse>> getSurveyFormDetail(String id);
  Future<ResultData<DefaultResponse>> approveSurveyForm({
    required String id,
    required List<Map<String, String>> data,
  });
}
