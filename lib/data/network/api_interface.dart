import 'dart:io';

import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/entity/batch_response.dart';
import 'package:clerkship/data/network/entity/clinic_detail_response.dart';
import 'package:clerkship/data/network/entity/clinic_response.dart';
import 'package:clerkship/data/network/entity/filter_kegiatan_response.dart';
import 'package:clerkship/data/network/entity/login_response.dart';
import 'package:clerkship/data/network/entity/sklist_group_detail.dart';
import 'package:clerkship/data/network/entity/sklist_jenis_response.dart';
import 'package:clerkship/data/network/entity/sklist_response.dart';
import 'package:clerkship/data/network/entity/users_response.dart';

import 'entity/clinic_lecture_response.dart';
import 'entity/default_response.dart';
import 'entity/departemen_response.dart';
import 'entity/item_reference_response.dart';
import 'entity/scientific_detail_response.dart';
import 'entity/scientific_response.dart';
import 'entity/sklist_group_response.dart';
import 'entity/user_response.dart';

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

abstract class StandardCompetencyInterface {
  Future<ResultData<SkListResponse>> getListSk();
  Future<ResultData<SkListJenisResponse>> getListSkJenis();
  Future<ResultData<SkListGroupResponse>> getListGroup(
      {required int idJenisSK});
  Future<ResultData<SkListGroupDetailResponse>> getListGroupDetail(
      {required int idGroup, required int idJenisSK, required int idBatch});
}
