// lib/app/core/network/api_client.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart' as ge;

import '../storage/secure_storage_helper.dart';
import '../../routes/app_routes.dart';

class ApiClient {
  final Dio dio;

  // cache options are set once, but you can override per-request
  late final CacheOptions _cacheOptions;

  ApiClient._(this.dio, this._cacheOptions);

  static Future<ApiClient> create() async {
    // File store for persistent cache
    final Directory dir = await getTemporaryDirectory();
    final fileStore = FileCacheStore('${dir.path}/http_cache');

    final cacheOptions = CacheOptions(
      store: fileStore,
      policy: CachePolicy.request, // default: try network, fall back to cache
      hitCacheOnErrorExcept: [401, 403],
      priority: CachePriority.normal,
      maxStale: const Duration(days: 7),
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: false, // only cache GET by default
    );

    final dio = Dio(BaseOptions(
      baseUrl: 'https://plusp.msarweb.net/api/',
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      contentType: Headers.jsonContentType,
      headers: {
        'Accept': 'application/json',
        'BusinessId': '1',
        'User-Agent': 'PlusPlus/1.0 (Flutter; Dio)',
      },
    ));

    // Logging (debug only)
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
      ));
    }

    // Auth header injector
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await SecureStorageHelper().getData('auth_token');
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (e, handler) async {
        // 401 → logout
        final status = e.response?.statusCode;
        if (status == 401) {
          await SecureStorageHelper().clearAll();
          if (ge.Get.currentRoute != AppRoutes.login) {
            ge.Get.offAllNamed(AppRoutes.login);
          }
        }
        handler.next(e);
      },
    ));

    // Cache interceptor
    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));

    // Lightweight retry (on timeouts & some socket errors)
    dio.interceptors.add(InterceptorsWrapper(
      onError: (e, handler) async {
        final isTimeout = e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.sendTimeout;

        final isNetworkIssue =
            e.error is SocketException || e.type == DioExceptionType.connectionError;

        // retry only once for idempotent requests
        final canRetry = (e.requestOptions.method.toUpperCase() == 'GET') &&
            (isTimeout || isNetworkIssue) &&
            (e.requestOptions.extra['__retried__'] != true);

        if (canRetry) {
          await Future.delayed(const Duration(milliseconds: 350));
          final opts = e.requestOptions;
          opts.extra['__retried__'] = true;
          try {
            final res = await dio.fetch(opts);
            return handler.resolve(res);
          } catch (err) {
            // fallthrough to original error
          }
        }

        handler.next(e);
      },
    ));

    return ApiClient._(dio, cacheOptions);
  }

  /// Helpers to expose cacheOptions to services
  CacheOptions get cacheOptions => _cacheOptions;
}
