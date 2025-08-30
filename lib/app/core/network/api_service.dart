// lib/app/core/network/api_service.dart
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import 'api_client.dart';
import 'api_response.dart';
import 'network_checker.dart';

class ApiService {
  late final ApiClient _client;

  ApiService._(this._client);

  static Future<ApiService> create() async {
    final client = await ApiClient.create();
    return ApiService._(client);
  }

  /// GET with cache controls:
  /// - [refresh]: ignores cache, fetches fresh, then updates cache
  /// - [cacheOnlyWhenOffline]: if offline -> serve stale cache only (no error)
  Future<ApiResponse> getRequest(
    String path, {
    Map<String, dynamic>? queryParams,
    bool refresh = false,
    bool cacheOnlyWhenOffline = true,
    CancelToken? cancelToken,
  }) async {
    final online = await NetworkChecker.isConnected();

    // Decide cache policy for this call
    final policy = refresh
        ? CachePolicy.refresh // always hit network & update cache
        : (online ? CachePolicy.request : CachePolicy.refresh);

    try {
      final response = await _client.dio.get(
        path,
        queryParameters: queryParams,
        options: _client.cacheOptions.copyWith(policy: policy).toOptions(),
        cancelToken: cancelToken,
      );
      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      // if offline and asked to serve cache-only, we already tried cacheStoreOnly above
      return ApiResponse.fromDioError(e);
    }
  }

  Future<ApiResponse> postRequest(
    String path,
    Map<String, dynamic> body, {
    CancelToken? cancelToken,
  }) async {
    if (!await NetworkChecker.isConnected()) {
      return ApiResponse.noInternet();
    }
    try {
      final response =
          await _client.dio.post(path, data: body, cancelToken: cancelToken);
      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.fromDioError(e);
    }
  }

  Future<ApiResponse> putRequest(
    String path,
    Map<String, dynamic> body, {
    CancelToken? cancelToken,
  }) async {
    if (!await NetworkChecker.isConnected()) {
      return ApiResponse.noInternet();
    }
    try {
      final response =
          await _client.dio.put(path, data: body, cancelToken: cancelToken);
      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.fromDioError(e);
    }
  }

  Future<ApiResponse> patchRequest(
    String path,
    Map<String, dynamic> body, {
    CancelToken? cancelToken,
  }) async {
    if (!await NetworkChecker.isConnected()) {
      return ApiResponse.noInternet();
    }
    try {
      final response =
          await _client.dio.patch(path, data: body, cancelToken: cancelToken);
      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.fromDioError(e);
    }
  }

  Future<ApiResponse> deleteRequest(
    String path, {
    CancelToken? cancelToken,
  }) async {
    if (!await NetworkChecker.isConnected()) {
      return ApiResponse.noInternet();
    }
    try {
      final response = await _client.dio.delete(path, cancelToken: cancelToken);
      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.fromDioError(e);
    }
  }

  Future<ApiResponse> postFormDataRequest(
    String path,
    FormData formData, {
    CancelToken? cancelToken,
  }) async {
    if (!await NetworkChecker.isConnected()) {
      return ApiResponse.noInternet();
    }
    try {
      final response = await _client.dio
          .post(path, data: formData, cancelToken: cancelToken);
      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.fromDioError(e);
    }
  }
}
