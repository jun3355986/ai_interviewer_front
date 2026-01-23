import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  static const String userBaseUrl = 'http://localhost:9001';
  static const String jobBaseUrl = 'http://localhost:9004';

  late Dio dio;

  ApiClient() {
    dio = Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('accessToken');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            // TODO: Implement refresh token logic
          }
          return handler.next(e);
        },
      ),
    );
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  // Helper to switch base URL or return a configured Dio instance
  Dio getServiceDio(String baseUrl) {
    dio.options.baseUrl = baseUrl;
    return dio;
  }
}
