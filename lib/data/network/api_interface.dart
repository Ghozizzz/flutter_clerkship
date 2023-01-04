import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/entity/default_response.dart';

abstract class AuthApiInterface {
  Future<ResultData<DefaultResponse>> doLogin({
    required String email,
    required String password,
  });
}
