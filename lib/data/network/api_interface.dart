import 'package:clerkship/data/models/result_data.dart';
import 'package:clerkship/data/network/entity/login_response.dart';

abstract class AuthApiInterface {
  Future<ResultData<LoginResponse>> doLogin({
    required String email,
    required String password,
  });
}
