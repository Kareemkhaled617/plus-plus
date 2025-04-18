import 'package:get/get.dart';

import '../../../core/network/api_service.dart';
import '../../../data/repositories/notification_repository_impl.dart';
import '../../../domain/repositories/notification_repository.dart';
import '../../../domain/usecases/get_notifications_usecase.dart';

import '../controller/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());

    Get.lazyPut<NotificationRepository>(
        () => NotificationRepositoryImpl(Get.find<ApiService>()));

    Get.lazyPut<GetNotificationsUseCase>(() => GetNotificationsUseCase(
        repository: Get.find<NotificationRepository>()));

    Get.lazyPut<MarkNotificationAsReadUseCase>(() =>
        MarkNotificationAsReadUseCase(
            repository: Get.find<NotificationRepository>()));

    Get.lazyPut<MarkAllNotificationsAsReadUseCase>(() =>
        MarkAllNotificationsAsReadUseCase(
            repository: Get.find<NotificationRepository>()));

    Get.lazyPut<DeleteNotificationUseCase>(() => DeleteNotificationUseCase(
        repository: Get.find<NotificationRepository>()));

    Get.lazyPut<DeleteAllNotificationsUseCase>(() =>
        DeleteAllNotificationsUseCase(
            repository: Get.find<NotificationRepository>()));

    Get.put(NotificationController(
      Get.find<GetNotificationsUseCase>(),
      Get.find<MarkNotificationAsReadUseCase>(),
      Get.find<MarkAllNotificationsAsReadUseCase>(),
      Get.find<DeleteNotificationUseCase>(),
      Get.find<DeleteAllNotificationsUseCase>(),
    ));
  }
}
