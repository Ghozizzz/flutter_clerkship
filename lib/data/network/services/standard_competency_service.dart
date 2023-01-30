import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/api_interface.dart';
import 'package:clerkship/data/network/entity/sklist_group_detail.dart';
import 'package:clerkship/data/network/entity/sklist_jenis_response.dart';
import 'package:clerkship/data/network/entity/sklist_response.dart';
import 'package:flutter/cupertino.dart';

import '../api_config.dart';
import '../entity/sklist_group_response.dart';

class StandardCompetencyService extends StandardCompetencyInterface {
  final apiClient = ApiConfig.client;

  @override
  Future<ResultData<SkListResponse>> getListSk() async {
    final endpoint = '${ApiConfig.baseUrl}/sk/list';
    debugPrint(endpoint);

    try {
      final response = await apiClient.post(Uri.parse(endpoint));
      debugPrint(response.body);

      final skListResponse = skListResponseFromJson(response.body);
      return ResultData(
        data: skListResponse,
        statusCode: response.statusCode,
      );
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
  }

  @override
  Future<ResultData<SkListJenisResponse>> getListSkJenis() async {
    final endpoint = '${ApiConfig.baseUrl}/sk/list_detail';
    debugPrint(endpoint);

    try {
      final response = await apiClient.post(Uri.parse(endpoint));
      debugPrint(response.body);

      final skListJenisResponse = skListJenisResponseFromJson(response.body);
      return ResultData(
        data: skListJenisResponse,
        statusCode: response.statusCode,
      );
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
  }

  @override
  Future<ResultData<SkListGroupResponse>> getListGroup(
      {required int idJenisSK}) async {
    final endpoint = '${ApiConfig.baseUrl}/sk/list_detail_group';
    debugPrint(endpoint);

    try {
      final response = await apiClient.post(Uri.parse(endpoint), body: {
        'id': idJenisSK.toString(),
      });
      debugPrint(response.body);

      final skListGroupResponse = skListGroupResponseFromJson(response.body);
      return ResultData(
        data: skListGroupResponse,
        statusCode: response.statusCode,
      );
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
  }

  @override
  Future<ResultData<SkListGroupDetailResponse>> getListGroupDetail({
    required int idGroup,
    required int idJenisSK,
    required int idBatch,
  }) async {
    final endpoint = '${ApiConfig.baseUrl}/sk/list_detailed';
    debugPrint(endpoint);

    try {
      final response = await apiClient.post(Uri.parse(endpoint), body: {
        'id_group': idGroup.toString(),
        'id_jenis': idJenisSK.toString(),
        'id_batch': idBatch.toString(),
      });
      debugPrint(response.body);

      final skListGroupDetailResponse =
          skListGroupDetailResponseFromJson(response.body);
      return ResultData(
        data: skListGroupDetailResponse,
        statusCode: response.statusCode,
      );
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
  }
}
