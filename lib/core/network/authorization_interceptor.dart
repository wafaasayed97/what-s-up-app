import 'package:dio/dio.dart';
import '../cache/secure_storage/secure_storage.dart';
import '../di/services_locator.dart';
import '../helpers/safe_print.dart';

class AuthorizationInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await sl<SecureStorage>().read(SecureStorageKeys.userToken);
    if (options.headers['Authorization'] != "Bearer $token") {
      options.headers['Authorization'] = "Bearer $token";
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    safePrint('response.statusCode ${response.statusCode}');
    if (response.statusCode == 401) {
      safePrint("Unauthenticated. Redirecting to login...");
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      safePrint("Unauthenticated. Redirecting to login...");
    } else {
      safePrint("DioError: ${err.message}");
    }

    handler.next(err);
  }
}
