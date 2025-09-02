import 'package:dio/dio.dart';
import 'package:get/get.dart' as ge;
import '../storage/secure_storage_helper.dart';
import '../../routes/app_routes.dart';

class ApiClient {
  final Dio dio;

  ApiClient()
      : dio = Dio(
    BaseOptions(
      baseUrl: 'https://plusp.msarweb.net/api/',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
    ),
  ) {
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = await SecureStorageHelper().getData("auth_token");

        // Debugging logs
        print("🔹 Current Token: $token");

        if (token != null && token.isNotEmpty) {
          options.headers.addAll({
            'Accept': 'application/json',
            'BusinessId': '1',
            'Authorization': 'Bearer $token',
          });
        }

        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          print("🔴 Token Expired! Logging Out...");
          await SecureStorageHelper().clearAll();
          _redirectToLogin();
        }
        return handler.next(e);
      },
    ));
  }

  void _redirectToLogin() {
    if (ge.Get.currentRoute != AppRoutes.login) {
      ge.Get.offAllNamed(AppRoutes.login);
    }
  }
}
