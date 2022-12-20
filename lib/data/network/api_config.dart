import 'package:http_interceptor/http/intercepted_client.dart';

import '../../config/environment.dart';
import 'api_client.dart';

class ApiConfig {
  static final client = InterceptedClient.build(
    interceptors: [
      ApiClient(),
    ],
  );
  static const int timeout = 30000;
  static final String baseUrl = Environment().config.baseUrl;
}
