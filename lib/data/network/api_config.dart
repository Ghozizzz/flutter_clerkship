import 'package:http_interceptor/http/intercepted_client.dart';

import '../../config/environment.dart';
import 'api_client.dart';

class ApiConfig {
  static const int timeout = 30000;

  static final client = InterceptedClient.build(
    interceptors: [
      ApiClient(),
    ],
    // Without this, a hung connection (e.g. a WAF/proxy that accepts the
    // request but never responds) leaves the caller's `await` stuck
    // forever — no response, no exception, no way for the try/catch in
    // each service to ever run. TimeoutException lets those existing
    // catch blocks do their job instead of the UI spinning indefinitely.
    requestTimeout: const Duration(milliseconds: timeout),
  );
  static final String baseUrl = Environment().config.baseUrl;
}
