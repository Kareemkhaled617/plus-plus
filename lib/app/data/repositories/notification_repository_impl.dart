import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/network/api_service.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import '../models/notification_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final ApiService apiService;

  NotificationRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    final response = await apiService.getRequest("notifications");

    if (response.success) {
      final sections = response.data['data']['sections'] as Map<String, dynamic>;

      final List<NotificationEntity> notifications = [];

      sections.forEach((key, value) {
        final List list = value as List;
        notifications.addAll(
          list.map((json) => NotificationModel.fromJson(json)).toList(),
        );
      });

      return Right(notifications);
    } else {
      return Left(
        Failure(response.message ?? "Failed to load notifications",
            statusCode: response.statusCode),
      );
    }
  }


  @override
  Future<Either<Failure, void>> markNotificationAsRead(
      String notificationId) async {
    final formData = FormData.fromMap({'notification_id': notificationId});
    final response = await apiService.postFormDataRequest(
        "notifications/mark-as-read-by-id", formData);

    if (response.success) {
      return const Right(null);
    } else {
      return Left(
          Failure(response.message ?? "Failed to mark notification as read"));
    }
  }

  @override
  Future<Either<Failure, void>> markAllNotificationsAsRead() async {
    final response =
        await apiService.postRequest("notifications/mark-all-as-read", {});

    if (response.success) {
      return const Right(null);
    } else {
      return Left(Failure(
          response.message ?? "Failed to mark all notifications as read"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNotification(
      String notificationId) async {
    final formData = FormData.fromMap({'notification_id': notificationId});
    final response = await apiService.postFormDataRequest(
        "notifications/delete-by-id", formData);

    if (response.success) {
      return const Right(null);
    } else {
      return Left(Failure(response.message ?? "Failed to delete notification"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAllNotifications() async {
    final response =
        await apiService.postRequest("notifications/delete-all", {});

    if (response.success) {
      return const Right(null);
    } else {
      return Left(
          Failure(response.message ?? "Failed to delete all notifications"));
    }
  }
}
