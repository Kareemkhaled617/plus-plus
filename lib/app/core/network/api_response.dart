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
      message: 'No internet connection',
      statusCode: 503,
    );
  }

  factory ApiResponse.fromDioError(DioException e) {
    String message = "Something went wrong";
    int? statusCode = e.response?.statusCode;
    print(e.type);
    print(e.type);
    print(e.type);
    print(e.type);
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      message = "Connection timeout, please try again".tr;
    } else if (e.type == DioExceptionType.badResponse) {
      message = _handleHttpError(statusCode, e.response?.data);
    } else if (e.type == DioExceptionType.connectionError) {
      message = "Connection failed, please check your internet".tr;
    } else if (e.type == DioExceptionType.cancel) {
      message = "Request cancelled".tr;
    } else {
      message = e.message ?? "Unexpected error occurred".tr;
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
        return data['message'] ?? 'Bad request';
      case 401:
        return 'Unauthorized request';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Resource not found';
      case 422:
        return data['message'] ?? 'Missing Data';
      case 500:
        return 'Internal server error';
      default:
        return 'Unexpected error occurred';
    }
  }
}
