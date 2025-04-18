import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;
import 'api_client.dart';
import 'api_response.dart';
import 'network_checker.dart';

class ApiService {
  final ApiClient _client = ApiClient();

  Future<ApiResponse> getRequest(String url,
      {Map<String, dynamic>? queryParams}) async {

    if (!await NetworkChecker.isConnected()) {
      return ApiResponse.noInternet();
    }

    try {
      final response = await _client.dio.get(url, queryParameters: queryParams);
      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.fromDioError(e);
    }
  }

  Future<ApiResponse> postRequest(String url, Map<String, dynamic> body) async {
    if (!await NetworkChecker.isConnected()) {
      return ApiResponse.noInternet();
    }

    try {
      final response = await _client.dio.post(url, data: body);
      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.fromDioError(e);
    }
  }

  Future<ApiResponse> patchRequest(String url, Map<String, dynamic> body) async {
    if (!await NetworkChecker.isConnected()) {
      return ApiResponse.noInternet();
    }

    try {
      final response = await _client.dio.patch(url, data: body);
      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.fromDioError(e);
    }
  }


  Future<ApiResponse> postFormDataRequest(String url, FormData formData) async {
    if (!await NetworkChecker.isConnected()) {
      return ApiResponse.noInternet();
    }

    try {
      final response = await _client.dio.post(
        url,
        data: formData,
      );
      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.fromDioError(e);
    }
  }

  Future<ApiResponse> putRequest(String url, Map<String, dynamic> body) async {
    if (!await NetworkChecker.isConnected()) {
      return ApiResponse.noInternet();
    }

    try {
      final response = await _client.dio.put(url, data: body);
      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.fromDioError(e);
    }
  }

  Future<ApiResponse> deleteRequest(String url) async {
    if (!await NetworkChecker.isConnected()) {
      return ApiResponse.noInternet();
    }

    try {
      final response = await _client.dio.delete(url);
      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.fromDioError(e);
    }
  }
}
