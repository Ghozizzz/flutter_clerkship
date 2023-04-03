import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/api_interface.dart';
import 'package:clerkship/data/network/entity/get_feature_response.dart';
import 'package:flutter/cupertino.dart';

import '../api_config.dart';

class GetFeatureService extends GetFeatureInterface {
  final apiClient = ApiConfig.client;

  @override
  Future<ResultData<GetFeatureResponse>> getFeature({
    required int idBatch,
  }) async {
    final endpoint = '${ApiConfig.baseUrl}/get_feature';
    // debugPrint(endpoint);

    try {
      final response = await apiClient.post(Uri.parse(endpoint), body: {
        'id': idBatch.toString(),
      });
      // debugPrint(response.body);

      final getFeatureResponse = getFeatureDataResponseFromJson(response.body);
      return ResultData(
        data: getFeatureResponse,
        statusCode: response.statusCode,
      );
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
  }
}
