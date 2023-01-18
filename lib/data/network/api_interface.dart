import 'dart:io';

import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/entity/batch_response.dart';
import 'package:clerkship/data/network/entity/clinic_detail_response.dart';
import 'package:clerkship/data/network/entity/clinic_response.dart';
import 'package:clerkship/data/network/entity/login_response.dart';
import 'package:clerkship/data/network/entity/user_response.dart';

import 'entity/default_response.dart';
import 'entity/departemen_response.dart';
import 'entity/item_reference_response.dart';
import 'entity/scientific_detail_response.dart';
import 'entity/scientific_response.dart';

abstract class AuthApiInterface {
  Future<ResultData<LoginResponse>> doLogin({
    required String email,
    required String password,
  });
}

abstract class UserInterface {
  Future<ResultData<UserResponse>> getAllUser({
    required int role,
    required int idFeature,
  });
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
