import 'dart:io';

import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/entity/batch_response.dart';
import 'package:clerkship/data/network/entity/clinic_response.dart';
import 'package:clerkship/data/network/entity/login_response.dart';
import 'package:clerkship/data/network/entity/user_response.dart';

import 'entity/default_response.dart';
import 'entity/departemen_response.dart';
import 'entity/item_reference_response.dart';

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
  Future<ResultData<ClinicResponse>> getListClinic({final int? status});
}
