import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApiResponse<T> {
  final bool success;
  final int? statusCode;
  final String? message;
  final T? data;

  ApiResponse._({
    required this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory ApiResponse.success(T data) {
    return ApiResponse._(
      success: true,
      statusCode: 200,
      data: data,
    );
  }

  factory ApiResponse.error(String message, {int? statusCode}) {
    return ApiResponse._(
      success: false,
      message: message,
      statusCode: statusCode,
    );
  }

  factory ApiResponse.noInternet() {
    return ApiResponse._(
      success: false,
      message: 'No internet connection. Please check your network.'.tr,
      statusCode: 503,
    );
  }

  factory ApiResponse.fromDioError(DioException e) {
    String message = "An unexpected error occurred. Please try again.".tr;
    int? statusCode = e.response?.statusCode;

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      message = "Connection timed out. Please try again.".tr;
    } else if (e.type == DioExceptionType.badResponse) {
      message = _handleHttpError(statusCode, e.response?.data).tr;
    } else if (e.type == DioExceptionType.connectionError) {
      message = "Failed to connect. Please check your internet.".tr;
    } else if (e.type == DioExceptionType.cancel) {
      message = "Request was cancelled.".tr;
    } else {
      message = e.message?.tr ?? "An unexpected error occurred.".tr;
    }

    return ApiResponse._(
      success: false,
      message: message,
      statusCode: statusCode,
    );
  }

  static String _handleHttpError(int? statusCode, dynamic data) {
    switch (statusCode) {
      case 400:
        return data['message'] ?? 'Invalid request'.tr;
      case 401:
        return 'You are not authorized'.tr;
      case 403:
        return 'Access is forbidden'.tr;
      case 404:
        return 'Data not found'.tr;
      case 422:
        return data['message'] ?? 'Missing or invalid input'.tr;
      case 500:
        return 'Server error. Please try again later'.tr;
      default:
        return 'Something went wrong. Please try again'.tr;
    }
  }
}
